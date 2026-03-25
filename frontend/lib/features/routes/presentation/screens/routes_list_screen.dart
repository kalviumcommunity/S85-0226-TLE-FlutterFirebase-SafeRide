import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../features/routes/providers/route_provider.dart';
import '../../../../widgets/common/dashboard_card.dart';
import '../../../../widgets/common/loading_widget.dart';
import '../../../../widgets/layout/responsive_layout.dart';

class RoutesListScreen extends StatefulWidget {
  const RoutesListScreen({super.key});

  @override
  State<RoutesListScreen> createState() => _RoutesListScreenState();
}

class _RoutesListScreenState extends State<RoutesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RouteProvider>().fetchRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddRouteDialog(),
          ),
        ],
      ),
      body: Consumer<RouteProvider>(
        builder: (context, routeProvider, child) {
          if (routeProvider.isLoading) {
            return const LoadingWidget();
          }

          if (routeProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${routeProvider.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => routeProvider.fetchRoutes(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ResponsiveLayout(
            mobile: _buildMobileLayout(routeProvider),
            tablet: _buildTabletLayout(routeProvider),
            desktop: _buildDesktopLayout(routeProvider),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(RouteProvider routeProvider) {
    final routes = RouteProvider.useMockData ? routeProvider.mockRoutes : routeProvider.routes;
    final isEmpty = RouteProvider.useMockData 
        ? routeProvider.mockRoutes.isEmpty 
        : routeProvider.routes.isEmpty;

    if (isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_bike, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No routes yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Add your first route to get started',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: routes.length,
      itemBuilder: (context, index) {
        final route = routes[index];
        final routeData = RouteProvider.useMockData 
            ? route as Map<String, dynamic>
            : (route as QueryDocumentSnapshot).data() as Map<String, dynamic>;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: DashboardCard(
            title: routeData['title'] ?? routeData['name'] ?? 'Unnamed Route',
            subtitle: _buildRouteSubtitle(routeData),
            icon: Icons.directions_bike,
            color: _getRouteColor(index),
            onTap: () => _showRouteDetails(route, routeData),
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout(RouteProvider routeProvider) {
    return _buildGridLayout(routeProvider, 2);
  }

  Widget _buildDesktopLayout(RouteProvider routeProvider) {
    return _buildGridLayout(routeProvider, 3);
  }

  Widget _buildGridLayout(RouteProvider routeProvider, int crossAxisCount) {
    final routes = RouteProvider.useMockData ? routeProvider.mockRoutes : routeProvider.routes;
    final isEmpty = RouteProvider.useMockData 
        ? routeProvider.mockRoutes.isEmpty 
        : routeProvider.routes.isEmpty;

    if (isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_bike, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No routes yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Add your first route to get started',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          final routeData = RouteProvider.useMockData 
              ? route as Map<String, dynamic>
              : (route as QueryDocumentSnapshot).data() as Map<String, dynamic>;
          
          return DashboardCard(
            title: routeData['title'] ?? routeData['name'] ?? 'Unnamed Route',
            subtitle: _buildRouteSubtitle(routeData),
            icon: Icons.directions_bike,
            color: _getRouteColor(index),
            onTap: () => _showRouteDetails(route, routeData),
          );
        },
      ),
    );
  }

  Color _getRouteColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }

  void _showAddRouteDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final distanceController = TextEditingController();
    final ratingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Route'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Route Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: distanceController,
              decoration: const InputDecoration(
                labelText: 'Distance (km)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ratingController,
              decoration: const InputDecoration(
                labelText: 'Rating (0-5)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isNotEmpty) {
                final routeData = {
                  'name': nameController.text.trim(),
                  'title': nameController.text.trim(), // For mock data compatibility
                  'description': descriptionController.text.trim(),
                  'distance': double.tryParse(distanceController.text) ?? 0.0,
                  'rating': double.tryParse(ratingController.text) ?? 0.0,
                  'createdAt': FieldValue.serverTimestamp(),
                };
                
                final navigator = Navigator.of(context);
                await context.read<RouteProvider>().addRoute(routeData);
                if (mounted) {
                  navigator.pop();
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showRouteDetails(dynamic route, Map<String, dynamic> routeData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(routeData['title'] ?? routeData['name'] ?? 'Unnamed Route'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${routeData['description'] ?? 'No description'}'),
            const SizedBox(height: 8),
            if (routeData['distance'] != null)
              Text('Distance: ${routeData['distance'].toStringAsFixed(1)} km'),
            const SizedBox(height: 8),
            if (routeData['rating'] != null)
              Text('Rating: ${routeData['rating'].toStringAsFixed(1)} ⭐'),
            const SizedBox(height: 8),
            if (routeData['createdAt'] != null)
              Text('Created: ${_formatTimestamp(routeData['createdAt'])}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              final routeId = routeData['id']?.toString() ?? 
                           (route as QueryDocumentSnapshot?)?.id ?? '';
              if (routeId.isNotEmpty) {
                final navigator = Navigator.of(context);
                await context.read<RouteProvider>().deleteRoute(routeId);
                if (mounted) {
                  navigator.pop();
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _buildRouteSubtitle(Map<String, dynamic> routeData) {
    final parts = <String>[];
    
    if (routeData['description'] != null && 
        routeData['description'].toString().isNotEmpty) {
      parts.add(routeData['description']);
    }
    
    if (routeData['distance'] != null) {
      parts.add('${routeData['distance'].toStringAsFixed(1)} km');
    }
    
    if (routeData['rating'] != null) {
      parts.add('${routeData['rating'].toStringAsFixed(1)} ⭐');
    }
    
    return parts.isNotEmpty ? parts.join(' • ') : 'No details';
  }

  String _formatTimestamp(dynamic timestamp) {
    DateTime date;
    
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is DateTime) {
      date = timestamp;
    } else {
      date = DateTime.now();
    }
    
    return '${date.day}/${date.month}/${date.year}';
  }
}
