import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/common/cycling_logo.dart';
import '../../../../widgets/common/premium_stat_card.dart';
import '../../../../widgets/layout/responsive_layout.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../routes/providers/route_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, AuthProvider>(
      builder: (context, themeProvider, authProvider, child) {
        return Consumer<RouteProvider>(
          builder: (context, routeProvider, child) {
            return ResponsiveLayout(
              mobile: _buildMobileLayout(context, themeProvider, authProvider, routeProvider),
              tablet: _buildTabletLayout(context, themeProvider, authProvider, routeProvider),
              desktop: _buildDesktopLayout(context, themeProvider, authProvider, routeProvider),
            );
          },
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeProvider themeProvider, AuthProvider authProvider, RouteProvider routeProvider) {
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
            _buildProfileHeader(authProvider),
            const SizedBox(height: 32),
            _buildCyclingStats(routeProvider),
            const SizedBox(height: 32),
            _buildAchievementsSection(),
            const SizedBox(height: 32),
            _buildSettingsSection(themeProvider, authProvider),
            const SizedBox(height: 32),
            _buildSignOutButton(authProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, ThemeProvider themeProvider, AuthProvider authProvider, RouteProvider routeProvider) {
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
            _buildProfileHeader(authProvider),
            const SizedBox(height: 40),
            _buildCyclingStatsGrid(routeProvider),
            const SizedBox(height: 40),
            _buildAchievementsGrid(),
            const SizedBox(height: 40),
            _buildSettingsSection(themeProvider, authProvider),
            const SizedBox(height: 40),
            _buildSignOutButton(authProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeProvider themeProvider, AuthProvider authProvider, RouteProvider routeProvider) {
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
            _buildProfileHeader(authProvider),
            const SizedBox(height: 48),
            _buildCyclingStatsGrid(routeProvider),
            const SizedBox(height: 48),
            _buildAchievementsGrid(),
            const SizedBox(height: 48),
            _buildSettingsSection(themeProvider, authProvider),
            const SizedBox(height: 48),
            _buildSignOutButton(authProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AuthProvider authProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withValues(alpha:0.3),
            blurRadius: 20,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha:0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.cyclingGreen.withValues(alpha:0.3),
                          AppColors.cyclingGreen.withValues(alpha:0.1),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.cyclingGreen.withValues(alpha:0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.cyclingGreen,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              AppColors.neonCyan,
                              AppColors.neonBlue,
                              AppColors.neonPurple,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Cycling Enthusiast',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: AppColors.primaryText,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          authProvider.currentUser?.email ?? 'Guest User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Member since 2024',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.glassSurface.withValues(alpha:0.3),
                  border: Border.all(
                    color: AppColors.glassBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProfileStat('Rides', '127', AppColors.neonCyan),
                    _buildProfileStat('Distance', '845 km', AppColors.neonBlue),
                    _buildProfileStat('Time', '52h', AppColors.neonPurple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value, Color color) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [color, color.withValues(alpha:0.7)],
          ).createShader(bounds),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCyclingStats(RouteProvider routeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycling Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        PremiumStatCard(
          title: 'Total Routes',
          value: routeProvider.routesCount.toString(),
          subtitle: 'Completed cycling routes',
          icon: Icons.route,
          primaryColor: AppColors.cyclingGreen,
          secondaryColor: AppColors.beginnerGreen,
          showProgress: true,
          progressValue: (routeProvider.routesCount / 20).clamp(0.0, 1.0),
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
          progressValue: (_calculateTotalDistance(routeProvider) / 200).clamp(0.0, 1.0),
        ),
        const SizedBox(height: 16),
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
    );
  }

  Widget _buildCyclingStatsGrid(RouteProvider routeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycling Statistics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
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
              subtitle: 'Completed cycling routes',
              icon: Icons.route,
              primaryColor: AppColors.cyclingGreen,
              secondaryColor: AppColors.beginnerGreen,
              showProgress: true,
              progressValue: (routeProvider.routesCount / 20).clamp(0.0, 1.0),
            ),
            PremiumStatCard(
              title: 'Total Distance',
              value: _calculateTotalDistance(routeProvider).toStringAsFixed(1),
              subtitle: 'kilometers cycled',
              icon: Icons.straighten,
              primaryColor: AppColors.neonBlue,
              secondaryColor: AppColors.neonCyan,
              showProgress: true,
              progressValue: (_calculateTotalDistance(routeProvider) / 200).clamp(0.0, 1.0),
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
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildAchievementBadges(),
      ],
    );
  }

  Widget _buildAchievementsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
        _buildAchievementBadges(),
      ],
    );
  }

  Widget _buildAchievementBadges() {
    final achievements = [
      {'name': 'First Ride', 'icon': Icons.emoji_events, 'color': AppColors.beginnerGreen, 'unlocked': true},
      {'name': 'Distance Master', 'icon': Icons.straighten, 'color': AppColors.neonBlue, 'unlocked': true},
      {'name': 'Speed Demon', 'icon': Icons.speed, 'color': AppColors.neonPurple, 'unlocked': false},
      {'name': 'Explorer', 'icon': Icons.explore, 'color': AppColors.cyclingOrange, 'unlocked': true},
      {'name': 'Hill Climber', 'icon': Icons.terrain, 'color': AppColors.proRed, 'unlocked': false},
      {'name': 'Night Rider', 'icon': Icons.nightlight, 'color': AppColors.neonCyan, 'unlocked': false},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.0,
      children: achievements.map((achievement) {
        return _buildAchievementBadge(
          achievement['name'] as String,
          achievement['icon'] as IconData,
          achievement['color'] as Color,
          achievement['unlocked'] as bool,
        );
      }).toList(),
    );
  }

  Widget _buildAchievementBadge(String name, IconData icon, Color color, bool unlocked) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: unlocked 
              ? [color.withValues(alpha:0.2), color.withValues(alpha:0.1)]
              : [AppColors.glassBorder.withValues(alpha:0.3), AppColors.glassBorder.withValues(alpha:0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: unlocked ? color.withValues(alpha:0.5) : AppColors.glassBorder,
          width: 1.5,
        ),
        boxShadow: unlocked ? [
          BoxShadow(
            color: color.withValues(alpha:0.3),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ] : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked ? color.withValues(alpha:0.2) : AppColors.glassBorder.withValues(alpha:0.2),
            ),
            child: Icon(
              icon,
              color: unlocked ? color : AppColors.mutedText,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: unlocked ? AppColors.primaryText : AppColors.mutedText,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(ThemeProvider themeProvider, AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.glassSurface,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeProvider.isDarkMode 
                        ? AppColors.neonCyan.withValues(alpha:0.2)
                        : AppColors.cyclingOrange.withValues(alpha:0.2),
                  ),
                  child: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: themeProvider.isDarkMode ? AppColors.neonCyan : AppColors.cyclingOrange,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Toggle dark theme',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(),
                  thumbColor: WidgetStateProperty.all(AppColors.neonCyan),
                ),
              ),
              Divider(height: 1, color: AppColors.glassBorder),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.neonBlue.withValues(alpha:0.2),
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: AppColors.neonBlue,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Manage notification preferences',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
              ),
              Divider(height: 1, color: AppColors.glassBorder),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.neonPurple.withValues(alpha:0.2),
                  ),
                  child: Icon(
                    Icons.privacy_tip,
                    color: AppColors.neonPurple,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Privacy',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Privacy and security settings',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
              ),
              Divider(height: 1, color: AppColors.glassBorder),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cyclingGreen.withValues(alpha:0.2),
                  ),
                  child: Icon(
                    Icons.help,
                    color: AppColors.cyclingGreen,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Help & Support',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Get help and support',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutButton(AuthProvider authProvider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            AppColors.neonPink,
            AppColors.cyclingRed,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPink.withValues(alpha:0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          await authProvider.signOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primaryBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: authProvider.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBackground),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
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

  int _calculateFavoriteRoutes(RouteProvider routeProvider) {
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
