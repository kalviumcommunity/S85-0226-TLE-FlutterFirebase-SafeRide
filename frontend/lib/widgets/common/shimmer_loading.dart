import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.baseColor = AppColors.glassSurface,
    this.highlightColor = AppColors.glassBorder,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
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
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              widget.baseColor,
              widget.highlightColor.withValues(alpha:0.5),
              widget.baseColor,
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment(-1.0 + _shimmerAnimation.value, 0),
            end: Alignment(1.0 + _shimmerAnimation.value, 0),
          ).createShader(bounds),
          child: widget.child,
        );
      },
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ShimmerCard({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 20.0,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.glassSurface,
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
      ),
      child: ShimmerLoading(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ShimmerRouteCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const ShimmerRouteCard({
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.glassSurface,
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with difficulty badge and favorite button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerCard(
                width: 80,
                height: 24,
                borderRadius: 12,
              ),
              ShimmerCard(
                width: 36,
                height: 36,
                borderRadius: 18,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Title
          ShimmerCard(
            width: double.infinity,
            height: 18,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),
          // Description
          ShimmerCard(
            width: double.infinity,
            height: 14,
            borderRadius: 4,
          ),
          const SizedBox(height: 4),
          ShimmerCard(
            width: 200,
            height: 14,
            borderRadius: 4,
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              ShimmerCard(
                width: 60,
                height: 20,
                borderRadius: 4,
              ),
              const SizedBox(width: 16),
              ShimmerCard(
                width: 50,
                height: 20,
                borderRadius: 4,
              ),
              const SizedBox(width: 16),
              ShimmerCard(
                width: 55,
                height: 20,
                borderRadius: 4,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Distance bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerCard(
                width: 100,
                height: 12,
                borderRadius: 4,
              ),
              const SizedBox(height: 8),
              ShimmerCard(
                width: double.infinity,
                height: 6,
                borderRadius: 3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Star rating
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: ShimmerCard(
                          width: 14,
                          height: 14,
                          borderRadius: 7,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  ShimmerCard(
                    width: 30,
                    height: 12,
                    borderRadius: 4,
                  ),
                ],
              ),
              ShimmerCard(
                width: 80,
                height: 24,
                borderRadius: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerStatCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const ShimmerStatCard({
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.glassSurface,
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          ShimmerCard(
            width: 56,
            height: 56,
            borderRadius: 16,
          ),
          const SizedBox(height: 16),
          // Value
          ShimmerCard(
            width: 80,
            height: 32,
            borderRadius: 4,
          ),
          const SizedBox(height: 4),
          // Title
          ShimmerCard(
            width: 120,
            height: 16,
            borderRadius: 4,
          ),
          const SizedBox(height: 16),
          // Progress bar
          if (true) // Show progress bar skeleton
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCard(
                  width: 80,
                  height: 12,
                  borderRadius: 4,
                ),
                const SizedBox(height: 8),
                ShimmerCard(
                  width: double.infinity,
                  height: 6,
                  borderRadius: 3,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class ShimmerProfileHeader extends StatelessWidget {
  const ShimmerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColors.glassSurface,
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              ShimmerCard(
                width: 80,
                height: 80,
                borderRadius: 40,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    ShimmerCard(
                      width: 150,
                      height: 24,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 8),
                    // Email
                    ShimmerCard(
                      width: 200,
                      height: 18,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 8),
                    // Member since
                    ShimmerCard(
                      width: 120,
                      height: 14,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats row
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
                Column(
                  children: [
                    ShimmerCard(
                      width: 40,
                      height: 20,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 4),
                    ShimmerCard(
                      width: 30,
                      height: 12,
                      borderRadius: 4,
                    ),
                  ],
                ),
                Column(
                  children: [
                    ShimmerCard(
                      width: 50,
                      height: 20,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 4),
                    ShimmerCard(
                      width: 35,
                      height: 12,
                      borderRadius: 4,
                    ),
                  ],
                ),
                Column(
                  children: [
                    ShimmerCard(
                      width: 30,
                      height: 20,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 4),
                    ShimmerCard(
                      width: 25,
                      height: 12,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerAchievementBadge extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const ShimmerAchievementBadge({
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.glassSurface,
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          ShimmerCard(
            width: 48,
            height: 48,
            borderRadius: 24,
          ),
          const SizedBox(height: 8),
          // Name
          ShimmerCard(
            width: 60,
            height: 12,
            borderRadius: 4,
          ),
        ],
      ),
    );
  }
}

class ShimmerLoadingWidget extends StatelessWidget {
  final ShimmerType type;
  final int itemCount;

  const ShimmerLoadingWidget({
    super.key,
    required this.type,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ShimmerType.routeList:
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: itemCount,
          itemBuilder: (context, index) => ShimmerRouteCard(),
        );
      
      case ShimmerType.routeGrid:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) => ShimmerRouteCard(),
          ),
        );
      
      case ShimmerType.statGrid:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) => ShimmerStatCard(),
          ),
        );
      
      case ShimmerType.profile:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ShimmerProfileHeader(),
              const SizedBox(height: 32),
              // Stats section
              ...List.generate(3, (index) => ShimmerStatCard()),
              const SizedBox(height: 32),
              // Achievements section
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => ShimmerAchievementBadge(),
              ),
            ],
          ),
        );
    }
  }
}

enum ShimmerType {
  routeList,
  routeGrid,
  statGrid,
  profile,
}
