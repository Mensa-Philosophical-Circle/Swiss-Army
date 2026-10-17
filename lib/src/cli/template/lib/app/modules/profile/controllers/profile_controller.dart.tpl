import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  void signOut() {
    // Clear the saved session here.
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
