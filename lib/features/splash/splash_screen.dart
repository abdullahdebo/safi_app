import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safi_delivery/core/helper/extensions.dart';
import 'package:safi_delivery/core/routing/routes.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';

//
// Splash Screen
//

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _pulseController;
  late final AnimationController _motoController;

  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleEntryAnim;
  late final Animation<double> _scalepulseAnim;

  @override
  void initState() {
    super.initState();

    // One-shot entry: fade + scale with easeOutBack bounce
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Continuous gentle pulse after entry
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Delivery moto sweeping across the bottom
    _motoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Curves.easeOut,
      ),
    );

    _scaleEntryAnim = Tween<double>(begin: 0.5, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _entryController,
            curve: Curves.easeOutBack,
          ),
        );

    _scalepulseAnim = Tween<double>(begin: 1.0, end: 1.03)
        .animate(
          CurvedAnimation(
            parent: _pulseController,
            curve: Curves.easeInOut,
          ),
        );

    _entryController.forward().then((_) {
      if (mounted) {
        _pulseController.repeat(reverse: true);
        _motoController.forward().then((_) {
          if (mounted) _navigateAfterDelay();
        });
      }
    });
  }

  void _navigateAfterDelay() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.pushNamedAndRemoveUntil(
        Routes.onBoarding,
        predicate: (_) => false,
      );
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    _motoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 130.h,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _entryController,
                  _pulseController,
                ]),
                builder: (context, child) {
                  final scale = _entryController.isCompleted
                      ? _scaleEntryAnim.value *
                            _scalepulseAnim.value
                      : _scaleEntryAnim.value;
                  return Opacity(
                    opacity: _fadeAnim.value,
                    child: Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  'assets/image/new_logo.png',
                  width: 400.w,
                  height: 400.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Delivery moto sweeping right → left (RTL)
          _MotoRider(controller: _motoController),
        ],
      ),
    );
  }
}

//
// Moto Rider
//

class _MotoRider extends StatelessWidget {
  const _MotoRider({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        // Two-phase "zoom-past" curve: fast arrival, accelerating exit
        final curved = TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 0.0,
              end: 0.5,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 40,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.5,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 60,
          ),
        ]).evaluate(AlwaysStoppedAnimation(controller.value));

        // RIGHT → LEFT (RTL direction)
        final x = lerpDouble(
          screenWidth * 0.65,
          -screenWidth * 0.65,
          curved,
        )!;

        return Positioned(
          bottom: 95.h,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(x, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Moto faces left (flipped), leading the row
                  Transform.rotate(
                    angle: -0.04, // slight forward lean
                    child: Transform.scale(
                      scaleX: -1,
                      child: Image.asset(
                        'assets/image/new_man.png',
                        width: 95.w,
                        height: 95.h,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Dashes trail to the right behind the moto
                  _SpeedDash(
                    width: 8,
                    height: 1.5,
                    opacity: 0.15,
                  ),
                  const SizedBox(width: 4),
                  _SpeedDash(
                    width: 14,
                    height: 2.0,
                    opacity: 0.30,
                  ),
                  const SizedBox(width: 4),
                  _SpeedDash(
                    width: 22,
                    height: 2.5,
                    opacity: 0.55,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//
// Speed Dash
//

class _SpeedDash extends StatelessWidget {
  const _SpeedDash({
    required this.width,
    required this.height,
    required this.opacity,
  });

  final double width;
  final double height;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
