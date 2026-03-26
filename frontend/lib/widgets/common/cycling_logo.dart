import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CyclingLogo extends StatefulWidget {
  final double size;
  final bool showText;
  final String? text;

  const CyclingLogo({
    super.key,
    this.size = 60,
    this.showText = true,
    this.text,
  });

  @override
  State<CyclingLogo> createState() => _CyclingLogoState();
}

class _CyclingLogoState extends State<CyclingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLogoContainer(),
            if (widget.showText) ...[
              const SizedBox(width: 12),
              _buildTextLogo(),
            ],
          ],
        );
      },
    );
  }

  Widget _buildLogoContainer() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.neonCyan.withValues(alpha:_glowAnimation.value),
            AppColors.neonBlue.withValues(alpha:_glowAnimation.value * 0.7),
            AppColors.neonPurple.withValues(alpha:_glowAnimation.value * 0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withValues(alpha:_glowAnimation.value * 0.6),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha:_glowAnimation.value * 0.4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          margin: EdgeInsets.all(widget.size * 0.15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryBackground,
            boxShadow: [
              BoxShadow(
                color: AppColors.glassShadow,
                blurRadius: 10,
              ),
            ],
          ),
          child: _buildCyclingIcon(),
        ),
      ),
    );
  }

  Widget _buildCyclingIcon() {
    return CustomPaint(
      size: Size(widget.size * 0.7, widget.size * 0.7),
      painter: CyclingIconPainter(),
    );
  }

  Widget _buildTextLogo() {
    return ShaderMask(
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
        widget.text ?? 'SafeRide',
        style: TextStyle(
          fontSize: widget.size * 0.4,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class CyclingIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Create gradient for the cycling icon
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

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = size.width / 100;

    // Draw bicycle frame
    _drawBicycleFrame(canvas, centerX, centerY, scale, paint);

    // Draw wheels
    _drawWheels(canvas, centerX, centerY, scale, paint);

    // Draw handlebars
    _drawHandlebars(canvas, centerX, centerY, scale, paint);
  }

  void _drawBicycleFrame(Canvas canvas, double centerX, double centerY, double scale, Paint paint) {
    // Main triangle frame
    final path = Path();
    
    // Top tube
    path.moveTo(centerX - 25 * scale, centerY - 15 * scale);
    path.lineTo(centerX + 10 * scale, centerY - 15 * scale);
    
    // Seat tube
    path.moveTo(centerX - 25 * scale, centerY - 15 * scale);
    path.lineTo(centerX - 20 * scale, centerY + 15 * scale);
    
    // Down tube
    path.moveTo(centerX + 10 * scale, centerY - 15 * scale);
    path.lineTo(centerX - 20 * scale, centerY + 15 * scale);
    
    // Seat stays
    path.moveTo(centerX - 20 * scale, centerY + 15 * scale);
    path.lineTo(centerX - 35 * scale, centerY + 15 * scale);
    
    canvas.drawPath(path, paint);
  }

  void _drawWheels(Canvas canvas, double centerX, double centerY, double scale, Paint paint) {
    // Front wheel
    canvas.drawCircle(
      Offset(centerX + 10 * scale, centerY + 15 * scale),
      18 * scale,
      paint,
    );
    
    // Rear wheel
    canvas.drawCircle(
      Offset(centerX - 35 * scale, centerY + 15 * scale),
      18 * scale,
      paint,
    );
    
    // Wheel spokes
    final spokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.neonCyan.withValues(alpha:0.6);
    
    // Front wheel spokes
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.14159 / 180;
      final startX = centerX + 10 * scale + 15 * scale * cos(angle);
      final startY = centerY + 15 * scale + 15 * scale * sin(angle);
      final endX = centerX + 10 * scale - 15 * scale * cos(angle);
      final endY = centerY + 15 * scale - 15 * scale * sin(angle);
      
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        spokePaint,
      );
    }
    
    // Rear wheel spokes
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.14159 / 180;
      final startX = centerX - 35 * scale + 15 * scale * cos(angle);
      final startY = centerY + 15 * scale + 15 * scale * sin(angle);
      final endX = centerX - 35 * scale - 15 * scale * cos(angle);
      final endY = centerY + 15 * scale - 15 * scale * sin(angle);
      
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        spokePaint,
      );
    }
  }

  void _drawHandlebars(Canvas canvas, double centerX, double centerY, double scale, Paint paint) {
    // Handlebar stem
    canvas.drawLine(
      Offset(centerX + 10 * scale, centerY - 15 * scale),
      Offset(centerX + 15 * scale, centerY - 20 * scale),
      paint,
    );
    
    // Handlebars
    canvas.drawLine(
      Offset(centerX + 10 * scale, centerY - 20 * scale),
      Offset(centerX + 20 * scale, centerY - 20 * scale),
      paint,
    );
  }

  double cos(double angle) => angle.cos();
  double sin(double angle) => angle.sin();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on double {
  double cos() => math.cos(this);
  double sin() => math.sin(this);
}
