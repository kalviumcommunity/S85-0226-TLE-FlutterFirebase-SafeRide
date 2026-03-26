import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'shimmer_loading.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;
  final LoadingType type;
  final int? itemCount;

  const LoadingWidget({
    super.key,
    this.message,
    this.size,
    this.type = LoadingType.spinner,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LoadingType.spinner:
        return _buildSpinnerLoading();
      case LoadingType.shimmerRoutes:
        return ShimmerLoadingWidget(
          type: ShimmerType.routeList,
          itemCount: itemCount ?? 3,
        );
      case LoadingType.shimmerGrid:
        return ShimmerLoadingWidget(
          type: ShimmerType.routeGrid,
          itemCount: itemCount ?? 6,
        );
      case LoadingType.shimmerStats:
        return ShimmerLoadingWidget(
          type: ShimmerType.statGrid,
          itemCount: itemCount ?? 4,
        );
      case LoadingType.shimmerProfile:
        return ShimmerLoadingWidget(
          type: ShimmerType.profile,
        );
    }
  }

  Widget _buildSpinnerLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size ?? 60,
            height: size ?? 60,
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
            child: Center(
              child: SizedBox(
                width: (size ?? 60) * 0.6,
                height: (size ?? 60) * 0.6,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.neonCyan),
                ),
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.glassSurface,
                border: Border.all(
                  color: AppColors.glassBorder,
                  width: 1,
                ),
              ),
              child: Text(
                message!,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class PremiumLoadingIndicator extends StatefulWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;

  const PremiumLoadingIndicator({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 3.0,
  });

  @override
  State<PremiumLoadingIndicator> createState() => _PremiumLoadingIndicatorState();
}

class _PremiumLoadingIndicatorState extends State<PremiumLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 24.0;
    final color = widget.color ?? AppColors.neonCyan;

    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value * 2 * 3.14159,
          child: CustomPaint(
            size: Size(size, size),
            painter: _LoadingPainter(
              color: color,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        );
      },
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _LoadingPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    // Draw arc segments
    const startAngle = -3.14159 / 2; // Start from top
    const sweepAngle = 3.14159 * 1.5; // 270 degrees

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum LoadingType {
  spinner,
  shimmerRoutes,
  shimmerGrid,
  shimmerStats,
  shimmerProfile,
}
