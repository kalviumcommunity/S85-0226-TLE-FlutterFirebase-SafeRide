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
    if (routeProvider.routes.isEmpty) {
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
      itemCount: routeProvider.routes.length,
      itemBuilder: (context, index) {
        final route = routeProvider.routes[index];
        final data = route.data() as Map<String, dynamic>;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: DashboardCard(
            title: data['name'] ?? 'Unnamed Route',
            subtitle: data['description'] ?? 'No description',
            icon: Icons.directions_bike,
            color: _getRouteColor(index),
            onTap: () => _showRouteDetails(route),
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
    if (routeProvider.routes.isEmpty) {
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
        itemCount: routeProvider.routes.length,
        itemBuilder: (context, index) {
          final route = routeProvider.routes[index];
          final data = route.data() as Map<String, dynamic>;
          
          return DashboardCard(
            title: data['name'] ?? 'Unnamed Route',
            subtitle: data['description'] ?? 'No description',
            icon: Icons.directions_bike,
            color: _getRouteColor(index),
            onTap: () => _showRouteDetails(route),
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
                  'description': descriptionController.text.trim(),
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

  void _showRouteDetails(DocumentSnapshot route) {
    final data = route.data() as Map<String, dynamic>;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(data['name'] ?? 'Unnamed Route'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${data['description'] ?? 'No description'}'),
            const SizedBox(height: 8),
            if (data['createdAt'] != null)
              Text('Created: ${_formatTimestamp(data['createdAt'])}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await context.read<RouteProvider>().deleteRoute(route.id);
              if (mounted) {
                navigator.pop();
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}
