import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/layout/responsive_layout.dart';
import '../../../../widgets/common/dashboard_card.dart';
import '../../../../core/theme/theme_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ResponsiveLayout(
          mobile: _buildMobileLayout(context, themeProvider),
          tablet: _buildTabletLayout(context, themeProvider),
          desktop: _buildDesktopLayout(context, themeProvider),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeProvider themeProvider) {
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
              subtitle: 'View and manage your routes',
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
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, ThemeProvider themeProvider) {
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
              title: 'Today\'s Routes',
              subtitle: 'View and manage your routes',
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
              title: 'Theme Settings',
              subtitle: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
              icon: themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: themeProvider.isDarkMode ? Colors.amber : Colors.grey,
              onTap: () => themeProvider.toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeProvider themeProvider) {
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
              title: 'Today\'s Routes',
              subtitle: 'View and manage your routes',
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
              title: 'Theme Settings',
              subtitle: themeProvider.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              icon: themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: themeProvider.isDarkMode ? Colors.amber : Colors.grey,
              onTap: () => themeProvider.toggleTheme(),
            ),
            DashboardCard(
              title: 'Statistics',
              subtitle: 'View your riding stats',
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
}
