import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingFloatingImage extends StatefulWidget {
  final String imagePath;
  final bool flip;

  const OnboardingFloatingImage({
    super.key,
    required this.imagePath,
    this.flip = false,
  });

  @override
  State<OnboardingFloatingImage> createState() =>
      _OnboardingFloatingImageState();
}

class _OnboardingFloatingImageState
    extends State<OnboardingFloatingImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatOffset;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _floatOffset = Tween<double>(begin: 0.0, end: -10.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatOffset.value),
          child: child,
        );
      },
      child: Transform.scale(
        scaleX: widget.flip ? -1.0 : 1.0,
        child: Image.asset(
          widget.imagePath,
          width: 280.w,
          height: 280.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
