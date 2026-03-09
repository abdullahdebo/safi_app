import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safi_delivery/core/helper/spacing.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';
import 'package:safi_delivery/features/login/widget/login_logo.dart';
import 'package:safi_delivery/features/register/widget/register_button.dart';
import 'package:safi_delivery/features/register/widget/register_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
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
                  'إنشاء حساب',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                verticalSpace(6.h),
                Text(
                  'أنشئ حسابك للبدء',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 14.sp,
                    letterSpacing: 0.3,
                    color: AppColors.secondaryColor.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
                verticalSpace(40.h),
                RegisterTextField(
                  controller: nameController,
                  label: 'الاسم',
                  icon: Icons.person_outline,
                ),
                verticalSpace(16.h),
                RegisterTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                verticalSpace(16.h),
                RegisterTextField(
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
                RegisterButton(
                  label: 'إنشاء حساب',
                  onPressed: () {},
                ),
                verticalSpace(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لديك حساب بالفعل؟',
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 13.sp,
                        color: AppColors.secondaryColor
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'تسجيل الدخول',
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
