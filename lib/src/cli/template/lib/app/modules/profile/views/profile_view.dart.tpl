import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MedAppText('nav_profile'.tr, fontWeight: FontWeight.w600),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            const Spacer(),
            AppElevatedButton(
              title: 'profile_sign_out'.tr,
              onPressed: controller.signOut,
            ),
          ],
        ),
      ),
    );
  }
}
