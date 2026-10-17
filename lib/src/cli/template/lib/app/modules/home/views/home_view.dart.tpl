import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MedAppText('nav_home'.tr, fontWeight: FontWeight.w600),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => MedAppText(
                  'home_pressed'.trParams({'count': '${controller.count.value}'}),
                ),
              ),
              SizedBox(height: 16.h),
              AppElevatedButton(
                title: 'home_press_me'.tr,
                onPressed: controller.increment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
