import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../../../utils/constants/app_constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Replace with your logo (declare its path as a constant, never in the widget).
            Icon(Icons.shield_outlined, size: 96.sp, color: Colors.white),
            SizedBox(height: 16.h),
            BigAppText(
              AppConstants.appName,
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
