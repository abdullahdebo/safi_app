import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safi_delivery/core/helper/extensions.dart';
import 'package:safi_delivery/core/helper/spacing.dart';
import 'package:safi_delivery/core/routing/routes.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';
import 'package:safi_delivery/features/onboarding/widget/onboarding_action_button.dart';
import 'package:safi_delivery/features/onboarding/widget/onboarding_dot_indicator.dart';
import 'package:safi_delivery/features/onboarding/widget/onboarding_page_content.dart';

// ─── Data model

class OnboardingData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final bool flipImage;

  const OnboardingData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.flipImage = false,
  });
}

const pages = [
  OnboardingData(
    imagePath: 'assets/image/delivery_moto.png',
    title: 'وصّلنالك وين ما كنت!',
    subtitle: 'من قلب حلب لعندك،\nتوصيل سريع ومضمون على طول.',
    buttonLabel: 'التالي',
    flipImage: true,
  ),
  OnboardingData(
    imagePath: 'assets/image/man_stand.png',
    title: 'صافي دليفري',
    subtitle:
        'كل طلبك يوصلك بأمان وبإيد أمينة،\nونحنا دايمًا معك.',
    buttonLabel: 'يلا خلينا نبلش',
  ),
];

// ─── Screen ─────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onActionTapped() {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    } else {
      context.pushReplacementNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) =>
                      setState(() => currentPage = index),
                  itemBuilder: (context, index) {
                    final data = pages[index];
                    return OnboardingPageContent(
                      key: ValueKey(index),
                      imagePath: data.imagePath,
                      title: data.title,
                      subtitle: data.subtitle,
                      flipImage: data.flipImage,
                    );
                  },
                ),
              ),

              // ── Bottom bar: dots + button
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 32.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OnboardingDotIndicator(
                      count: pages.length,
                      currentIndex: currentPage,
                    ),
                    verticalSpace(24.h),
                    AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      child: OnboardingActionButton(
                        key: ValueKey(currentPage),
                        label: pages[currentPage].buttonLabel,
                        onTap: onActionTapped,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
