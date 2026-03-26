import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum PremiumButtonType {
  primary,
  secondary,
  danger,
  success,
  gradient,
}

class PremiumButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final PremiumButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const PremiumButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = PremiumButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.height,
    this.width,
    this.padding,
    this.child,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _animationController.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _animationController.reverse();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _animationController.reverse();
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _isPressed ? _scaleAnimation.value : (_isHovered ? 1.02 : 1.0),
              child: Container(
                width: widget.isFullWidth ? double.infinity : widget.width,
                height: widget.height ?? 48,
                decoration: _buildButtonDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      if (widget.isLoading) _buildShimmerEffect(),
                      _buildButtonContent(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  BoxDecoration _buildButtonDecoration() {
    switch (widget.type) {
      case PremiumButtonType.primary:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              AppColors.neonCyan,
              AppColors.neonBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonCyan.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha:0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );
      
      case PremiumButtonType.secondary:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.glassSurface,
          border: Border.all(
            color: AppColors.glassBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.glassShadow,
              blurRadius: 15,
              spreadRadius: _isHovered ? 1 : 0,
            ),
          ],
        );
      
      case PremiumButtonType.danger:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              AppColors.neonPink,
              AppColors.cyclingRed,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPink.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha:0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );
      
      case PremiumButtonType.success:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              AppColors.cyclingGreen,
              AppColors.beginnerGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyclingGreen.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha:0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );
      
      case PremiumButtonType.gradient:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              AppColors.neonCyan,
              AppColors.neonBlue,
              AppColors.neonPurple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _getTextColor().withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha:0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );
    }
  }

  Widget _buildButtonContent() {
    if (widget.child != null) {
      return Center(child: widget.child);
    }

    final content = widget.isLoading
        ? _buildLoadingIndicator()
        : _buildButtonText();

    return Center(
      child: content,
    );
  }

  Widget _buildButtonText() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            color: AppColors.primaryBackground,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          widget.text,
          style: TextStyle(
            color: _getTextColor(),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          _getTextColor(),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha:0.3),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + _shimmerAnimation.value, 0),
              end: Alignment(1.0 + _shimmerAnimation.value, 0),
            ),
          ),
        );
      },
    );
  }

  Color _getTextColor() {
    switch (widget.type) {
      case PremiumButtonType.secondary:
        return AppColors.primaryText;
      default:
        return AppColors.primaryBackground;
    }
  }
}

class PremiumIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final PremiumButtonType type;
  final bool isLoading;
  final double? size;
  final String? tooltip;

  const PremiumIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.type = PremiumButtonType.primary,
    this.isLoading = false,
    this.size,
    this.tooltip,
  });

  @override
  State<PremiumIconButton> createState() => _PremiumIconButtonState();
}

class _PremiumIconButtonState extends State<PremiumIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _isHovered ? 1.1 : (_scaleAnimation.value == 0.9 ? 0.9 : 1.0),
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Container(
                  width: widget.size ?? 48,
                  height: widget.size ?? 48,
                  decoration: _buildIconButtonDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(
                      children: [
                        if (widget.isLoading) _buildShimmerEffect(),
                        _buildIconButtonContent(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }

    return button;
  }

  BoxDecoration _buildIconButtonDecoration() {
    switch (widget.type) {
      case PremiumButtonType.primary:
        return BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.neonCyan,
              AppColors.neonBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonCyan.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        );
      
      case PremiumButtonType.secondary:
        return BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.glassSurface,
          border: Border.all(
            color: AppColors.glassBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.glassShadow,
              blurRadius: 15,
              spreadRadius: _isHovered ? 1 : 0,
            ),
          ],
        );
      
      case PremiumButtonType.danger:
        return BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.neonPink,
              AppColors.cyclingRed,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPink.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        );
      
      case PremiumButtonType.success:
        return BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.cyclingGreen,
              AppColors.beginnerGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyclingGreen.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        );
      
      case PremiumButtonType.gradient:
        return BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.neonCyan,
              AppColors.neonBlue,
              AppColors.neonPurple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonCyan.withValues(alpha:_isHovered ? 0.6 : 0.4),
              blurRadius: _isHovered ? 20 : 15,
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        );
    }
  }

  Widget _buildIconButtonContent() {
    return Center(
      child: widget.isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryBackground,
                ),
              ),
            )
          : Icon(
              widget.icon,
              color: _getTextColor(),
              size: 24,
            ),
    );
  }

  Widget _buildShimmerEffect() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha:0.3),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Color _getTextColor() {
    switch (widget.type) {
      case PremiumButtonType.secondary:
        return AppColors.primaryText;
      default:
        return AppColors.primaryBackground;
    }
  }
}
