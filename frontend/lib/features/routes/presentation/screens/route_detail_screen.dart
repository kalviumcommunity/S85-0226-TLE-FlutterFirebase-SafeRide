import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/common/premium_stat_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../routes/providers/route_provider.dart';

class RouteDetailScreen extends StatefulWidget {
  final String routeId;
  final Map<String, dynamic>? routeData;

  const RouteDetailScreen({
    super.key,
    required this.routeId,
    this.routeData,
  });

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RouteProvider>(
        builder: (context, routeProvider, child) {
          // For now, use the routeData passed from routes list
          // In a real app, you'd fetch the full route details using routeId
          final routeData = widget.routeData ?? {};
          
          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(routeData),
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Column(
                          children: [
                            _buildJourneyVisualization(routeData),
                            const SizedBox(height: 32),
                            _buildStatsGrid(routeData),
                            const SizedBox(height: 32),
                            _buildWaypointsSection(routeData),
                            const SizedBox(height: 32),
                            _buildActionButtons(routeData),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(Map<String, dynamic> routeData) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.primaryBackground,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.glassSurface,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.glassSurface,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: IconButton(
            icon: Icon(
              routeData['isFavorite'] == true ? Icons.favorite : Icons.favorite_border,
              color: routeData['isFavorite'] == true ? AppColors.neonPink : AppColors.secondaryText,
            ),
            onPressed: () => _toggleFavorite(routeData),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: ShaderMask(
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
            routeData['title'] ?? 'Route Details',
            style: const TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gradientStart,
                AppColors.gradientMiddle,
                AppColors.gradientEnd,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              _buildAnimatedBackground(),
              ...routeData['waypoints'].map((waypoint) => Container()),
              Center(
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.neonCyan.withValues(alpha:0.3),
                              AppColors.neonBlue.withValues(alpha:0.2),
                              AppColors.neonPurple.withValues(alpha:0.1),
                            ],
                          ),
                          border: Border.all(
                            color: AppColors.neonCyan.withValues(alpha:0.5),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neonCyan.withValues(alpha:0.4),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.directions_bike,
                          color: AppColors.neonCyan,
                          size: 60,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: RoutePathPainter(_fadeAnimation.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildJourneyVisualization(Map<String, dynamic> routeData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            AppColors.neonCyan.withValues(alpha:0.1),
            AppColors.neonBlue.withValues(alpha:0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.neonCyan.withValues(alpha:0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withValues(alpha:0.2),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Journey Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.glassSurface,
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: CustomPaint(
              painter: JourneyPathPainter(
                distance: (routeData['distance'] ?? 0.0).toDouble(),
                elevation: (routeData['elevation'] ?? 0.0).toDouble(),
              ),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> routeData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
        children: [
          PremiumStatCard(
            title: 'Distance',
            value: '${(routeData['distance'] ?? 0.0).toStringAsFixed(1)}',
            subtitle: 'kilometers',
            icon: Icons.straighten,
            primaryColor: AppColors.neonBlue,
            secondaryColor: AppColors.neonCyan,
          ),
          PremiumStatCard(
            title: 'Rating',
            value: '${(routeData['rating'] ?? 0.0).toStringAsFixed(1)}',
            subtitle: 'out of 5 stars',
            icon: Icons.star,
            primaryColor: AppColors.starGold,
            secondaryColor: AppColors.starSilver,
          ),
          PremiumStatCard(
            title: 'Difficulty',
            value: routeData['difficulty'] ?? 'Moderate',
            subtitle: 'challenge level',
            icon: Icons.terrain,
            primaryColor: _getDifficultyColor(routeData['difficulty'] ?? 'Moderate'),
            secondaryColor: AppColors.moderateYellow,
          ),
          PremiumStatCard(
            title: 'Est. Time',
            value: '${routeData['estimatedTimeMinutes'] ?? 30}',
            subtitle: 'minutes',
            icon: Icons.schedule,
            primaryColor: AppColors.neonPurple,
            secondaryColor: AppColors.neonBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildWaypointsSection(Map<String, dynamic> routeData) {
    final waypoints = List<String>.from(routeData['waypoints'] ?? []);
    
    if (waypoints.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            AppColors.glassSurface,
            AppColors.glassSurface.withValues(alpha:0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Waypoints',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          ...waypoints.asMap().entries.map((entry) {
            final index = entry.key;
            final waypoint = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.neonCyan,
                          AppColors.neonBlue,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonCyan.withValues(alpha:0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      waypoint,
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> routeData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Start Ride Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  AppColors.cyclingGreen,
                  AppColors.beginnerGreen,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyclingGreen.withValues(alpha:0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _startRide(routeData),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primaryBackground,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Start Ride',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Secondary Actions
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.glassBorder),
                    color: AppColors.glassSurface,
                  ),
                  child: TextButton(
                    onPressed: () => _shareRoute(routeData),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondaryText,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, size: 18),
                        const SizedBox(width: 6),
                        Text('Share'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.glassBorder),
                    color: AppColors.glassSurface,
                  ),
                  child: TextButton(
                    onPressed: () => _downloadRoute(routeData),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondaryText,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download, size: 18),
                        const SizedBox(width: 6),
                        Text('Download'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.beginnerGreen;
      case 'moderate':
        return AppColors.moderateYellow;
      case 'pro':
      case 'advanced':
        return AppColors.proRed;
      default:
        return AppColors.moderateYellow;
    }
  }

  void _toggleFavorite(Map<String, dynamic> routeData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          routeData['isFavorite'] == true 
              ? 'Removed from favorites' 
              : 'Added to favorites',
        ),
        backgroundColor: AppColors.neonPink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _startRide(Map<String, dynamic> routeData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting ride: ${routeData['title']}'),
        backgroundColor: AppColors.cyclingGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _shareRoute(Map<String, dynamic> routeData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing route: ${routeData['title']}'),
        backgroundColor: AppColors.neonBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _downloadRoute(Map<String, dynamic> routeData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading route: ${routeData['title']}'),
        backgroundColor: AppColors.neonPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class RoutePathPainter extends CustomPainter {
  final double opacity;

  RoutePathPainter(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = AppColors.neonCyan.withValues(alpha:opacity * 0.3);

    final path = Path();
    final width = size.width;
    final height = size.height;

    // Draw flowing curved lines
    for (int i = 0; i < 5; i++) {
      final startX = (i * width / 4);
      final startY = height * 0.3;
      final endX = startX + width / 6;
      final endY = height * 0.7;

      path.moveTo(startX, startY);
      path.quadraticBezierTo(
        startX + width / 12, startY + height * 0.2,
        endX, endY,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class JourneyPathPainter extends CustomPainter {
  final double distance;
  final double elevation;

  JourneyPathPainter({
    required this.distance,
    required this.elevation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final gradient = LinearGradient(
      colors: [
        AppColors.neonCyan,
        AppColors.neonBlue,
        AppColors.neonPurple,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final padding = 20.0;
    final width = size.width - (padding * 2);
    final height = size.height - (padding * 2);

    // Create a curved path representing the journey
    final points = <Offset>[];
    final segments = 8;
    
    for (int i = 0; i <= segments; i++) {
      final t = i / segments;
      final x = padding + (width * t);
      
      // Create elevation profile based on distance and elevation
      final elevationFactor = (elevation / 250.0).clamp(0.0, 1.0);
      final baseY = padding + height / 2;
      final variation = sin(t * pi * 2) * height * 0.3 * elevationFactor;
      final y = baseY + variation;
      
      points.add(Offset(x, y));
    }

    // Draw smooth curve through points
    for (int i = 0; i < points.length - 1; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      }
      
      final cp1x = points[i].dx + (points[i + 1].dx - points[i].dx) * 0.5;
      final cp1y = points[i].dy;
      final cp2x = points[i].dx + (points[i + 1].dx - points[i].dx) * 0.5;
      final cp2y = points[i + 1].dy;
      
      path.cubicTo(
        cp1x, cp1y,
        cp2x, cp2y,
        points[i + 1].dx, points[i + 1].dy,
      );
    }

    canvas.drawPath(path, paint);

    // Draw waypoints
    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.neonCyan;

    for (int i = 0; i < points.length; i += 2) {
      canvas.drawCircle(points[i], 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
