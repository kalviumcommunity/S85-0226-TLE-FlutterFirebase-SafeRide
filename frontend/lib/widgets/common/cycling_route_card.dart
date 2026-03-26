import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CyclingRouteCard extends StatefulWidget {
  final String title;
  final String description;
  final double distance;
  final double rating;
  final String difficulty;
  final double elevation;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final Color primaryColor;

  const CyclingRouteCard({
    super.key,
    required this.title,
    required this.description,
    required this.distance,
    required this.rating,
    this.difficulty = 'Moderate',
    this.elevation = 0.0,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.primaryColor = AppColors.neonCyan,
  });

  @override
  State<CyclingRouteCard> createState() => _CyclingRouteCardState();
}

class _CyclingRouteCardState extends State<CyclingRouteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _hoverAnimation;
  late Animation<double> _favoriteAnimation;
  late Animation<double> _progressAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _favoriteAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.distance / 20.0, // Progress based on distance (max 20km)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
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
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _hoverAnimation.value,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      widget.primaryColor.withValues(alpha:0.1),
                      widget.primaryColor.withValues(alpha:0.05),
                      AppColors.glassSurface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: widget.primaryColor.withValues(alpha:_isHovered ? 0.6 : 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.primaryColor.withValues(alpha:_isHovered ? 0.4 : 0.2),
                      blurRadius: _isHovered ? 25 : 15,
                      spreadRadius: _isHovered ? 2 : 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderSection(),
                          const SizedBox(height: 12),
                          _buildTitleSection(),
                          const SizedBox(height: 8),
                          _buildDescriptionSection(),
                          const SizedBox(height: 16),
                          _buildStatsRow(),
                          const SizedBox(height: 16),
                          _buildDistanceBar(),
                          const SizedBox(height: 16),
                          _buildFooterSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDifficultyBadge(),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildDifficultyBadge() {
    Color badgeColor;
    String badgeText;
    
    switch (widget.difficulty.toLowerCase()) {
      case 'beginner':
        badgeColor = AppColors.beginnerGreen;
        badgeText = 'Beginner';
        break;
      case 'moderate':
        badgeColor = AppColors.moderateYellow;
        badgeText = 'Moderate';
        break;
      case 'pro':
      case 'advanced':
        badgeColor = AppColors.proRed;
        badgeText = 'Pro';
        break;
      default:
        badgeColor = AppColors.moderateYellow;
        badgeText = 'Moderate';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            badgeColor.withValues(alpha:0.8),
            badgeColor.withValues(alpha:0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withValues(alpha:0.4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        badgeText,
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: widget.onFavoriteToggle,
      child: AnimatedBuilder(
        animation: _favoriteAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isFavorite ? _favoriteAnimation.value : 1.0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isFavorite 
                    ? AppColors.neonPink.withValues(alpha:0.2)
                    : AppColors.glassSurface,
                border: Border.all(
                  color: widget.isFavorite 
                      ? AppColors.neonPink
                      : AppColors.glassBorder,
                  width: 1.5,
                ),
              ),
              child: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? AppColors.neonPink : AppColors.secondaryText,
                size: 20,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleSection() {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: -0.5,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescriptionSection() {
    return Text(
      widget.description,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.secondaryText,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem(
          icon: Icons.straighten,
          value: '${widget.distance.toStringAsFixed(1)} km',
          color: AppColors.neonBlue,
        ),
        const SizedBox(width: 16),
        _buildStatItem(
          icon: Icons.star,
          value: widget.rating.toStringAsFixed(1),
          color: AppColors.starGold,
        ),
        const SizedBox(width: 16),
        if (widget.elevation > 0)
          _buildStatItem(
            icon: Icons.terrain,
            value: '${widget.elevation.toInt()} m',
            color: AppColors.moderateYellow,
          ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha:0.2),
          ),
          child: Icon(
            icon,
            color: color,
            size: 14,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Route Progress',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${((_progressAnimation.value * 100).clamp(0.0, 100.0)).toInt()}%',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: AppColors.glassBorder.withValues(alpha:0.3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: _progressAnimation.value.clamp(0.0, 1.0),
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildStarRating(),
            const SizedBox(width: 8),
            Text(
              '(${widget.rating.toStringAsFixed(1)})',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                widget.primaryColor,
                widget.primaryColor.withValues(alpha:0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.primaryColor.withValues(alpha:0.4),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            'View Route',
            style: TextStyle(
              color: AppColors.primaryBackground,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index < widget.rating.floor();
        final halfFilled = index == widget.rating.floor() && widget.rating % 1 >= 0.5;
        
        return Icon(
          halfFilled ? Icons.star_half : (filled ? Icons.star : Icons.star_border),
          color: AppColors.starGold,
          size: 14,
        );
      }),
    );
  }
}

class RouteIllustration extends StatelessWidget {
  final double distance;
  final Color primaryColor;

  const RouteIllustration({
    super.key,
    required this.distance,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: RouteIllustrationPainter(
        distance: distance,
        primaryColor: primaryColor,
      ),
    );
  }
}

class RouteIllustrationPainter extends CustomPainter {
  final double distance;
  final Color primaryColor;

  RouteIllustrationPainter({
    required this.distance,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final gradient = LinearGradient(
      colors: [
        primaryColor,
        primaryColor.withValues(alpha:0.6),
        primaryColor.withValues(alpha:0.3),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw abstract cycling path
    path.moveTo(centerX - 20, centerY + 10);
    path.quadraticBezierTo(
      centerX - 10, centerY - 10,
      centerX, centerY,
    );
    path.quadraticBezierTo(
      centerX + 10, centerY + 10,
      centerX + 20, centerY - 5,
    );

    canvas.drawPath(path, paint);

    // Draw dots along the path
    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = primaryColor;

    final dotCount = (distance / 5).clamp(3, 8).toInt();
    for (int i = 0; i < dotCount; i++) {
      final t = i / (dotCount - 1);
      final x = centerX - 20 + (40 * t);
      final y = centerY + 10 - (15 * t * (1 - t) * 4); // Parabolic curve
      
      canvas.drawCircle(Offset(x, y), 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
