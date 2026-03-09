import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safi_delivery/core/helper/spacing.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';
import 'package:safi_delivery/features/onboarding/widget/onboarding_floating_image.dart';

class OnboardingPageContent extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool flipImage;

  const OnboardingPageContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.flipImage = false,
  });

  @override
  State<OnboardingPageContent> createState() =>
      _OnboardingPageContentState();
}

class _OnboardingPageContentState
    extends State<OnboardingPageContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController entryController;
  late final Animation<double> _opacity;
  late final Animation<double> _slideY;

  @override
  void initState() {
    super.initState();
    entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: entryController,
        curve: Curves.easeOut,
      ),
    );

    _slideY = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: entryController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpace(18.h),
          // ── Image (floating handled inside)
          OnboardingFloatingImage(
            imagePath: widget.imagePath,
            flip: widget.flipImage,
          ),
          verticalSpace(45.h),
          // ── Animated text block
          AnimatedBuilder(
            animation: entryController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacity.value,
                child: Transform.translate(
                  offset: Offset(0, _slideY.value),
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                // Title
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryColor,
                    height: 1.45,
                  ),
                ),
                verticalSpace(16.h),
                // Subtitle
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColor.withValues(
                      alpha: 0.6,
                    ),
                    height: 2.00,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
