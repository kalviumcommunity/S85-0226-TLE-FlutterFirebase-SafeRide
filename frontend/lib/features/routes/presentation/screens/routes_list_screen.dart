import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../features/routes/providers/route_provider.dart';
import '../../../../widgets/common/cycling_route_card.dart';
import '../../../../widgets/common/cycling_logo.dart';
import '../../../../widgets/common/loading_widget.dart';
import '../../../../widgets/layout/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import 'route_detail_screen.dart';

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
        title: const CyclingLogo(size: 40, showText: true),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder),
              color: AppColors.glassSurface,
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddRouteDialog(),
            ),
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
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.neonPink.withValues(alpha:0.2),
                          AppColors.cyclingRed.withValues(alpha:0.1),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.neonPink.withValues(alpha:0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.error_outline,
                      color: AppColors.neonPink,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Error loading routes',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    routeProvider.errorMessage!,
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.neonCyan,
                          AppColors.neonBlue,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonCyan.withValues(alpha:0.4),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => routeProvider.fetchRoutes(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.primaryBackground,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Retry'),
                    ),
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonCyan.withValues(alpha:0.2),
                    AppColors.neonBlue.withValues(alpha:0.1),
                  ],
                ),
                border: Border.all(
                  color: AppColors.neonCyan.withValues(alpha:0.5),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.directions_bike,
                color: AppColors.neonCyan,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No routes yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first cycling route to get started',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    AppColors.cyclingGreen,
                    AppColors.beginnerGreen,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyclingGreen.withValues(alpha:0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => _showAddRouteDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.primaryBackground,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Add Your First Route'),
              ),
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
          child: CyclingRouteCard(
            title: routeData['title'] ?? routeData['name'] ?? 'Unnamed Route',
            description: routeData['description'] ?? 'No description available',
            distance: (routeData['distance'] ?? 0.0).toDouble(),
            rating: (routeData['rating'] ?? 0.0).toDouble(),
            difficulty: _getDifficultyFromDistance(routeData['distance'] ?? 0.0),
            elevation: _getRandomElevation(),
            isFavorite: (routeData['rating'] ?? 0.0) >= 4.5,
            onTap: () => _showRouteDetails(route, routeData),
            onFavoriteToggle: () => _toggleFavorite(route, routeData),
            primaryColor: _getRouteColor(index),
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonCyan.withValues(alpha:0.2),
                    AppColors.neonBlue.withValues(alpha:0.1),
                  ],
                ),
                border: Border.all(
                  color: AppColors.neonCyan.withValues(alpha:0.5),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.directions_bike,
                color: AppColors.neonCyan,
                size: 80,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No cycling routes available',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Start building your collection of amazing cycling routes',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.secondaryText,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    AppColors.cyclingGreen,
                    AppColors.beginnerGreen,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyclingGreen.withValues(alpha:0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => _showAddRouteDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.primaryBackground,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Create Your First Route',
                  style: TextStyle(fontSize: 16),
                ),
              ),
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
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          final routeData = RouteProvider.useMockData 
              ? route as Map<String, dynamic>
              : (route as QueryDocumentSnapshot).data() as Map<String, dynamic>;
          
          return CyclingRouteCard(
            title: routeData['title'] ?? routeData['name'] ?? 'Unnamed Route',
            description: routeData['description'] ?? 'No description available',
            distance: (routeData['distance'] ?? 0.0).toDouble(),
            rating: (routeData['rating'] ?? 0.0).toDouble(),
            difficulty: _getDifficultyFromDistance(routeData['distance'] ?? 0.0),
            elevation: _getRandomElevation(),
            isFavorite: (routeData['rating'] ?? 0.0) >= 4.5,
            onTap: () => _showRouteDetails(route, routeData),
            onFavoriteToggle: () => _toggleFavorite(route, routeData),
            primaryColor: _getRouteColor(index),
          );
        },
      ),
    );
  }

  Color _getRouteColor(int index) {
    final colors = [
      AppColors.neonCyan,
      AppColors.cyclingGreen,
      AppColors.neonBlue,
      AppColors.neonPurple,
      AppColors.cyclingOrange,
      AppColors.neonPink,
    ];
    return colors[index % colors.length];
  }

  String _getDifficultyFromDistance(double distance) {
    if (distance < 5) {
      return 'Beginner';
    } else if (distance < 10) {
      return 'Moderate';
    } else {
      return 'Pro';
    }
  }

  double _getRandomElevation() {
    // Generate realistic elevation based on route difficulty
    final elevations = [25.0, 45.0, 80.0, 120.0, 180.0, 250.0];
    return elevations[(DateTime.now().millisecondsSinceEpoch % elevations.length)];
  }

  void _toggleFavorite(dynamic route, Map<String, dynamic> routeData) {
    // Toggle favorite logic - could be expanded to update in backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${routeData['title']} ${routeData['rating'] >= 4.5 ? 'removed from' : 'added to'} favorites',
        ),
        backgroundColor: AppColors.neonPink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showAddRouteDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final distanceController = TextEditingController();
    final ratingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.glassSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.neonCyan,
              AppColors.neonBlue,
            ],
          ).createShader(bounds),
          child: const Text(
            'Add New Cycling Route',
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
                labelText: 'Route Name',
                labelStyle: TextStyle(color: AppColors.secondaryText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.neonCyan),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: AppColors.secondaryText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.neonCyan),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: distanceController,
              style: TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
                labelText: 'Distance (km)',
                labelStyle: TextStyle(color: AppColors.secondaryText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.neonCyan),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ratingController,
              style: TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
                labelText: 'Rating (0-5)',
                labelStyle: TextStyle(color: AppColors.secondaryText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.neonCyan),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.secondaryText,
              ),
              child: const Text('Cancel'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  AppColors.neonCyan,
                  AppColors.neonBlue,
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  final routeData = {
                    'name': nameController.text.trim(),
                    'title': nameController.text.trim(),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primaryBackground,
                elevation: 0,
              ),
              child: const Text('Add Route'),
            ),
          ),
        ],
      ),
    );
  }

  void _showRouteDetails(dynamic route, Map<String, dynamic> routeData) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => RouteDetailScreen(
          routeId: routeData['id']?.toString() ?? (route as QueryDocumentSnapshot?)?.id ?? '',
          routeData: routeData,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var slideAnimation = Tween(begin: begin, end: end).animate(
            CurvedAnimation(parent: animation, curve: curve),
          );

          var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: curve),
          );

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }
}
