import 'package:get/get.dart';

class MainController extends GetxController {
  final index = 0.obs;

  void select(int value) => index.value = value;
}
