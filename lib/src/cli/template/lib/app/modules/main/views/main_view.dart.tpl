import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/main_controller.dart';
import '../widgets/adaptive_bottom_nav.dart';

/// The screen with the bottom navigation bar. Add a tab: one entry in [_tabs] and one in [_pages].
class MainView extends GetView<MainController> {
  const MainView({super.key});

  static const _pages = <Widget>[HomeView(), ProfileView()];

  static const _tabs = <AdaptiveNavItem>[
    AdaptiveNavItem(
      labelKey: 'nav_home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    AdaptiveNavItem(
      labelKey: 'nav_profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: controller.index.value, children: _pages),
        bottomNavigationBar: AdaptiveBottomNav(
          items: _tabs,
          selectedIndex: controller.index.value,
          onSelected: controller.select,
        ),
      ),
    );
  }
}
