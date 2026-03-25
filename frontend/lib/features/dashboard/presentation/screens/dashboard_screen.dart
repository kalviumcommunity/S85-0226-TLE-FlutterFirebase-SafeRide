import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/layout/responsive_layout.dart';
import '../../../../widgets/common/dashboard_card.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../routes/providers/route_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Consumer<RouteProvider>(
          builder: (context, routeProvider, child) {
            return ResponsiveLayout(
              mobile: _buildMobileLayout(context, themeProvider, routeProvider),
              tablet: _buildTabletLayout(context, themeProvider, routeProvider),
              desktop: _buildDesktopLayout(context, themeProvider, routeProvider),
            );
          },
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeProvider themeProvider, RouteProvider routeProvider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardCard(
              title: 'Welcome to SafeRide',
              subtitle: 'Your safe journey starts here',
              icon: Icons.directions_bike,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            DashboardCard(
              title: 'Today\'s Routes',
              subtitle: '${routeProvider.routesCount} routes available',
              icon: Icons.route,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            DashboardCard(
              title: 'Safety Tips',
              subtitle: 'Stay safe on the road',
              icon: Icons.security,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            DashboardCard(
              title: 'Total Distance',
              subtitle: '${_calculateTotalDistance(routeProvider).toStringAsFixed(1)} km',
              icon: Icons.straighten,
              color: Colors.purple,
            ),
            const SizedBox(height: 16),
            DashboardCard(
              title: 'Average Rating',
              subtitle: '${_calculateAverageRating(routeProvider).toStringAsFixed(1)} ⭐',
              icon: Icons.star,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, ThemeProvider themeProvider, RouteProvider routeProvider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            DashboardCard(
              title: 'Welcome to SafeRide',
              subtitle: 'Your safe journey starts here',
              icon: Icons.directions_bike,
              color: Colors.blue,
            ),
            DashboardCard(
              title: 'Routes',
              subtitle: '${routeProvider.routesCount} total routes',
              icon: Icons.route,
              color: Colors.green,
            ),
            DashboardCard(
              title: 'Safety Tips',
              subtitle: 'Stay safe on the road',
              icon: Icons.security,
              color: Colors.orange,
            ),
            DashboardCard(
              title: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
              subtitle: themeProvider.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              icon: themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: themeProvider.isDarkMode ? Colors.amber : Colors.grey,
              onTap: () => themeProvider.toggleTheme(),
            ),
            DashboardCard(
              title: 'Total Distance',
              subtitle: '${_calculateTotalDistance(routeProvider).toStringAsFixed(1)} km',
              icon: Icons.straighten,
              color: Colors.purple,
            ),
            DashboardCard(
              title: 'Average Rating',
              subtitle: '${_calculateAverageRating(routeProvider).toStringAsFixed(1)} ⭐',
              icon: Icons.star,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeProvider themeProvider, RouteProvider routeProvider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.2,
          children: [
            DashboardCard(
              title: 'Welcome to SafeRide',
              subtitle: 'Your safe journey starts here',
              icon: Icons.directions_bike,
              color: Colors.blue,
            ),
            DashboardCard(
              title: 'Routes',
              subtitle: '${routeProvider.routesCount} total routes',
              icon: Icons.route,
              color: Colors.green,
            ),
            DashboardCard(
              title: 'Safety Tips',
              subtitle: 'Stay safe on the road',
              icon: Icons.security,
              color: Colors.orange,
            ),
            DashboardCard(
              title: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
              subtitle: themeProvider.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              icon: themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: themeProvider.isDarkMode ? Colors.amber : Colors.grey,
              onTap: () => themeProvider.toggleTheme(),
            ),
            DashboardCard(
              title: 'Statistics',
              subtitle: '${_calculateTotalDistance(routeProvider).toStringAsFixed(1)} km total',
              icon: Icons.analytics,
              color: Colors.purple,
            ),
            DashboardCard(
              title: 'Help & Support',
              subtitle: 'Get help when you need it',
              icon: Icons.help,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalDistance(RouteProvider routeProvider) {
    if (RouteProvider.useMockData) {
      return routeProvider.mockRoutes.fold<double>(
        0.0,
        (sum, route) => sum + (route['distance'] ?? 0.0),
      );
    } else {
      return routeProvider.routes.fold<double>(
        0.0,
        (sum, doc) {
          final data = doc.data() as Map<String, dynamic>;
          return sum + (data['distance'] ?? 0.0);
        },
      );
    }
  }

  double _calculateAverageRating(RouteProvider routeProvider) {
    if (RouteProvider.useMockData) {
      if (routeProvider.mockRoutes.isEmpty) return 0.0;
      final totalRating = routeProvider.mockRoutes.fold<double>(
        0.0,
        (sum, route) => sum + (route['rating'] ?? 0.0),
      );
      return totalRating / routeProvider.mockRoutes.length;
    } else {
      if (routeProvider.routes.isEmpty) return 0.0;
      final totalRating = routeProvider.routes.fold<double>(
        0.0,
        (sum, doc) {
          final data = doc.data() as Map<String, dynamic>;
          return sum + (data['rating'] ?? 0.0);
        },
      );
      return totalRating / routeProvider.routes.length;
    }
  }
}
