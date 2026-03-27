import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'mock_route_service.dart';

class RouteMapService {
  static final RouteMapService _instance = RouteMapService._internal();
  factory RouteMapService() => _instance;
  RouteMapService._internal();

  // Default location (India Gate, New Delhi)
  static const LatLng _defaultLocation = LatLng(28.6139, 77.2090);
  
  loc.Location? _locationService;
  bool _locationServiceEnabled = false;
  loc.PermissionStatus? _permissionGranted;
  LatLng? _currentLocation;

  // Initialize location service
  Future<void> initializeLocationService() async {
    _locationService = loc.Location();
    
    // Check if location service is enabled
    _locationServiceEnabled = await _locationService!.serviceEnabled();
    if (!_locationServiceEnabled) {
      _locationServiceEnabled = await _locationService!.requestService();
      if (!_locationServiceEnabled) {
        if (kDebugMode) {
          print('Location service is not enabled');
        }
        return;
      }
    }

    // Check for permissions
    _permissionGranted = await _locationService!.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _locationService!.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        if (kDebugMode) {
          print('Location permission not granted');
        }
        return;
      }
    }

    // Get current location
    try {
      final locationData = await _locationService!.getLocation();
      _currentLocation = LatLng(
        locationData.latitude ?? _defaultLocation.latitude,
        locationData.longitude ?? _defaultLocation.longitude,
      );
      if (kDebugMode) {
        print('Current location: $_currentLocation');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      _currentLocation = _defaultLocation;
    }
  }

  // Get current location or default
  LatLng getCurrentLocation() {
    return _currentLocation ?? _defaultLocation;
  }

  // Get markers from routes
  Future<List<Marker>> getRouteMarkers() async {
    final markers = <Marker>[];
    final routes = await MockRouteService().getRoutes();
    
    for (final route in routes) {
      final location = _getRouteLocation(route);
      final marker = Marker(
        markerId: MarkerId(route.id),
        position: location,
        infoWindow: InfoWindow(
          title: route.title,
          snippet: '${route.distance.toStringAsFixed(1)} km • ${route.rating.toStringAsFixed(1)} ⭐',
        ),
        icon: _getMarkerIcon(route.difficulty),
      );
      markers.add(marker);
    }
    
    return markers;
  }

  // Get polylines for routes
  Future<List<Polyline>> getRoutePolylines() async {
    final polylines = <Polyline>[];
    final routes = await MockRouteService().getRoutes();
    
    for (final route in routes) {
      final coordinates = _generateRouteCoordinates(route);
      final polyline = Polyline(
        polylineId: PolylineId(route.id),
        color: _getPolylineColor(route.difficulty),
        width: 4,
        points: coordinates,
      );
      polylines.add(polyline);
    }
    
    return polylines;
  }

  // Generate dummy coordinates for a route
  List<LatLng> _generateRouteCoordinates(MockRoute route) {
    final baseLocation = _getRouteLocation(route);
    final coordinates = <LatLng>[];
    final random = math.Random();
    
    // Generate 5-10 points for the route
    final pointCount = random.nextInt(6) + 5;
    
    for (int i = 0; i < pointCount; i++) {
      final latOffset = (random.nextDouble() - 0.5) * 0.02; // ~2km range
      final lngOffset = (random.nextDouble() - 0.5) * 0.02; // ~2km range
      
      coordinates.add(LatLng(
        baseLocation.latitude + latOffset,
        baseLocation.longitude + lngOffset,
      ));
    }
    
    return coordinates;
  }

  // Get route location based on title (fallback to default)
  LatLng _getRouteLocation(MockRoute route) {
    // Generate consistent location based on route title hash
    final hash = route.title.hashCode;
    final baseLat = _defaultLocation.latitude;
    final baseLng = _defaultLocation.longitude;
    
    // Create different locations for different routes
    final latOffset = ((hash % 100) - 50) * 0.001; // Small offset around default
    final lngOffset = (((hash ~/ 100) % 100) - 50) * 0.001;
    
    return LatLng(baseLat + latOffset, baseLng + lngOffset);
  }

  // Get marker icon based on difficulty
  BitmapDescriptor _getMarkerIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'moderate':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      case 'pro':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  // Get polyline color based on difficulty
  Color _getPolylineColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF4CAF50); // Green
      case 'moderate':
        return const Color(0xFFFFC107); // Yellow
      case 'pro':
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF2196F3); // Blue
    }
  }

  // Calculate camera bounds for all markers
  Future<CameraUpdate> getCameraBounds() async {
    final markers = await getRouteMarkers();
    
    if (markers.isEmpty) {
      return CameraUpdate.newCameraPosition(
        CameraPosition(target: _defaultLocation, zoom: 12),
      );
    }
    
    double minLat = markers.first.position.latitude;
    double maxLat = markers.first.position.latitude;
    double minLng = markers.first.position.longitude;
    double maxLng = markers.first.position.longitude;
    
    for (final marker in markers) {
      minLat = math.min(minLat, marker.position.latitude);
      maxLat = math.max(maxLat, marker.position.latitude);
      minLng = math.min(minLng, marker.position.longitude);
      maxLng = math.max(maxLng, marker.position.longitude);
    }
    
    final center = LatLng((minLat + maxLat) / 2, (minLng + maxLng) / 2);
    final zoom = _calculateZoom(minLat, maxLat, minLng, maxLng);
    
    return CameraUpdate.newCameraPosition(
      CameraPosition(target: center, zoom: zoom),
    );
  }

  // Calculate appropriate zoom level
  double _calculateZoom(double minLat, double maxLat, double minLng, double maxLng) {
    final latDiff = maxLat - minLat;
    final lngDiff = maxLng - minLng;
    final maxDiff = math.max(latDiff, lngDiff);
    
    if (maxDiff < 0.01) return 15.0;
    if (maxDiff < 0.05) return 13.0;
    if (maxDiff < 0.1) return 11.0;
    if (maxDiff < 0.5) return 9.0;
    return 7.0;
  }

  // Get route statistics for map display
  Map<String, dynamic> getMapStatistics() {
    final stats = MockRouteService().getStatistics();
    return {
      'totalRoutes': stats.totalRoutes,
      'totalDistance': stats.totalDistanceFormatted,
      'averageRating': stats.averageRatingFormatted,
      'difficultyDistribution': stats.difficultyDistribution,
    };
  }

  // Cleanup resources
  void dispose() {
    _locationService = null;
    _currentLocation = null;
  }
}
