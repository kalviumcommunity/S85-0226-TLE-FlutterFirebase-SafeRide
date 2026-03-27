import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/services/route_map_service.dart';
import '../../widgets/layout/responsive_layout.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final RouteMapService _mapService = RouteMapService();
  bool _isLoading = true;
  bool _isMapReady = false;
  String _error = '';
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    // Check if we're on web and Google Maps API is available
    if (kIsWeb) {
      try {
        // Wait for Google Maps script to load
        await _waitForGoogleMaps();
      } catch (e) {
        setState(() {
          _isLoading = false;
          _error = 'Google Maps failed to load: $e';
        });
        return;
      }
    }

    try {
      // Initialize location service
      await _mapService.initializeLocationService();
      
      // Load routes data
      await _loadMapData();
      
      setState(() {
        _isLoading = false;
        _isMapReady = true;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to initialize map: $e';
      });
    }
  }

  Future<void> _waitForGoogleMaps() async {
    if (kIsWeb) {
      // Wait for Google Maps to be available with timeout
      int attempts = 0;
      const maxAttempts = 30; // 6 seconds total timeout
      
      while (attempts < maxAttempts) {
        try {
          // For web, we'll try to create a simple map test
          // If Google Maps isn't loaded, this will fail when the actual map widget is created
          await Future.delayed(const Duration(milliseconds: 200));
          attempts++;
          
          // If we've waited enough time, proceed and let the map widget handle the error
          if (attempts >= maxAttempts) {
            // We'll let the GoogleMap widget handle the actual error
            break;
          }
        } catch (e) {
          // Continue trying
        }
      }
    }
  }

  Future<void> _loadMapData() async {
    try {
      // Get markers and polylines
      final markers = await _mapService.getRouteMarkers();
      final polylines = await _mapService.getRoutePolylines();
      
      setState(() {
        _markers = markers.toSet();
        _polylines = polylines.toSet();
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load routes: $e';
      });
    }
  }

  Future<void> _centerToCurrentLocation() async {
    if (_mapController != null && _isMapReady) {
      try {
        final currentLocation = _mapService.getCurrentLocation();
        await _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation,
              zoom: 14.0,
            ),
          ),
        );
      } catch (e) {
        setState(() {
          _error = 'Failed to center to location: $e';
        });
      }
    }
  }

  Future<void> _centerToAllMarkers() async {
    if (_mapController != null && _isMapReady) {
      try {
        final cameraUpdate = await _mapService.getCameraBounds();
        await _mapController!.animateCamera(cameraUpdate);
      } catch (e) {
        setState(() {
          _error = 'Failed to center to routes: $e';
        });
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    if (_isMapReady) {
      _mapController = controller;
      
      // Center to show all markers after map is created
      Future.delayed(const Duration(milliseconds: 500), () {
        _centerToAllMarkers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Map'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMapData,
            tooltip: 'Refresh Routes',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'center_current':
                  _centerToCurrentLocation();
                  break;
                case 'center_all':
                  _centerToAllMarkers();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'center_current',
                child: Row(
                  children: [
                    Icon(Icons.my_location),
                    SizedBox(width: 8),
                    Text('Center to My Location'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'center_all',
                child: Row(
                  children: [
                    Icon(Icons.center_focus_strong),
                    SizedBox(width: 8),
                    Text('Show All Routes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButtons(),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Map'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMapData,
            tooltip: 'Refresh Routes',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'center_current':
                  _centerToCurrentLocation();
                  break;
                case 'center_all':
                  _centerToAllMarkers();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'center_current',
                child: Row(
                  children: [
                    Icon(Icons.my_location),
                    SizedBox(width: 8),
                    Text('Center to My Location'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'center_all',
                child: Row(
                  children: [
                    Icon(Icons.center_focus_strong),
                    SizedBox(width: 8),
                    Text('Show All Routes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Map takes 2/3 of the space
          Expanded(
            flex: 2,
            child: _buildBody(),
          ),
          // Side panel takes 1/3 of the space
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Map Controls',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _centerToCurrentLocation,
                        icon: const Icon(Icons.my_location),
                        label: const Text('Center to My Location'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _centerToAllMarkers,
                        icon: const Icon(Icons.center_focus_strong),
                        label: const Text('Show All Routes'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _loadMapData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh Routes'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Statistics',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      _buildStatisticsPanel(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Map'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMapData,
            tooltip: 'Refresh Routes',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'center_current':
                  _centerToCurrentLocation();
                  break;
                case 'center_all':
                  _centerToAllMarkers();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'center_current',
                child: Row(
                  children: [
                    Icon(Icons.my_location),
                    SizedBox(width: 8),
                    Text('Center to My Location'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'center_all',
                child: Row(
                  children: [
                    Icon(Icons.center_focus_strong),
                    SizedBox(width: 8),
                    Text('Show All Routes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Map takes 3/4 of the space
          Expanded(
            flex: 3,
            child: _buildBody(),
          ),
          // Side panel takes 1/4 of the space
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Map Controls',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _centerToCurrentLocation,
                        icon: const Icon(Icons.my_location),
                        label: const Text('Center to My Location'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _centerToAllMarkers,
                        icon: const Icon(Icons.center_focus_strong),
                        label: const Text('Show All Routes'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _loadMapData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh Routes'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Statistics',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      _buildStatisticsPanel(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsPanel() {
    final stats = _mapService.getMapStatistics();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Routes: ${stats['totalRoutes']}'),
        Text('Total Distance: ${stats['totalDistance']}'),
        Text('Average Rating: ${stats['averageRating']}'),
        const SizedBox(height: 8),
        Text(
          'Difficulty Distribution:',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        ...stats['difficultyDistribution'].entries.map((entry) => 
          Text('${entry.key}: ${entry.value}')
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading map...'),
          ],
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Google Maps Error',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _error,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            if (kIsWeb) ...[
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  border: Border.all(color: Colors.orange[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'To fix this issue:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('1. Ensure billing is enabled in Google Cloud Console'),
                    const Text('2. Enable Maps JavaScript API'),
                    const Text('3. Check API key restrictions'),
                    const Text('4. Verify API key is valid'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: _initializeMap,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (!_isMapReady) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Initializing map...'),
          ],
        ),
      );
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _mapService.getCurrentLocation(),
        zoom: 12.0,
      ),
      markers: _markers,
      polylines: _polylines,
      myLocationEnabled: true,
      myLocationButtonEnabled: false, // We'll use custom FAB
      zoomControlsEnabled: true,
      mapToolbarEnabled: false,
      compassEnabled: true,
    );
  }

  Widget _buildFloatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Refresh button
        FloatingActionButton(
          heroTag: "refresh",
          onPressed: _loadMapData,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(height: 8),
        // Center to location button
        FloatingActionButton(
          heroTag: "location",
          onPressed: _centerToCurrentLocation,
          backgroundColor: Colors.green,
          child: const Icon(Icons.my_location),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _mapService.dispose();
    super.dispose();
  }
}
