import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: MedAppText('not_found_title'.tr)));
  }
}
