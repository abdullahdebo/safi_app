import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safi_delivery/core/routing/app_router.dart';
import 'package:safi_delivery/core/routing/routes.dart';
import 'package:safi_delivery/core/theme/app_colors.dart';

class SafiApp extends StatelessWidget {
  final AppRouter appRouter;
  const SafiApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'safi app',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}
