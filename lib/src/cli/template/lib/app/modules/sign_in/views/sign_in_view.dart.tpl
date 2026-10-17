import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.h),
                BigAppText(
                  'sign_in_title'.tr,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                MedAppText('sign_in_subtitle'.tr, fontSize: 14.sp),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: controller.email,
                  label: 'email_label'.tr,
                  hint: 'email_hint'.tr,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),
                SizedBox(height: 16.h),
                AppPasswordField(
                  controller: controller.password,
                  label: 'password_label'.tr,
                  hint: 'password_hint'.tr,
                  validator: controller.validatePassword,
                  onSubmitted: (_) => controller.submit(),
                ),
                SizedBox(height: 32.h),
                Obx(
                  () => AppElevatedButton(
                    title: 'sign_in_submit'.tr,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
