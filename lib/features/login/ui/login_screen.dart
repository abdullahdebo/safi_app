import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safi_delivery/core/helper/spacing.dart';
import 'package:safi_delivery/core/routing/routes.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';
import 'package:safi_delivery/features/login/widget/login_button.dart';
import 'package:safi_delivery/features/login/widget/login_logo.dart';
import 'package:safi_delivery/features/login/widget/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(25.h),
                const LoginLogo(),
                verticalSpace(20.h),
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                verticalSpace(6.h),
                Text(
                  'سجّل دخولك للمتابعة',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 14.sp,
                    color: AppColors.secondaryColor.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
                verticalSpace(40.h),
                LoginTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                verticalSpace(16.h),
                LoginTextField(
                  controller: passwordController,
                  label: 'كلمة المرور',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  onToggleObscure: () {
                    setState(
                      () => _obscurePassword = !_obscurePassword,
                    );
                  },
                ),
                verticalSpace(28.h),
                LoginButton(
                  label: 'تسجيل الدخول',
                  onPressed: () {},
                ),
                verticalSpace(12.h),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 14.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                verticalSpace(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 13.sp,
                        color: AppColors.secondaryColor
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.register,
                      ),
                      child: Text(
                        'إنشاء حساب',
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          fontSize: 13.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
