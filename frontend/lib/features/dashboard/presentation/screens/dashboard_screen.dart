import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/layout/responsive_layout.dart';
import '../../../../widgets/common/premium_stat_card.dart';
import '../../../../widgets/common/cycling_logo.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/app_colors.dart';
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
              icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WelcomeHeader(
              greeting: 'Welcome to SafeRide',
              userName: 'Cyclist',
            ),
            const SizedBox(height: 24),
            PremiumStatCard(
              title: 'Total Routes',
              value: routeProvider.routesCount.toString(),
              subtitle: 'Available cycling routes',
              icon: Icons.route,
              primaryColor: AppColors.cyclingGreen,
              secondaryColor: AppColors.beginnerGreen,
              showProgress: true,
              progressValue: (routeProvider.routesCount / 10).clamp(0.0, 1.0),
            ),
            const SizedBox(height: 16),
            PremiumStatCard(
              title: 'Total Distance',
              value: _calculateTotalDistance(routeProvider).toStringAsFixed(1),
              subtitle: 'kilometers cycled',
              icon: Icons.straighten,
              primaryColor: AppColors.neonBlue,
              secondaryColor: AppColors.neonCyan,
              showProgress: true,
              progressValue: (_calculateTotalDistance(routeProvider) / 100).clamp(0.0, 1.0),
            ),
            const SizedBox(height: 16),
            PremiumStatCard(
              title: 'Safety Score',
              value: _calculateSafetyScore(routeProvider).toStringAsFixed(0),
              subtitle: 'Safety rating',
              icon: Icons.security,
              primaryColor: AppColors.cyclingOrange,
              secondaryColor: AppColors.moderateYellow,
              showProgress: true,
              progressValue: _calculateSafetyScore(routeProvider) / 100,
            ),
            const SizedBox(height: 16),
            PremiumStatCard(
              title: 'Average Rating',
              value: _calculateAverageRating(routeProvider).toStringAsFixed(1),
              subtitle: 'Route satisfaction',
              icon: Icons.star,
              primaryColor: AppColors.starGold,
              secondaryColor: AppColors.starSilver,
              showProgress: true,
              progressValue: _calculateAverageRating(routeProvider) / 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, ThemeProvider themeProvider, RouteProvider routeProvider) {
    return Scaffold(
      appBar: AppBar(
        title: const CyclingLogo(size: 45, showText: true),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder),
              color: AppColors.glassSurface,
            ),
            child: IconButton(
              icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            WelcomeHeader(
              greeting: 'Welcome to SafeRide',
              userName: 'Cyclist',
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: [
                PremiumStatCard(
                  title: 'Total Routes',
                  value: routeProvider.routesCount.toString(),
                  subtitle: 'Available cycling routes',
                  icon: Icons.route,
                  primaryColor: AppColors.cyclingGreen,
                  secondaryColor: AppColors.beginnerGreen,
                  showProgress: true,
                  progressValue: (routeProvider.routesCount / 10).clamp(0.0, 1.0),
                ),
                PremiumStatCard(
                  title: 'Total Distance',
                  value: _calculateTotalDistance(routeProvider).toStringAsFixed(1),
                  subtitle: 'kilometers cycled',
                  icon: Icons.straighten,
                  primaryColor: AppColors.neonBlue,
                  secondaryColor: AppColors.neonCyan,
                  showProgress: true,
                  progressValue: (_calculateTotalDistance(routeProvider) / 100).clamp(0.0, 1.0),
                ),
                PremiumStatCard(
                  title: 'Safety Score',
                  value: _calculateSafetyScore(routeProvider).toStringAsFixed(0),
                  subtitle: 'Safety rating',
                  icon: Icons.security,
                  primaryColor: AppColors.cyclingOrange,
                  secondaryColor: AppColors.moderateYellow,
                  showProgress: true,
                  progressValue: _calculateSafetyScore(routeProvider) / 100,
                ),
                PremiumStatCard(
                  title: 'Average Rating',
                  value: _calculateAverageRating(routeProvider).toStringAsFixed(1),
                  subtitle: 'Route satisfaction',
                  icon: Icons.star,
                  primaryColor: AppColors.starGold,
                  secondaryColor: AppColors.starSilver,
                  showProgress: true,
                  progressValue: _calculateAverageRating(routeProvider) / 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeProvider themeProvider, RouteProvider routeProvider) {
    return Scaffold(
      appBar: AppBar(
        title: const CyclingLogo(size: 50, showText: true),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder),
              color: AppColors.glassSurface,
            ),
            child: IconButton(
              icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            WelcomeHeader(
              greeting: 'Welcome to SafeRide',
              userName: 'Professional Cyclist',
            ),
            const SizedBox(height: 40),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.2,
              children: [
                PremiumStatCard(
                  title: 'Total Routes',
                  value: routeProvider.routesCount.toString(),
                  subtitle: 'Available cycling routes',
                  icon: Icons.route,
                  primaryColor: AppColors.cyclingGreen,
                  secondaryColor: AppColors.beginnerGreen,
                  showProgress: true,
                  progressValue: (routeProvider.routesCount / 10).clamp(0.0, 1.0),
                ),
                PremiumStatCard(
                  title: 'Total Distance',
                  value: _calculateTotalDistance(routeProvider).toStringAsFixed(1),
                  subtitle: 'kilometers cycled',
                  icon: Icons.straighten,
                  primaryColor: AppColors.neonBlue,
                  secondaryColor: AppColors.neonCyan,
                  showProgress: true,
                  progressValue: (_calculateTotalDistance(routeProvider) / 100).clamp(0.0, 1.0),
                ),
                PremiumStatCard(
                  title: 'Safety Score',
                  value: _calculateSafetyScore(routeProvider).toStringAsFixed(0),
                  subtitle: 'Safety rating',
                  icon: Icons.security,
                  primaryColor: AppColors.cyclingOrange,
                  secondaryColor: AppColors.moderateYellow,
                  showProgress: true,
                  progressValue: _calculateSafetyScore(routeProvider) / 100,
                ),
                PremiumStatCard(
                  title: 'Average Rating',
                  value: _calculateAverageRating(routeProvider).toStringAsFixed(1),
                  subtitle: 'Route satisfaction',
                  icon: Icons.star,
                  primaryColor: AppColors.starGold,
                  secondaryColor: AppColors.starSilver,
                  showProgress: true,
                  progressValue: _calculateAverageRating(routeProvider) / 5,
                ),
                PremiumStatCard(
                  title: 'Favorite Routes',
                  value: _calculateFavoriteRoutes(routeProvider).toString(),
                  subtitle: 'Most loved routes',
                  icon: Icons.favorite,
                  primaryColor: AppColors.neonPink,
                  secondaryColor: AppColors.cyclingRed,
                  showProgress: true,
                  progressValue: (_calculateFavoriteRoutes(routeProvider) / routeProvider.routesCount).clamp(0.0, 1.0),
                ),
                PremiumStatCard(
                  title: 'Experience Level',
                  value: _getExperienceLevel(routeProvider),
                  subtitle: 'Cycling proficiency',
                  icon: Icons.emoji_events,
                  primaryColor: AppColors.neonPurple,
                  secondaryColor: AppColors.neonBlue,
                  showProgress: true,
                  progressValue: _getExperienceProgress(routeProvider),
                ),
              ],
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

  double _calculateSafetyScore(RouteProvider routeProvider) {
    final avgRating = _calculateAverageRating(routeProvider);
    final distance = _calculateTotalDistance(routeProvider);
    final routeCount = RouteProvider.useMockData 
        ? routeProvider.mockRoutes.length 
        : routeProvider.routes.length;
    
    // Calculate safety score based on ratings, distance, and route variety
    double safetyScore = 50.0; // Base score
    
    // Add rating component (40% of score)
    safetyScore += (avgRating / 5.0) * 40.0;
    
    // Add distance component (20% of score, max at 50km)
    safetyScore += (distance / 50.0).clamp(0.0, 1.0) * 20.0;
    
    // Add route variety component (10% of score, max at 10 routes)
    safetyScore += (routeCount / 10.0).clamp(0.0, 1.0) * 10.0;
    
    return safetyScore.clamp(0.0, 100.0);
  }

  int _calculateFavoriteRoutes(RouteProvider routeProvider) {
    // Count routes with rating 4.5 or higher as favorites
    if (RouteProvider.useMockData) {
      return routeProvider.mockRoutes.where((route) => 
        (route['rating'] ?? 0.0) >= 4.5
      ).length;
    } else {
      return routeProvider.routes.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return (data['rating'] ?? 0.0) >= 4.5;
      }).length;
    }
  }

  String _getExperienceLevel(RouteProvider routeProvider) {
    final totalDistance = _calculateTotalDistance(routeProvider);
    final routeCount = RouteProvider.useMockData 
        ? routeProvider.mockRoutes.length 
        : routeProvider.routes.length;
    
    if (totalDistance >= 100 || routeCount >= 10) {
      return 'Pro';
    } else if (totalDistance >= 50 || routeCount >= 5) {
      return 'Advanced';
    } else if (totalDistance >= 20 || routeCount >= 3) {
      return 'Intermediate';
    } else {
      return 'Beginner';
    }
  }

  double _getExperienceProgress(RouteProvider routeProvider) {
    final level = _getExperienceLevel(routeProvider);
    switch (level) {
      case 'Pro':
        return 1.0;
      case 'Advanced':
        return 0.75;
      case 'Intermediate':
        return 0.5;
      case 'Beginner':
        return 0.25;
      default:
        return 0.0;
    }
  }
}
