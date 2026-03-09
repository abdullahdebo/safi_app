import 'package:flutter/material.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';

class OnboardingDotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardingDotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isActive ? 26 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(
                      alpha: 0.25,
                    ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        );
      }),
    );
  }
}
