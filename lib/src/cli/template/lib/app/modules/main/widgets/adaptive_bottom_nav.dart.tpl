import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class AdaptiveNavItem {
  const AdaptiveNavItem({
    required this.labelKey,
    required this.icon,
    required this.activeIcon,
  });

  /// The translation key of the label, not the text.
  final String labelKey;
  final IconData icon;
  final IconData activeIcon;
}

/// A bottom bar that looks native on each platform: liquid glass on iOS, Material 3 on Android.
class AdaptiveBottomNav extends StatelessWidget {
  const AdaptiveBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<AdaptiveNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GlassTabBar.bottom(
        tabs: [
          for (final item in items)
            GlassTab(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.labelKey.tr,
            ),
        ],
        selectedIndex: selectedIndex,
        onTabSelected: onSelected,
        selectedIconColor: scheme.primary,
        unselectedIconColor: scheme.onSurfaceVariant,
        selectedLabelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
      );
    }
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.activeIcon),
            label: item.labelKey.tr,
          ),
      ],
    );
  }
}
