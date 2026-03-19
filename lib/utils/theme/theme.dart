import 'package:flutter/material.dart';

import 'chip_theme.dart';
import 'colors.dart';
import 'theme_config.dart';

/// Swiss Army Component Theme Factory
///
/// Provides light and dark themes with optional customization.
///
/// Basic usage (with defaults):
/// ```dart
/// MaterialApp(
///   theme: SACTheme.light(),
///   darkTheme: SACTheme.dark(),
/// );
/// ```
///
/// Custom colors:
/// ```dart
/// final config = SACThemeConfig(
///   primary: Colors.blue,
///   secondary: Colors.amber,
///   scaffoldBackgroundLight: Colors.grey[50],
/// );
///
/// MaterialApp(
///   theme: SACTheme.light(config),
///   darkTheme: SACTheme.dark(config),
/// );
/// ```
class SACTheme {
  /// Returns default color values merged with custom config
  static _ResolvedColors _resolveColors(SACThemeConfig? config, bool isDark) {
    return _ResolvedColors(
      primary: isDark
          ? (config?.primaryDark ?? config?.primary ?? AppColors.primary)
          : (config?.primaryLight ?? config?.primary ?? AppColors.primary),
      secondary: isDark
          ? (config?.secondaryDark ?? config?.secondary ?? AppColors.secondary)
          : (config?.secondaryLight ??
                config?.secondary ??
                AppColors.secondary),
      error: isDark
          ? (config?.errorDark ?? config?.error ?? AppColors.red)
          : (config?.errorLight ?? config?.error ?? AppColors.red),
      success: isDark
          ? (config?.successDark ?? config?.success ?? AppColors.green)
          : (config?.successLight ?? config?.success ?? AppColors.green),
      background: isDark
          ? (config?.backgroundDark ?? AppColors.backgroundDark)
          : (config?.backgroundLight ?? AppColors.backgroundLight),
      surface: isDark
          ? (config?.surfaceDark ?? AppColors.surfaceDark)
          : (config?.surfaceLight ?? AppColors.surfaceLight),
      border: isDark
          ? (config?.borderDark ?? AppColors.borderDark)
          : (config?.borderLight ?? AppColors.borderLight),
      textPrimary: isDark
          ? (config?.textPrimaryDark ?? AppColors.textPrimaryDark)
          : (config?.textPrimaryLight ?? AppColors.textPrimaryLight),
      textMuted: isDark
          ? (config?.textMutedDark ?? AppColors.textMutedDark)
          : (config?.textMutedLight ?? AppColors.textMutedLight),
      // --- Component Colors ---
      scaffoldBackground: isDark
          ? (config?.scaffoldBackgroundDark ??
                config?.backgroundDark ??
                AppColors.backgroundDark)
          : (config?.scaffoldBackgroundLight ??
                config?.backgroundLight ??
                AppColors.backgroundLight),
      appBarBackground: isDark
          ? (config?.appBarBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.appBarBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      appBarForeground: isDark
          ? (config?.appBarForegroundDark ??
                config?.textPrimaryDark ??
                AppColors.textPrimaryDark)
          : (config?.appBarForegroundLight ??
                config?.textPrimaryLight ??
                AppColors.textPrimaryLight),
      bottomNavBackground: isDark
          ? (config?.bottomNavBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.bottomNavBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      drawerBackground: isDark
          ? (config?.drawerBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.drawerBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      fabBackground: isDark
          ? (config?.fabBackgroundDark ??
                config?.primaryDark ??
                config?.primary ??
                AppColors.primary)
          : (config?.fabBackgroundLight ??
                config?.primaryLight ??
                config?.primary ??
                AppColors.primary),
      fabForeground: isDark
          ? (config?.fabForegroundDark ?? AppColors.white)
          : (config?.fabForegroundLight ?? AppColors.white),
      cardColor: isDark
          ? (config?.cardColorDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.cardColorLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      dialogBackground: isDark
          ? (config?.dialogBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.dialogBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      bottomSheetBackground: isDark
          ? (config?.bottomSheetBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.bottomSheetBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      inputFillColor: isDark
          ? (config?.inputFillColorDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.inputFillColorLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      chipBackground: isDark
          ? (config?.chipBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.chipBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      popupMenuBackground: isDark
          ? (config?.popupMenuBackgroundDark ??
                config?.surfaceDark ??
                AppColors.surfaceDark)
          : (config?.popupMenuBackgroundLight ??
                config?.surfaceLight ??
                AppColors.surfaceLight),
      inputHeight: config?.inputHeight ?? 52.0,
      buttonHeight: config?.buttonHeight ?? 52.0,
      elevatedButtonBackgroundColor: isDark
          ? (config?.elevatedButtonBackgroundColorDark ??
              config?.elevatedButtonBackgroundColor)
          : (config?.elevatedButtonBackgroundColorLight ??
              config?.elevatedButtonBackgroundColor),
      elevatedButtonForegroundColor: isDark
          ? (config?.elevatedButtonForegroundColorDark ??
              config?.elevatedButtonForegroundColor)
          : (config?.elevatedButtonForegroundColorLight ??
              config?.elevatedButtonForegroundColor),
      outlinedButtonTextColor: isDark
          ? (config?.outlinedButtonTextColorDark ??
              config?.outlinedButtonTextColor)
          : (config?.outlinedButtonTextColorLight ??
              config?.outlinedButtonTextColor),
      outlinedButtonBorderColor: isDark
          ? (config?.outlinedButtonBorderColorDark ??
              config?.outlinedButtonBorderColor)
          : (config?.outlinedButtonBorderColorLight ??
              config?.outlinedButtonBorderColor),
      textButtonTextColor: isDark
          ? (config?.textButtonTextColorDark ?? config?.textButtonTextColor)
          : (config?.textButtonTextColorLight ?? config?.textButtonTextColor),
      filledButtonBackgroundColor: isDark
          ? (config?.filledButtonBackgroundColorDark ??
              config?.filledButtonBackgroundColor)
          : (config?.filledButtonBackgroundColorLight ??
              config?.filledButtonBackgroundColor),
      filledButtonForegroundColor: isDark
          ? (config?.filledButtonForegroundColorDark ??
              config?.filledButtonForegroundColor)
          : (config?.filledButtonForegroundColorLight ??
              config?.filledButtonForegroundColor),
    );
  }

  /// Generate a light theme with optional custom colors
  static ThemeData light([SACThemeConfig? config]) {
    final colors = _resolveColors(config, false);

    final lightScheme = ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: Brightness.light,
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.surface,
      error: colors.error,

      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: colors.textPrimary,

      onError: AppColors.white,
    );

    return _buildTheme(
      brightness: Brightness.light,
      colors: colors,
      scheme: lightScheme,
      config: config,
    );
  }

  /// Generate a dark theme with optional custom colors
  static ThemeData dark([SACThemeConfig? config]) {
    final colors = _resolveColors(config, true);

    final darkScheme = ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: Brightness.dark,
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.surface,
      error: colors.error,

      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: colors.textPrimary,

      onError: AppColors.white,
    );

    return _buildTheme(
      brightness: Brightness.dark,
      colors: colors,
      scheme: darkScheme,
      config: config,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required _ResolvedColors colors,
    required ColorScheme scheme,
    SACThemeConfig? config,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.scaffoldBackground,
      cardColor: colors.cardColor,
      dividerColor: config?.dividerColor ?? colors.border,
      disabledColor:
          config?.disabledColor ?? AppColors.grey.withValues(alpha: 0.5),
      splashColor: config?.splashColor,
      highlightColor: config?.highlightColor,
      hoverColor: config?.hoverColor,
      focusColor: config?.focusColor,
      shadowColor: config?.shadowColor,
      visualDensity: config?.visualDensity,
      materialTapTargetSize: config?.materialTapTargetSize,

      // Typography
      fontFamily: config?.fontFamily,
      textTheme: TextTheme(
        displayLarge:
            config?.displayLarge ?? TextStyle(color: colors.textPrimary),
        displayMedium:
            config?.displayMedium ?? TextStyle(color: colors.textPrimary),
        displaySmall:
            config?.displaySmall ?? TextStyle(color: colors.textPrimary),
        headlineLarge:
            config?.headlineLarge ?? TextStyle(color: colors.textPrimary),
        headlineMedium:
            config?.headlineMedium ?? TextStyle(color: colors.textPrimary),
        headlineSmall:
            config?.headlineSmall ?? TextStyle(color: colors.textPrimary),
        titleLarge: config?.titleLarge ?? TextStyle(color: colors.textPrimary),
        titleMedium:
            config?.titleMedium ?? TextStyle(color: colors.textPrimary),
        titleSmall: config?.titleSmall ?? TextStyle(color: colors.textPrimary),
        bodyLarge: config?.bodyLarge ?? TextStyle(color: colors.textPrimary),
        bodyMedium: config?.bodyMedium ?? TextStyle(color: colors.textPrimary),
        bodySmall: config?.bodySmall ?? TextStyle(color: colors.textMuted),
        labelLarge: config?.labelLarge ?? TextStyle(color: colors.textPrimary),
        labelMedium:
            config?.labelMedium ?? TextStyle(color: colors.textPrimary),
        labelSmall: config?.labelSmall ?? TextStyle(color: colors.textPrimary),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colors.appBarBackground,
        foregroundColor: colors.appBarForeground,
        elevation: config?.appBarElevation ?? 0,
        centerTitle: config?.appBarCenterTitle,
        titleTextStyle:
            config?.appBarTitleTextStyle?.copyWith(
              color: colors.appBarForeground,
            ) ??
            TextStyle(
              color: colors.appBarForeground,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
        iconTheme:
            config?.appBarIconTheme ??
            IconThemeData(color: colors.appBarForeground),
        surfaceTintColor: Colors.transparent,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.bottomNavBackground,
        selectedItemColor: config?.bottomNavSelectedColor ?? colors.primary,
        unselectedItemColor:
            config?.bottomNavUnselectedColor ?? colors.textMuted,
        elevation: config?.bottomNavElevation ?? 8,
        type: config?.bottomNavType,
      ),

      // Navigation Bar (M3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark
            ? (config?.navigationBarBackgroundDark ?? colors.surface)
            : (config?.navigationBarBackgroundLight ?? colors.surface),
        indicatorColor:
            config?.navigationBarIndicatorColor ??
            colors.primary.withValues(alpha: 0.2),
        height: config?.navigationBarHeight,
      ),

      // Navigation Rail
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: isDark
            ? (config?.navigationRailBackgroundDark ?? colors.surface)
            : (config?.navigationRailBackgroundLight ?? colors.surface),
        selectedIconTheme: IconThemeData(
          color: config?.navigationRailSelectedColor ?? colors.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: config?.navigationRailUnselectedColor ?? colors.textMuted,
        ),
      ),

      // Drawer
      drawerTheme: DrawerThemeData(
        backgroundColor: colors.drawerBackground,
        width: config?.drawerWidth,
        elevation: config?.drawerElevation,
      ),

      // FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.fabBackground,
        foregroundColor: colors.fabForeground,
        elevation: config?.fabElevation,
        shape: config?.fabShape,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              colors.elevatedButtonBackgroundColor ?? colors.primary,
          foregroundColor:
              colors.elevatedButtonForegroundColor ?? AppColors.white,
          elevation: 0,
          minimumSize: Size(0, colors.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).merge(config?.elevatedButtonStyle),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.outlinedButtonTextColor ?? colors.primary,
          side: BorderSide(
            color: colors.outlinedButtonBorderColor ?? colors.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).merge(config?.outlinedButtonStyle),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.textButtonTextColor ?? colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).merge(config?.textButtonStyle),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor:
              colors.filledButtonBackgroundColor ?? colors.primary,
          foregroundColor:
              colors.filledButtonForegroundColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).merge(config?.filledButtonStyle),
      ),
      iconButtonTheme: IconButtonThemeData(style: config?.iconButtonStyle),

      // Card
      cardTheme: CardThemeData(
        color: colors.cardColor,
        elevation: config?.cardElevation ?? 0,
        shape:
            config?.cardShape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: colors.border, width: 1),
            ),
        margin: config?.cardMargin,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: colors.dialogBackground,
        elevation: config?.dialogElevation,
        shape:
            config?.dialogShape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: config?.dialogTitleStyle,
        contentTextStyle: config?.dialogContentStyle,
      ),

      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.bottomSheetBackground,
        elevation: config?.bottomSheetElevation,
        shape:
            config?.bottomSheetShape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
        dragHandleColor: config?.bottomSheetDragHandleColor,
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark
            ? (config?.snackBarBackgroundDark ?? AppColors.surfaceLight)
            : (config?.snackBarBackgroundLight ?? AppColors.surfaceDark),
        actionTextColor: config?.snackBarActionColor ?? colors.primary,
        behavior: config?.snackBarBehavior,
        contentTextStyle: TextStyle(
          color: isDark
              ? AppColors.textPrimaryLight
              : AppColors.textPrimaryDark,
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(config?.inputBorderRadius ?? 12),
          borderSide: BorderSide(
            color: isDark
                ? (config?.inputBorderColorDark ??
                      config?.inputBorderColor ??
                      colors.border)
                : (config?.inputBorderColorLight ??
                      config?.inputBorderColor ??
                      colors.border),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(config?.inputBorderRadius ?? 12),
          borderSide: BorderSide(
            color: isDark
                ? (config?.inputBorderColorDark ??
                      config?.inputBorderColor ??
                      colors.border)
                : (config?.inputBorderColorLight ??
                      config?.inputBorderColor ??
                      colors.border),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(config?.inputBorderRadius ?? 12),
          borderSide: BorderSide(
            color: isDark
                ? (config?.inputFocusedBorderColorDark ??
                      config?.inputFocusedBorderColor ??
                      colors.primary)
                : (config?.inputFocusedBorderColorLight ??
                      config?.inputFocusedBorderColor ??
                      colors.primary),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(config?.inputBorderRadius ?? 12),
          borderSide: BorderSide(
            color: isDark
                ? (config?.inputErrorBorderColorDark ??
                      config?.inputErrorBorderColor ??
                      colors.error)
                : (config?.inputErrorBorderColorLight ??
                      config?.inputErrorBorderColor ??
                      colors.error),
          ),
        ),
        labelStyle: config?.inputLabelStyle,
        hintStyle: config?.inputHintStyle ?? TextStyle(color: colors.textMuted),
      ),

      // Checkbox, Radio, Switch
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? (isDark
                    ? (config?.checkboxFillColorDark ??
                          config?.checkboxFillColor ??
                          colors.primary)
                    : (config?.checkboxFillColorLight ??
                          config?.checkboxFillColor ??
                          colors.primary))
              : null,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? (isDark
                    ? (config?.radioFillColorDark ??
                          config?.radioFillColor ??
                          colors.primary)
                    : (config?.radioFillColorLight ??
                          config?.radioFillColor ??
                          colors.primary))
              : null,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? (isDark
                    ? (config?.switchActiveColorDark ??
                          config?.switchActiveColor ??
                          colors.primary)
                    : (config?.switchActiveColorLight ??
                          config?.switchActiveColor ??
                          colors.primary))
              : (isDark
                    ? (config?.switchInactiveColorDark ??
                          config?.switchInactiveColor ??
                          colors.textMuted)
                    : (config?.switchInactiveColorLight ??
                          config?.switchInactiveColor ??
                          colors.textMuted)),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => (isDark
              ? (config?.switchTrackColorDark ??
                    config?.switchTrackColor ??
                    colors.border.withValues(alpha: 0.3))
              : (config?.switchTrackColorLight ??
                    config?.switchTrackColor ??
                    colors.border.withValues(alpha: 0.3))),
        ),
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: isDark
            ? (config?.sliderActiveColorDark ??
                  config?.sliderActiveColor ??
                  colors.primary)
            : (config?.sliderActiveColorLight ??
                  config?.sliderActiveColor ??
                  colors.primary),
        inactiveTrackColor: isDark
            ? (config?.sliderInactiveColorDark ??
                  config?.sliderInactiveColor ??
                  colors.border)
            : (config?.sliderInactiveColorLight ??
                  config?.sliderInactiveColor ??
                  colors.border),
        thumbColor: isDark
            ? (config?.sliderThumbColorDark ??
                  config?.sliderThumbColor ??
                  colors.primary)
            : (config?.sliderThumbColorLight ??
                  config?.sliderThumbColor ??
                  colors.primary),
      ),

      // Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDark
            ? (config?.progressIndicatorColorDark ??
                  config?.progressIndicatorColor ??
                  colors.primary)
            : (config?.progressIndicatorColorLight ??
                  config?.progressIndicatorColor ??
                  colors.primary),
        circularTrackColor: isDark
            ? (config?.progressIndicatorBackgroundColorDark ??
                  config?.progressIndicatorBackgroundColor ??
                  colors.border.withValues(alpha: 0.2))
            : (config?.progressIndicatorBackgroundColorLight ??
                  config?.progressIndicatorBackgroundColor ??
                  colors.border.withValues(alpha: 0.2)),
      ),

      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color:
              config?.tooltipBackgroundColor ??
              (isDark ? AppColors.surfaceLight : AppColors.surfaceDark),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle:
            config?.tooltipTextStyle ??
            TextStyle(
              color: isDark
                  ? AppColors.textPrimaryLight
                  : AppColors.textPrimaryDark,
            ),
        padding: config?.tooltipPadding,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: isDark
            ? (config?.dividerColorDark ??
                  config?.dividerColor ??
                  colors.border)
            : (config?.dividerColorLight ??
                  config?.dividerColor ??
                  colors.border),
        thickness: config?.dividerThickness ?? 1,
        indent: config?.dividerIndent ?? 0,
        endIndent: config?.dividerIndent ?? 0,
      ),

      // ListTile
      // ListTile
      listTileTheme: ListTileThemeData(
        iconColor: isDark
            ? (config?.listTileIconColorDark ??
                  config?.listTileIconColor ??
                  colors.textMuted)
            : (config?.listTileIconColorLight ??
                  config?.listTileIconColor ??
                  colors.textMuted),
        titleTextStyle: config?.listTileTitleStyle,
        subtitleTextStyle: config?.listTileSubtitleStyle,
        selectedColor: isDark
            ? (config?.listTileSelectedColorDark ??
                  config?.listTileSelectedColor ??
                  colors.primary)
            : (config?.listTileSelectedColorLight ??
                  config?.listTileSelectedColor ??
                  colors.primary),
      ),

      // TabBar
      // TabBar
      tabBarTheme: TabBarThemeData(
        indicatorColor: isDark
            ? (config?.tabBarIndicatorColorDark ??
                  config?.tabBarIndicatorColor ??
                  colors.primary)
            : (config?.tabBarIndicatorColorLight ??
                  config?.tabBarIndicatorColor ??
                  colors.primary),
        labelColor: isDark
            ? (config?.tabBarLabelColorDark ??
                  config?.tabBarLabelColor ??
                  colors.primary)
            : (config?.tabBarLabelColorLight ??
                  config?.tabBarLabelColor ??
                  colors.primary),
        unselectedLabelColor: isDark
            ? (config?.tabBarUnselectedLabelColorDark ??
                  config?.tabBarUnselectedLabelColor ??
                  colors.textMuted)
            : (config?.tabBarUnselectedLabelColorLight ??
                  config?.tabBarUnselectedLabelColor ??
                  colors.textMuted),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // DataTable
      // DataTable
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(
          isDark
              ? (config?.dataTableHeadingRowColorDark ??
                    config?.dataTableHeadingRowColor ??
                    colors.surface)
              : (config?.dataTableHeadingRowColorLight ??
                    config?.dataTableHeadingRowColor ??
                    colors.surface),
        ),
        dataRowColor: WidgetStateProperty.all(
          isDark
              ? (config?.dataTableDataRowColorDark ??
                    config?.dataTableDataRowColor ??
                    colors.background)
              : (config?.dataTableDataRowColorLight ??
                    config?.dataTableDataRowColor ??
                    colors.background),
        ),
        dividerThickness: config?.dataTableDividerThickness,
      ),

      // Chip
      chipTheme:
          (isDark ? AppChipTheme.darkChipTheme : AppChipTheme.lightChipTheme)
              .copyWith(
                backgroundColor: colors.chipBackground,
                labelStyle:
                    config?.chipLabelStyle ??
                    TextStyle(color: colors.textPrimary),
                deleteIconColor:
                    config?.chipDeleteIconColor ?? colors.textMuted,
                selectedColor:
                    config?.chipSelectedColor ??
                    colors.primary.withValues(alpha: 0.2),
                side: BorderSide(color: colors.border),
              ),

      // Badge
      // Badge
      badgeTheme: BadgeThemeData(
        backgroundColor: isDark
            ? (config?.badgeBackgroundColorDark ??
                  config?.badgeBackgroundColor ??
                  colors.error)
            : (config?.badgeBackgroundColorLight ??
                  config?.badgeBackgroundColor ??
                  colors.error),
        textColor: isDark
            ? (config?.badgeTextColorDark ??
                  config?.badgeTextColor ??
                  AppColors.white)
            : (config?.badgeTextColorLight ??
                  config?.badgeTextColor ??
                  AppColors.white),
      ),

      // SearchBar
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(
          isDark
              ? (config?.searchBarBackgroundDark ?? colors.surface)
              : (config?.searchBarBackgroundLight ?? colors.surface),
        ),
        elevation: WidgetStateProperty.all(config?.searchBarElevation ?? 0),
        hintStyle: WidgetStateProperty.all(
          config?.searchBarHintStyle ?? TextStyle(color: colors.textMuted),
        ),
      ),

      // SegmentedButton
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return isDark
                  ? (config?.segmentedButtonSelectedColorDark ??
                        config?.segmentedButtonSelectedColor ??
                        colors.primary.withValues(alpha: 0.2))
                  : (config?.segmentedButtonSelectedColorLight ??
                        config?.segmentedButtonSelectedColor ??
                        colors.primary.withValues(alpha: 0.2));
            }
            return null;
          }),
          foregroundColor: WidgetStateProperty.all(
            isDark
                ? (config?.segmentedButtonForegroundColorDark ??
                      config?.segmentedButtonForegroundColor ??
                      colors.textPrimary)
                : (config?.segmentedButtonForegroundColorLight ??
                      config?.segmentedButtonForegroundColor ??
                      colors.textPrimary),
          ),
        ),
      ),

      // PopupMenu
      popupMenuTheme: PopupMenuThemeData(
        color: colors.popupMenuBackground,
        elevation: config?.popupMenuElevation,
        shape:
            config?.popupMenuShape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // ExpansionTile
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: isDark
            ? (config?.expansionTileBackgroundColorDark ??
                  config?.expansionTileBackgroundColor ??
                  Colors.transparent)
            : (config?.expansionTileBackgroundColorLight ??
                  config?.expansionTileBackgroundColor ??
                  Colors.transparent),
        collapsedBackgroundColor: isDark
            ? (config?.expansionTileCollapsedBackgroundColorDark ??
                  config?.expansionTileCollapsedBackgroundColor ??
                  Colors.transparent)
            : (config?.expansionTileCollapsedBackgroundColorLight ??
                  config?.expansionTileCollapsedBackgroundColor ??
                  Colors.transparent),
        iconColor: isDark
            ? (config?.expansionTileIconColorDark ??
                  config?.expansionTileIconColor ??
                  colors.primary)
            : (config?.expansionTileIconColorLight ??
                  config?.expansionTileIconColor ??
                  colors.primary),
        textColor: colors.textPrimary,
        collapsedTextColor: colors.textPrimary,
      ),
      extensions: [
        SACThemeExtension(
          inputHeight: colors.inputHeight,
          buttonHeight: colors.buttonHeight,
        ),
      ],
    );
  }
}

/// Theme extension for Swiss Army Component specific properties
class SACThemeExtension extends ThemeExtension<SACThemeExtension> {
  final double? inputHeight;
  final double? buttonHeight;

  SACThemeExtension({this.inputHeight, this.buttonHeight});

  @override
  SACThemeExtension copyWith({double? inputHeight, double? buttonHeight}) {
    return SACThemeExtension(
      inputHeight: inputHeight ?? this.inputHeight,
      buttonHeight: buttonHeight ?? this.buttonHeight,
    );
  }

  @override
  SACThemeExtension lerp(ThemeExtension<SACThemeExtension>? other, double t) {
    if (other is! SACThemeExtension) return this;
    return SACThemeExtension(
      inputHeight: lerpDouble(inputHeight, other.inputHeight, t),
      buttonHeight: lerpDouble(buttonHeight, other.buttonHeight, t),
    );
  }

  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }
}

extension SACThemeContext on BuildContext {
  SACThemeExtension get sacTheme =>
      Theme.of(this).extension<SACThemeExtension>() ?? SACThemeExtension();

  double get inputHeight => sacTheme.inputHeight ?? 52.0;
  double get buttonHeight => sacTheme.buttonHeight ?? 52.0;

  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

/// Legacy aliases for backward compatibility
class AppTheme {
  @Deprecated('Use SACTheme.light() instead')
  static ThemeData get lighttheme => SACTheme.light();

  @Deprecated('Use SACTheme.dark() instead')
  static ThemeData get darkTheme => SACTheme.dark();
}

/// Base class to create your own themed variants while reusing SACTheme builders.
abstract class SACThemeBase {
  const SACThemeBase();

  /// Provide your custom config. Return null to use defaults.
  SACThemeConfig? config();

  ThemeData light() => SACTheme.light(config());

  ThemeData dark() => SACTheme.dark(config());
}

/// Internal class to hold resolved color values
class _ResolvedColors {
  final Color primary;
  final Color secondary;
  final Color error;
  final Color success;
  final Color background;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textMuted;
  final Color scaffoldBackground;
  final Color appBarBackground;
  final Color appBarForeground;
  final Color bottomNavBackground;
  final Color drawerBackground;
  final Color fabBackground;
  final Color fabForeground;
  final Color cardColor;
  final Color dialogBackground;
  final Color bottomSheetBackground;
  final Color inputFillColor;
  final Color chipBackground;
  final Color popupMenuBackground;
  final double inputHeight;
  final double buttonHeight;

  final Color? elevatedButtonBackgroundColor;
  final Color? elevatedButtonForegroundColor;
  final Color? outlinedButtonTextColor;
  final Color? outlinedButtonBorderColor;
  final Color? textButtonTextColor;
  final Color? filledButtonBackgroundColor;
  final Color? filledButtonForegroundColor;

  _ResolvedColors({
    required this.primary,
    required this.secondary,
    required this.error,
    required this.success,
    required this.background,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textMuted,
    required this.scaffoldBackground,
    required this.appBarBackground,
    required this.appBarForeground,
    required this.bottomNavBackground,
    required this.drawerBackground,
    required this.fabBackground,
    required this.fabForeground,
    required this.cardColor,
    required this.dialogBackground,
    required this.bottomSheetBackground,
    required this.inputFillColor,
    required this.chipBackground,
    required this.popupMenuBackground,
    required this.inputHeight,
    required this.buttonHeight,
    this.elevatedButtonBackgroundColor,
    this.elevatedButtonForegroundColor,
    this.outlinedButtonTextColor,
    this.outlinedButtonBorderColor,
    this.textButtonTextColor,
    this.filledButtonBackgroundColor,
    this.filledButtonForegroundColor,
  });
}
