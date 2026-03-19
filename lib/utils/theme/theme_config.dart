import 'package:flutter/material.dart';

/// Configuration class for customizing Swiss Army Component theme colors.
///
/// Pass custom colors to override defaults. Any null values will use the default colors.
///
/// Example:
/// ```dart
/// final config = SACThemeConfig(
///   primary: Colors.blue,
///   secondary: Colors.amber,
///   scaffoldBackgroundLight: Colors.grey[50],
///   appBarElevation: 0,
/// );
///
/// MaterialApp(
///   theme: SACTheme.light(config),
///   darkTheme: SACTheme.dark(config),
/// );
/// ```
class SACThemeConfig {
  /// Primary brand color
  final Color? primary;

  /// Primary color for light mode (overrides [primary] when set)
  final Color? primaryLight;

  /// Primary color for dark mode (overrides [primary] when set)
  final Color? primaryDark;

  /// Secondary brand color
  final Color? secondary;

  /// Secondary color for light mode (overrides [secondary] when set)
  final Color? secondaryLight;

  /// Secondary color for dark mode (overrides [secondary] when set)
  final Color? secondaryDark;

  /// Error color (used for validation, alerts)
  final Color? error;

  /// Error color for light mode (overrides [error] when set)
  final Color? errorLight;

  /// Error color for dark mode (overrides [error] when set)
  final Color? errorDark;

  /// Success/green color
  final Color? success;

  /// Success color for light mode (overrides [success] when set)
  final Color? successLight;

  /// Success color for dark mode (overrides [success] when set)
  final Color? successDark;

  // Light theme colors
  final Color? backgroundLight;
  final Color? surfaceLight;
  final Color? borderLight;
  final Color? textPrimaryLight;
  final Color? textMutedLight;

  // Dark theme colors
  final Color? backgroundDark;
  final Color? surfaceDark;
  final Color? borderDark;
  final Color? textPrimaryDark;
  final Color? textMutedDark;

  // Additional brand colors
  final Color? lightRed;
  final Color? purple;
  final Color? grey;
  final Color? darkGrey;

  // --- Scaffold ---
  final Color? scaffoldBackgroundLight;
  final Color? scaffoldBackgroundDark;

  // --- AppBar ---
  final Color? appBarBackgroundLight;
  final Color? appBarBackgroundDark;
  final Color? appBarForegroundLight;
  final Color? appBarForegroundDark;
  final double? appBarElevation;
  final bool? appBarCenterTitle;
  final TextStyle? appBarTitleTextStyle;
  final IconThemeData? appBarIconTheme;

  // --- BottomNavigationBar ---
  final Color? bottomNavBackgroundLight;
  final Color? bottomNavBackgroundDark;
  final Color? bottomNavSelectedColor;
  final Color? bottomNavUnselectedColor;
  final double? bottomNavElevation;
  final BottomNavigationBarType? bottomNavType;

  // --- NavigationBar (M3) ---
  final Color? navigationBarBackgroundLight;
  final Color? navigationBarBackgroundDark;
  final Color? navigationBarIndicatorColor;
  final double? navigationBarHeight;

  // --- NavigationRail ---
  final Color? navigationRailBackgroundLight;
  final Color? navigationRailBackgroundDark;
  final Color? navigationRailSelectedColor;
  final Color? navigationRailUnselectedColor;

  // --- Drawer ---
  final Color? drawerBackgroundLight;
  final Color? drawerBackgroundDark;
  final double? drawerWidth;
  final double? drawerElevation;

  // --- FloatingActionButton ---
  final Color? fabBackgroundLight;
  final Color? fabBackgroundDark;
  final Color? fabForegroundLight;
  final Color? fabForegroundDark;
  final double? fabElevation;
  final ShapeBorder? fabShape;

  // --- Buttons ---
  final ButtonStyle? elevatedButtonStyle;

  /// Elevated button background color
  final Color? elevatedButtonBackgroundColor;

  /// Elevated button background color for light mode
  final Color? elevatedButtonBackgroundColorLight;

  /// Elevated button background color for dark mode
  final Color? elevatedButtonBackgroundColorDark;

  /// Elevated button foreground (text/icon) color
  final Color? elevatedButtonForegroundColor;

  /// Elevated button foreground color for light mode
  final Color? elevatedButtonForegroundColorLight;

  /// Elevated button foreground color for dark mode
  final Color? elevatedButtonForegroundColorDark;

  final ButtonStyle? outlinedButtonStyle;

  /// Outlined button text color
  final Color? outlinedButtonTextColor;

  /// Outlined button text color for light mode
  final Color? outlinedButtonTextColorLight;

  /// Outlined button text color for dark mode
  final Color? outlinedButtonTextColorDark;

  /// Outlined button border color
  final Color? outlinedButtonBorderColor;

  /// Outlined button border color for light mode
  final Color? outlinedButtonBorderColorLight;

  /// Outlined button border color for dark mode
  final Color? outlinedButtonBorderColorDark;

  final ButtonStyle? textButtonStyle;

  /// Text button text color
  final Color? textButtonTextColor;

  /// Text button text color for light mode
  final Color? textButtonTextColorLight;

  /// Text button text color for dark mode
  final Color? textButtonTextColorDark;

  final ButtonStyle? filledButtonStyle;

  /// Filled button background color
  final Color? filledButtonBackgroundColor;

  /// Filled button background color for light mode
  final Color? filledButtonBackgroundColorLight;

  /// Filled button background color for dark mode
  final Color? filledButtonBackgroundColorDark;

  /// Filled button foreground (text/icon) color
  final Color? filledButtonForegroundColor;

  /// Filled button foreground color for light mode
  final Color? filledButtonForegroundColorLight;

  /// Filled button foreground color for dark mode
  final Color? filledButtonForegroundColorDark;

  final ButtonStyle? iconButtonStyle;

  // --- Cards ---
  final Color? cardColorLight;
  final Color? cardColorDark;
  final double? cardElevation;
  final ShapeBorder? cardShape;
  final EdgeInsetsGeometry? cardMargin;

  // --- Dialog ---
  final Color? dialogBackgroundLight;
  final Color? dialogBackgroundDark;
  final double? dialogElevation;
  final ShapeBorder? dialogShape;
  final TextStyle? dialogTitleStyle;
  final TextStyle? dialogContentStyle;

  // --- BottomSheet ---
  final Color? bottomSheetBackgroundLight;
  final Color? bottomSheetBackgroundDark;
  final double? bottomSheetElevation;
  final ShapeBorder? bottomSheetShape;
  final Color? bottomSheetDragHandleColor;

  // --- Snackbar ---
  final Color? snackBarBackgroundLight;
  final Color? snackBarBackgroundDark;
  final Color? snackBarActionColor;
  final SnackBarBehavior? snackBarBehavior;

  // --- Input/TextField ---
  final Color? inputFillColorLight;
  final Color? inputFillColorDark;
  final Color? inputBorderColor;
  final Color? inputBorderColorLight;
  final Color? inputBorderColorDark;
  final Color? inputFocusedBorderColor;
  final Color? inputFocusedBorderColorLight;
  final Color? inputFocusedBorderColorDark;
  final Color? inputErrorBorderColor;
  final Color? inputErrorBorderColorLight;
  final Color? inputErrorBorderColorDark;
  final TextStyle? inputLabelStyle;
  final TextStyle? inputHintStyle;
  final double? inputBorderRadius;
  final double? inputHeight;
  final double? buttonHeight;

  // --- Checkbox/Radio/Switch ---
  final Color? checkboxFillColor;
  final Color? checkboxFillColorLight;
  final Color? checkboxFillColorDark;
  final Color? radioFillColor;
  final Color? radioFillColorLight;
  final Color? radioFillColorDark;
  final Color? switchActiveColor;
  final Color? switchActiveColorLight;
  final Color? switchActiveColorDark;
  final Color? switchInactiveColor;
  final Color? switchInactiveColorLight;
  final Color? switchInactiveColorDark;
  final Color? switchTrackColor;
  final Color? switchTrackColorLight;
  final Color? switchTrackColorDark;

  // --- Slider ---
  final Color? sliderActiveColor;
  final Color? sliderActiveColorLight;
  final Color? sliderActiveColorDark;
  final Color? sliderInactiveColor;
  final Color? sliderInactiveColorLight;
  final Color? sliderInactiveColorDark;
  final Color? sliderThumbColor;
  final Color? sliderThumbColorLight;
  final Color? sliderThumbColorDark;

  // --- ProgressIndicator ---
  final Color? progressIndicatorColor;
  final Color? progressIndicatorColorLight;
  final Color? progressIndicatorColorDark;
  final Color? progressIndicatorBackgroundColor;
  final Color? progressIndicatorBackgroundColorLight;
  final Color? progressIndicatorBackgroundColorDark;
  final double? circularProgressStrokeWidth;

  // --- Tooltip ---
  final Color? tooltipBackgroundColor;
  final TextStyle? tooltipTextStyle;
  final EdgeInsetsGeometry? tooltipPadding;

  // --- Divider ---
  final Color? dividerColor;
  final Color? dividerColorLight;
  final Color? dividerColorDark;
  final double? dividerThickness;
  final double? dividerIndent;

  // --- ListTile ---
  final Color? listTileIconColor;
  final Color? listTileIconColorLight;
  final Color? listTileIconColorDark;
  final TextStyle? listTileTitleStyle;
  final TextStyle? listTileSubtitleStyle;
  final Color? listTileSelectedColor;
  final Color? listTileSelectedColorLight;
  final Color? listTileSelectedColorDark;

  // --- TabBar ---
  final Color? tabBarIndicatorColor;
  final Color? tabBarIndicatorColorLight;
  final Color? tabBarIndicatorColorDark;
  final Color? tabBarLabelColor;
  final Color? tabBarLabelColorLight;
  final Color? tabBarLabelColorDark;
  final Color? tabBarUnselectedLabelColor;
  final Color? tabBarUnselectedLabelColorLight;
  final Color? tabBarUnselectedLabelColorDark;
  final double? tabBarIndicatorWeight;

  // --- DataTable ---
  final Color? dataTableHeadingRowColor;
  final Color? dataTableHeadingRowColorLight;
  final Color? dataTableHeadingRowColorDark;
  final Color? dataTableDataRowColor;
  final Color? dataTableDataRowColorLight;
  final Color? dataTableDataRowColorDark;
  final double? dataTableDividerThickness;

  // --- Chip ---
  final Color? chipBackgroundLight;
  final Color? chipBackgroundDark;
  final TextStyle? chipLabelStyle;
  final Color? chipDeleteIconColor;
  final Color? chipSelectedColor;

  // --- Badge ---
  final Color? badgeBackgroundColor;
  final Color? badgeBackgroundColorLight;
  final Color? badgeBackgroundColorDark;
  final Color? badgeTextColor;
  final Color? badgeTextColorLight;
  final Color? badgeTextColorDark;

  // --- SearchBar ---
  final Color? searchBarBackgroundLight;
  final Color? searchBarBackgroundDark;
  final double? searchBarElevation;
  final TextStyle? searchBarHintStyle;

  // --- SegmentedButton ---
  final Color? segmentedButtonSelectedColor;
  final Color? segmentedButtonSelectedColorLight;
  final Color? segmentedButtonSelectedColorDark;
  final Color? segmentedButtonForegroundColor;
  final Color? segmentedButtonForegroundColorLight;
  final Color? segmentedButtonForegroundColorDark;

  // --- PopupMenu ---
  final Color? popupMenuBackgroundLight;
  final Color? popupMenuBackgroundDark;
  final double? popupMenuElevation;
  final ShapeBorder? popupMenuShape;

  // --- ExpansionTile ---
  final Color? expansionTileBackgroundColor;
  final Color? expansionTileBackgroundColorLight;
  final Color? expansionTileBackgroundColorDark;
  final Color? expansionTileCollapsedBackgroundColor;
  final Color? expansionTileCollapsedBackgroundColorLight;
  final Color? expansionTileCollapsedBackgroundColorDark;
  final Color? expansionTileIconColor;
  final Color? expansionTileIconColorLight;
  final Color? expansionTileIconColorDark;

  // --- Typography ---
  final String? fontFamily;
  final TextStyle? displayLarge;
  final TextStyle? displayMedium;
  final TextStyle? displaySmall;
  final TextStyle? headlineLarge;
  final TextStyle? headlineMedium;
  final TextStyle? headlineSmall;
  final TextStyle? titleLarge;
  final TextStyle? titleMedium;
  final TextStyle? titleSmall;
  final TextStyle? bodyLarge;
  final TextStyle? bodyMedium;
  final TextStyle? bodySmall;
  final TextStyle? labelLarge;
  final TextStyle? labelMedium;
  final TextStyle? labelSmall;

  // --- Misc ---
  final Color? splashColor;
  final Color? highlightColor;
  final Color? highlightColorLight;
  final Color? highlightColorDark;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? disabledColor;
  final Color? shadowColor;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? materialTapTargetSize;

  const SACThemeConfig({
    this.primary,
    this.primaryLight,
    this.primaryDark,
    this.secondary,
    this.secondaryLight,
    this.secondaryDark,
    this.error,
    this.errorLight,
    this.errorDark,
    this.success,
    this.successLight,
    this.successDark,
    this.backgroundLight,
    this.surfaceLight,
    this.borderLight,
    this.textPrimaryLight,
    this.textMutedLight,
    this.backgroundDark,
    this.surfaceDark,
    this.borderDark,
    this.textPrimaryDark,
    this.textMutedDark,
    this.lightRed,
    this.purple,
    this.grey,
    this.darkGrey,
    this.scaffoldBackgroundLight,
    this.scaffoldBackgroundDark,
    this.appBarBackgroundLight,
    this.appBarBackgroundDark,
    this.appBarForegroundLight,
    this.appBarForegroundDark,
    this.appBarElevation,
    this.appBarCenterTitle,
    this.appBarTitleTextStyle,
    this.appBarIconTheme,
    this.bottomNavBackgroundLight,
    this.bottomNavBackgroundDark,
    this.bottomNavSelectedColor,
    this.bottomNavUnselectedColor,
    this.bottomNavElevation,
    this.bottomNavType,
    this.navigationBarBackgroundLight,
    this.navigationBarBackgroundDark,
    this.navigationBarIndicatorColor,
    this.navigationBarHeight,
    this.navigationRailBackgroundLight,
    this.navigationRailBackgroundDark,
    this.navigationRailSelectedColor,
    this.navigationRailUnselectedColor,
    this.drawerBackgroundLight,
    this.drawerBackgroundDark,
    this.drawerWidth,
    this.drawerElevation,
    this.fabBackgroundLight,
    this.fabBackgroundDark,
    this.fabForegroundLight,
    this.fabForegroundDark,
    this.fabElevation,
    this.fabShape,
    this.elevatedButtonStyle,
    this.elevatedButtonBackgroundColor,
    this.elevatedButtonBackgroundColorLight,
    this.elevatedButtonBackgroundColorDark,
    this.elevatedButtonForegroundColor,
    this.elevatedButtonForegroundColorLight,
    this.elevatedButtonForegroundColorDark,
    this.outlinedButtonStyle,
    this.outlinedButtonTextColor,
    this.outlinedButtonTextColorLight,
    this.outlinedButtonTextColorDark,
    this.outlinedButtonBorderColor,
    this.outlinedButtonBorderColorLight,
    this.outlinedButtonBorderColorDark,
    this.textButtonStyle,
    this.textButtonTextColor,
    this.textButtonTextColorLight,
    this.textButtonTextColorDark,
    this.filledButtonStyle,
    this.filledButtonBackgroundColor,
    this.filledButtonBackgroundColorLight,
    this.filledButtonBackgroundColorDark,
    this.filledButtonForegroundColor,
    this.filledButtonForegroundColorLight,
    this.filledButtonForegroundColorDark,
    this.iconButtonStyle,
    this.cardColorLight,
    this.cardColorDark,
    this.cardElevation,
    this.cardShape,
    this.cardMargin,
    this.dialogBackgroundLight,
    this.dialogBackgroundDark,
    this.dialogElevation,
    this.dialogShape,
    this.dialogTitleStyle,
    this.dialogContentStyle,
    this.bottomSheetBackgroundLight,
    this.bottomSheetBackgroundDark,
    this.bottomSheetElevation,
    this.bottomSheetShape,
    this.bottomSheetDragHandleColor,
    this.snackBarBackgroundLight,
    this.snackBarBackgroundDark,
    this.snackBarActionColor,
    this.snackBarBehavior,
    this.inputFillColorLight,
    this.inputFillColorDark,
    this.inputBorderColor,
    this.inputBorderColorLight,
    this.inputBorderColorDark,
    this.inputFocusedBorderColor,
    this.inputFocusedBorderColorLight,
    this.inputFocusedBorderColorDark,
    this.inputErrorBorderColor,
    this.inputErrorBorderColorLight,
    this.inputErrorBorderColorDark,
    this.inputLabelStyle,
    this.inputHintStyle,
    this.inputBorderRadius,
    this.inputHeight,
    this.buttonHeight,
    this.checkboxFillColor,
    this.checkboxFillColorLight,
    this.checkboxFillColorDark,
    this.radioFillColor,
    this.radioFillColorLight,
    this.radioFillColorDark,
    this.switchActiveColor,
    this.switchActiveColorLight,
    this.switchActiveColorDark,
    this.switchInactiveColor,
    this.switchInactiveColorLight,
    this.switchInactiveColorDark,
    this.switchTrackColor,
    this.switchTrackColorLight,
    this.switchTrackColorDark,
    this.sliderActiveColor,
    this.sliderActiveColorLight,
    this.sliderActiveColorDark,
    this.sliderInactiveColor,
    this.sliderInactiveColorLight,
    this.sliderInactiveColorDark,
    this.sliderThumbColor,
    this.sliderThumbColorLight,
    this.sliderThumbColorDark,
    this.progressIndicatorColor,
    this.progressIndicatorColorLight,
    this.progressIndicatorColorDark,
    this.progressIndicatorBackgroundColor,
    this.progressIndicatorBackgroundColorLight,
    this.progressIndicatorBackgroundColorDark,
    this.circularProgressStrokeWidth,
    this.tooltipBackgroundColor,
    this.tooltipTextStyle,
    this.tooltipPadding,
    this.dividerColor,
    this.dividerColorLight,
    this.dividerColorDark,
    this.dividerThickness,
    this.dividerIndent,
    this.listTileIconColor,
    this.listTileIconColorLight,
    this.listTileIconColorDark,
    this.listTileTitleStyle,
    this.listTileSubtitleStyle,
    this.listTileSelectedColor,
    this.listTileSelectedColorLight,
    this.listTileSelectedColorDark,
    this.tabBarIndicatorColor,
    this.tabBarIndicatorColorLight,
    this.tabBarIndicatorColorDark,
    this.tabBarLabelColor,
    this.tabBarLabelColorLight,
    this.tabBarLabelColorDark,
    this.tabBarUnselectedLabelColor,
    this.tabBarUnselectedLabelColorLight,
    this.tabBarUnselectedLabelColorDark,
    this.tabBarIndicatorWeight,
    this.dataTableHeadingRowColor,
    this.dataTableHeadingRowColorLight,
    this.dataTableHeadingRowColorDark,
    this.dataTableDataRowColor,
    this.dataTableDataRowColorLight,
    this.dataTableDataRowColorDark,
    this.dataTableDividerThickness,
    this.chipBackgroundLight,
    this.chipBackgroundDark,
    this.chipLabelStyle,
    this.chipDeleteIconColor,
    this.chipSelectedColor,
    this.badgeBackgroundColor,
    this.badgeBackgroundColorLight,
    this.badgeBackgroundColorDark,
    this.badgeTextColor,
    this.badgeTextColorLight,
    this.badgeTextColorDark,
    this.searchBarBackgroundLight,
    this.searchBarBackgroundDark,
    this.searchBarElevation,
    this.searchBarHintStyle,
    this.segmentedButtonSelectedColor,
    this.segmentedButtonSelectedColorLight,
    this.segmentedButtonSelectedColorDark,
    this.segmentedButtonForegroundColor,
    this.segmentedButtonForegroundColorLight,
    this.segmentedButtonForegroundColorDark,
    this.popupMenuBackgroundLight,
    this.popupMenuBackgroundDark,
    this.popupMenuElevation,
    this.popupMenuShape,
    this.expansionTileBackgroundColor,
    this.expansionTileBackgroundColorLight,
    this.expansionTileBackgroundColorDark,
    this.expansionTileCollapsedBackgroundColor,
    this.expansionTileCollapsedBackgroundColorLight,
    this.expansionTileCollapsedBackgroundColorDark,
    this.expansionTileIconColor,
    this.expansionTileIconColorLight,
    this.expansionTileIconColorDark,
    this.fontFamily,
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineLarge,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
    this.splashColor,
    this.highlightColor,
    this.highlightColorLight,
    this.highlightColorDark,
    this.hoverColor,
    this.focusColor,
    this.disabledColor,
    this.shadowColor,
    this.visualDensity,
    this.materialTapTargetSize,
  });

  /// Returns a new config overriding selected fields.
  SACThemeConfig copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryDark,
    Color? secondary,
    Color? secondaryLight,
    Color? secondaryDark,
    Color? error,
    Color? errorLight,
    Color? errorDark,
    Color? success,
    Color? successLight,
    Color? successDark,
    Color? backgroundLight,
    Color? surfaceLight,
    Color? borderLight,
    Color? textPrimaryLight,
    Color? textMutedLight,
    Color? backgroundDark,
    Color? surfaceDark,
    Color? borderDark,
    Color? textPrimaryDark,
    Color? textMutedDark,
    Color? lightRed,
    Color? purple,
    Color? grey,
    Color? darkGrey,
    Color? scaffoldBackgroundLight,
    Color? scaffoldBackgroundDark,
    Color? appBarBackgroundLight,
    Color? appBarBackgroundDark,
    Color? appBarForegroundLight,
    Color? appBarForegroundDark,
    double? appBarElevation,
    bool? appBarCenterTitle,
    TextStyle? appBarTitleTextStyle,
    IconThemeData? appBarIconTheme,
    Color? bottomNavBackgroundLight,
    Color? bottomNavBackgroundDark,
    Color? bottomNavSelectedColor,
    Color? bottomNavUnselectedColor,
    double? bottomNavElevation,
    BottomNavigationBarType? bottomNavType,
    Color? navigationBarBackgroundLight,
    Color? navigationBarBackgroundDark,
    Color? navigationBarIndicatorColor,
    double? navigationBarHeight,
    Color? navigationRailBackgroundLight,
    Color? navigationRailBackgroundDark,
    Color? navigationRailSelectedColor,
    Color? navigationRailUnselectedColor,
    Color? drawerBackgroundLight,
    Color? drawerBackgroundDark,
    double? drawerWidth,
    double? drawerElevation,
    Color? fabBackgroundLight,
    Color? fabBackgroundDark,
    Color? fabForegroundLight,
    Color? fabForegroundDark,
    double? fabElevation,
    ShapeBorder? fabShape,
    ButtonStyle? elevatedButtonStyle,
    Color? elevatedButtonBackgroundColor,
    Color? elevatedButtonBackgroundColorLight,
    Color? elevatedButtonBackgroundColorDark,
    Color? elevatedButtonForegroundColor,
    Color? elevatedButtonForegroundColorLight,
    Color? elevatedButtonForegroundColorDark,
    ButtonStyle? outlinedButtonStyle,
    Color? outlinedButtonTextColor,
    Color? outlinedButtonTextColorLight,
    Color? outlinedButtonTextColorDark,
    Color? outlinedButtonBorderColor,
    Color? outlinedButtonBorderColorLight,
    Color? outlinedButtonBorderColorDark,
    ButtonStyle? textButtonStyle,
    Color? textButtonTextColor,
    Color? textButtonTextColorLight,
    Color? textButtonTextColorDark,
    ButtonStyle? filledButtonStyle,
    Color? filledButtonBackgroundColor,
    Color? filledButtonBackgroundColorLight,
    Color? filledButtonBackgroundColorDark,
    Color? filledButtonForegroundColor,
    Color? filledButtonForegroundColorLight,
    Color? filledButtonForegroundColorDark,
    ButtonStyle? iconButtonStyle,
    Color? cardColorLight,
    Color? cardColorDark,
    double? cardElevation,
    ShapeBorder? cardShape,
    EdgeInsetsGeometry? cardMargin,
    Color? dialogBackgroundLight,
    Color? dialogBackgroundDark,
    double? dialogElevation,
    ShapeBorder? dialogShape,
    TextStyle? dialogTitleStyle,
    TextStyle? dialogContentStyle,
    Color? bottomSheetBackgroundLight,
    Color? bottomSheetBackgroundDark,
    double? bottomSheetElevation,
    ShapeBorder? bottomSheetShape,
    Color? bottomSheetDragHandleColor,
    Color? snackBarBackgroundLight,
    Color? snackBarBackgroundDark,
    Color? snackBarActionColor,
    SnackBarBehavior? snackBarBehavior,
    Color? inputFillColorLight,
    Color? inputFillColorDark,
    Color? inputBorderColor,
    Color? inputBorderColorLight,
    Color? inputBorderColorDark,
    Color? inputFocusedBorderColor,
    Color? inputFocusedBorderColorLight,
    Color? inputFocusedBorderColorDark,
    Color? inputErrorBorderColor,
    Color? inputErrorBorderColorLight,
    Color? inputErrorBorderColorDark,
    TextStyle? inputLabelStyle,
    TextStyle? inputHintStyle,
    double? inputBorderRadius,
    double? inputHeight,
    double? buttonHeight,
    Color? checkboxFillColor,
    Color? checkboxFillColorLight,
    Color? checkboxFillColorDark,
    Color? radioFillColor,
    Color? radioFillColorLight,
    Color? radioFillColorDark,
    Color? switchActiveColor,
    Color? switchActiveColorLight,
    Color? switchActiveColorDark,
    Color? switchInactiveColor,
    Color? switchInactiveColorLight,
    Color? switchInactiveColorDark,
    Color? switchTrackColor,
    Color? switchTrackColorLight,
    Color? switchTrackColorDark,
    Color? sliderActiveColor,
    Color? sliderActiveColorLight,
    Color? sliderActiveColorDark,
    Color? sliderInactiveColor,
    Color? sliderInactiveColorLight,
    Color? sliderInactiveColorDark,
    Color? sliderThumbColor,
    Color? sliderThumbColorLight,
    Color? sliderThumbColorDark,
    Color? progressIndicatorColor,
    Color? progressIndicatorColorLight,
    Color? progressIndicatorColorDark,
    Color? progressIndicatorBackgroundColor,
    Color? progressIndicatorBackgroundColorLight,
    Color? progressIndicatorBackgroundColorDark,
    double? circularProgressStrokeWidth,
    Color? tooltipBackgroundColor,
    TextStyle? tooltipTextStyle,
    EdgeInsetsGeometry? tooltipPadding,
    Color? dividerColor,
    Color? dividerColorLight,
    Color? dividerColorDark,
    double? dividerThickness,
    double? dividerIndent,
    Color? listTileIconColor,
    Color? listTileIconColorLight,
    Color? listTileIconColorDark,
    TextStyle? listTileTitleStyle,
    TextStyle? listTileSubtitleStyle,
    Color? listTileSelectedColor,
    Color? listTileSelectedColorLight,
    Color? listTileSelectedColorDark,
    Color? tabBarIndicatorColor,
    Color? tabBarIndicatorColorLight,
    Color? tabBarIndicatorColorDark,
    Color? tabBarLabelColor,
    Color? tabBarLabelColorLight,
    Color? tabBarLabelColorDark,
    Color? tabBarUnselectedLabelColor,
    Color? tabBarUnselectedLabelColorLight,
    Color? tabBarUnselectedLabelColorDark,
    double? tabBarIndicatorWeight,
    Color? dataTableHeadingRowColor,
    Color? dataTableHeadingRowColorLight,
    Color? dataTableHeadingRowColorDark,
    Color? dataTableDataRowColor,
    Color? dataTableDataRowColorLight,
    Color? dataTableDataRowColorDark,
    double? dataTableDividerThickness,
    Color? chipBackgroundLight,
    Color? chipBackgroundDark,
    TextStyle? chipLabelStyle,
    Color? chipDeleteIconColor,
    Color? chipSelectedColor,
    Color? badgeBackgroundColor,
    Color? badgeBackgroundColorLight,
    Color? badgeBackgroundColorDark,
    Color? badgeTextColor,
    Color? badgeTextColorLight,
    Color? badgeTextColorDark,
    Color? searchBarBackgroundLight,
    Color? searchBarBackgroundDark,
    double? searchBarElevation,
    TextStyle? searchBarHintStyle,
    Color? segmentedButtonSelectedColor,
    Color? segmentedButtonSelectedColorLight,
    Color? segmentedButtonSelectedColorDark,
    Color? segmentedButtonForegroundColor,
    Color? segmentedButtonForegroundColorLight,
    Color? segmentedButtonForegroundColorDark,
    Color? popupMenuBackgroundLight,
    Color? popupMenuBackgroundDark,
    double? popupMenuElevation,
    ShapeBorder? popupMenuShape,
    Color? expansionTileBackgroundColor,
    Color? expansionTileBackgroundColorLight,
    Color? expansionTileBackgroundColorDark,
    Color? expansionTileCollapsedBackgroundColor,
    Color? expansionTileCollapsedBackgroundColorLight,
    Color? expansionTileCollapsedBackgroundColorDark,
    Color? expansionTileIconColor,
    Color? expansionTileIconColorLight,
    Color? expansionTileIconColorDark,
    String? fontFamily,
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    Color? splashColor,
    Color? highlightColor,
    Color? highlightColorLight,
    Color? highlightColorDark,
    Color? hoverColor,
    Color? focusColor,
    Color? disabledColor,
    Color? shadowColor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? materialTapTargetSize,
  }) {
    return SACThemeConfig(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      secondary: secondary ?? this.secondary,
      secondaryLight: secondaryLight ?? this.secondaryLight,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      error: error ?? this.error,
      errorLight: errorLight ?? this.errorLight,
      errorDark: errorDark ?? this.errorDark,
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      successDark: successDark ?? this.successDark,
      backgroundLight: backgroundLight ?? this.backgroundLight,
      surfaceLight: surfaceLight ?? this.surfaceLight,
      borderLight: borderLight ?? this.borderLight,
      textPrimaryLight: textPrimaryLight ?? this.textPrimaryLight,
      textMutedLight: textMutedLight ?? this.textMutedLight,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      surfaceDark: surfaceDark ?? this.surfaceDark,
      borderDark: borderDark ?? this.borderDark,
      textPrimaryDark: textPrimaryDark ?? this.textPrimaryDark,
      textMutedDark: textMutedDark ?? this.textMutedDark,
      lightRed: lightRed ?? this.lightRed,
      purple: purple ?? this.purple,
      grey: grey ?? this.grey,
      darkGrey: darkGrey ?? this.darkGrey,
      scaffoldBackgroundLight:
          scaffoldBackgroundLight ?? this.scaffoldBackgroundLight,
      scaffoldBackgroundDark:
          scaffoldBackgroundDark ?? this.scaffoldBackgroundDark,
      appBarBackgroundLight:
          appBarBackgroundLight ?? this.appBarBackgroundLight,
      appBarBackgroundDark: appBarBackgroundDark ?? this.appBarBackgroundDark,
      appBarForegroundLight:
          appBarForegroundLight ?? this.appBarForegroundLight,
      appBarForegroundDark: appBarForegroundDark ?? this.appBarForegroundDark,
      appBarElevation: appBarElevation ?? this.appBarElevation,
      appBarCenterTitle: appBarCenterTitle ?? this.appBarCenterTitle,
      appBarTitleTextStyle: appBarTitleTextStyle ?? this.appBarTitleTextStyle,
      appBarIconTheme: appBarIconTheme ?? this.appBarIconTheme,
      bottomNavBackgroundLight:
          bottomNavBackgroundLight ?? this.bottomNavBackgroundLight,
      bottomNavBackgroundDark:
          bottomNavBackgroundDark ?? this.bottomNavBackgroundDark,
      bottomNavSelectedColor:
          bottomNavSelectedColor ?? this.bottomNavSelectedColor,
      bottomNavUnselectedColor:
          bottomNavUnselectedColor ?? this.bottomNavUnselectedColor,
      bottomNavElevation: bottomNavElevation ?? this.bottomNavElevation,
      bottomNavType: bottomNavType ?? this.bottomNavType,
      navigationBarBackgroundLight:
          navigationBarBackgroundLight ?? this.navigationBarBackgroundLight,
      navigationBarBackgroundDark:
          navigationBarBackgroundDark ?? this.navigationBarBackgroundDark,
      navigationBarIndicatorColor:
          navigationBarIndicatorColor ?? this.navigationBarIndicatorColor,
      navigationBarHeight: navigationBarHeight ?? this.navigationBarHeight,
      navigationRailBackgroundLight:
          navigationRailBackgroundLight ?? this.navigationRailBackgroundLight,
      navigationRailBackgroundDark:
          navigationRailBackgroundDark ?? this.navigationRailBackgroundDark,
      navigationRailSelectedColor:
          navigationRailSelectedColor ?? this.navigationRailSelectedColor,
      navigationRailUnselectedColor:
          navigationRailUnselectedColor ?? this.navigationRailUnselectedColor,
      drawerBackgroundLight:
          drawerBackgroundLight ?? this.drawerBackgroundLight,
      drawerBackgroundDark: drawerBackgroundDark ?? this.drawerBackgroundDark,
      drawerWidth: drawerWidth ?? this.drawerWidth,
      drawerElevation: drawerElevation ?? this.drawerElevation,
      fabBackgroundLight: fabBackgroundLight ?? this.fabBackgroundLight,
      fabBackgroundDark: fabBackgroundDark ?? this.fabBackgroundDark,
      fabForegroundLight: fabForegroundLight ?? this.fabForegroundLight,
      fabForegroundDark: fabForegroundDark ?? this.fabForegroundDark,
      fabElevation: fabElevation ?? this.fabElevation,
      fabShape: fabShape ?? this.fabShape,
      elevatedButtonStyle: elevatedButtonStyle ?? this.elevatedButtonStyle,
      elevatedButtonBackgroundColor:
          elevatedButtonBackgroundColor ?? this.elevatedButtonBackgroundColor,
      elevatedButtonBackgroundColorLight:
          elevatedButtonBackgroundColorLight ??
              this.elevatedButtonBackgroundColorLight,
      elevatedButtonBackgroundColorDark:
          elevatedButtonBackgroundColorDark ??
              this.elevatedButtonBackgroundColorDark,
      elevatedButtonForegroundColor:
          elevatedButtonForegroundColor ?? this.elevatedButtonForegroundColor,
      elevatedButtonForegroundColorLight:
          elevatedButtonForegroundColorLight ??
              this.elevatedButtonForegroundColorLight,
      elevatedButtonForegroundColorDark:
          elevatedButtonForegroundColorDark ??
              this.elevatedButtonForegroundColorDark,
      outlinedButtonStyle: outlinedButtonStyle ?? this.outlinedButtonStyle,
      outlinedButtonTextColor:
          outlinedButtonTextColor ?? this.outlinedButtonTextColor,
      outlinedButtonTextColorLight:
          outlinedButtonTextColorLight ?? this.outlinedButtonTextColorLight,
      outlinedButtonTextColorDark:
          outlinedButtonTextColorDark ?? this.outlinedButtonTextColorDark,
      outlinedButtonBorderColor:
          outlinedButtonBorderColor ?? this.outlinedButtonBorderColor,
      outlinedButtonBorderColorLight:
          outlinedButtonBorderColorLight ?? this.outlinedButtonBorderColorLight,
      outlinedButtonBorderColorDark:
          outlinedButtonBorderColorDark ?? this.outlinedButtonBorderColorDark,
      textButtonStyle: textButtonStyle ?? this.textButtonStyle,
      textButtonTextColor: textButtonTextColor ?? this.textButtonTextColor,
      textButtonTextColorLight:
          textButtonTextColorLight ?? this.textButtonTextColorLight,
      textButtonTextColorDark:
          textButtonTextColorDark ?? this.textButtonTextColorDark,
      filledButtonStyle: filledButtonStyle ?? this.filledButtonStyle,
      filledButtonBackgroundColor:
          filledButtonBackgroundColor ?? this.filledButtonBackgroundColor,
      filledButtonBackgroundColorLight:
          filledButtonBackgroundColorLight ??
              this.filledButtonBackgroundColorLight,
      filledButtonBackgroundColorDark:
          filledButtonBackgroundColorDark ??
              this.filledButtonBackgroundColorDark,
      filledButtonForegroundColor:
          filledButtonForegroundColor ?? this.filledButtonForegroundColor,
      filledButtonForegroundColorLight:
          filledButtonForegroundColorLight ??
              this.filledButtonForegroundColorLight,
      filledButtonForegroundColorDark:
          filledButtonForegroundColorDark ??
              this.filledButtonForegroundColorDark,
      iconButtonStyle: iconButtonStyle ?? this.iconButtonStyle,
      cardColorLight: cardColorLight ?? this.cardColorLight,
      cardColorDark: cardColorDark ?? this.cardColorDark,
      cardElevation: cardElevation ?? this.cardElevation,
      cardShape: cardShape ?? this.cardShape,
      cardMargin: cardMargin ?? this.cardMargin,
      dialogBackgroundLight:
          dialogBackgroundLight ?? this.dialogBackgroundLight,
      dialogBackgroundDark: dialogBackgroundDark ?? this.dialogBackgroundDark,
      dialogElevation: dialogElevation ?? this.dialogElevation,
      dialogShape: dialogShape ?? this.dialogShape,
      dialogTitleStyle: dialogTitleStyle ?? this.dialogTitleStyle,
      dialogContentStyle: dialogContentStyle ?? this.dialogContentStyle,
      bottomSheetBackgroundLight:
          bottomSheetBackgroundLight ?? this.bottomSheetBackgroundLight,
      bottomSheetBackgroundDark:
          bottomSheetBackgroundDark ?? this.bottomSheetBackgroundDark,
      bottomSheetElevation: bottomSheetElevation ?? this.bottomSheetElevation,
      bottomSheetShape: bottomSheetShape ?? this.bottomSheetShape,
      bottomSheetDragHandleColor:
          bottomSheetDragHandleColor ?? this.bottomSheetDragHandleColor,
      snackBarBackgroundLight:
          snackBarBackgroundLight ?? this.snackBarBackgroundLight,
      snackBarBackgroundDark:
          snackBarBackgroundDark ?? this.snackBarBackgroundDark,
      snackBarActionColor: snackBarActionColor ?? this.snackBarActionColor,
      snackBarBehavior: snackBarBehavior ?? this.snackBarBehavior,
      inputFillColorLight: inputFillColorLight ?? this.inputFillColorLight,
      inputFillColorDark: inputFillColorDark ?? this.inputFillColorDark,
      inputBorderColor: inputBorderColor ?? this.inputBorderColor,
      inputBorderColorLight:
          inputBorderColorLight ?? this.inputBorderColorLight,
      inputBorderColorDark: inputBorderColorDark ?? this.inputBorderColorDark,
      inputFocusedBorderColor:
          inputFocusedBorderColor ?? this.inputFocusedBorderColor,
      inputFocusedBorderColorLight:
          inputFocusedBorderColorLight ?? this.inputFocusedBorderColorLight,
      inputFocusedBorderColorDark:
          inputFocusedBorderColorDark ?? this.inputFocusedBorderColorDark,
      inputErrorBorderColor:
          inputErrorBorderColor ?? this.inputErrorBorderColor,
      inputErrorBorderColorLight:
          inputErrorBorderColorLight ?? this.inputErrorBorderColorLight,
      inputErrorBorderColorDark:
          inputErrorBorderColorDark ?? this.inputErrorBorderColorDark,
      inputLabelStyle: inputLabelStyle ?? this.inputLabelStyle,
      inputHintStyle: inputHintStyle ?? this.inputHintStyle,
      inputBorderRadius: inputBorderRadius ?? this.inputBorderRadius,
      inputHeight: inputHeight ?? this.inputHeight,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      checkboxFillColor: checkboxFillColor ?? this.checkboxFillColor,
      checkboxFillColorLight:
          checkboxFillColorLight ?? this.checkboxFillColorLight,
      checkboxFillColorDark:
          checkboxFillColorDark ?? this.checkboxFillColorDark,
      radioFillColor: radioFillColor ?? this.radioFillColor,
      radioFillColorLight: radioFillColorLight ?? this.radioFillColorLight,
      radioFillColorDark: radioFillColorDark ?? this.radioFillColorDark,
      switchActiveColor: switchActiveColor ?? this.switchActiveColor,
      switchActiveColorLight:
          switchActiveColorLight ?? this.switchActiveColorLight,
      switchActiveColorDark:
          switchActiveColorDark ?? this.switchActiveColorDark,
      switchInactiveColor: switchInactiveColor ?? this.switchInactiveColor,
      switchInactiveColorLight:
          switchInactiveColorLight ?? this.switchInactiveColorLight,
      switchInactiveColorDark:
          switchInactiveColorDark ?? this.switchInactiveColorDark,
      switchTrackColor: switchTrackColor ?? this.switchTrackColor,
      switchTrackColorLight:
          switchTrackColorLight ?? this.switchTrackColorLight,
      switchTrackColorDark: switchTrackColorDark ?? this.switchTrackColorDark,
      sliderActiveColor: sliderActiveColor ?? this.sliderActiveColor,
      sliderActiveColorLight:
          sliderActiveColorLight ?? this.sliderActiveColorLight,
      sliderActiveColorDark:
          sliderActiveColorDark ?? this.sliderActiveColorDark,
      sliderInactiveColor: sliderInactiveColor ?? this.sliderInactiveColor,
      sliderInactiveColorLight:
          sliderInactiveColorLight ?? this.sliderInactiveColorLight,
      sliderInactiveColorDark:
          sliderInactiveColorDark ?? this.sliderInactiveColorDark,
      sliderThumbColor: sliderThumbColor ?? this.sliderThumbColor,
      sliderThumbColorLight:
          sliderThumbColorLight ?? this.sliderThumbColorLight,
      sliderThumbColorDark: sliderThumbColorDark ?? this.sliderThumbColorDark,
      progressIndicatorColor:
          progressIndicatorColor ?? this.progressIndicatorColor,
      progressIndicatorColorLight:
          progressIndicatorColorLight ?? this.progressIndicatorColorLight,
      progressIndicatorColorDark:
          progressIndicatorColorDark ?? this.progressIndicatorColorDark,
      progressIndicatorBackgroundColor:
          progressIndicatorBackgroundColor ??
          this.progressIndicatorBackgroundColor,
      progressIndicatorBackgroundColorLight:
          progressIndicatorBackgroundColorLight ??
          this.progressIndicatorBackgroundColorLight,
      progressIndicatorBackgroundColorDark:
          progressIndicatorBackgroundColorDark ??
          this.progressIndicatorBackgroundColorDark,
      circularProgressStrokeWidth:
          circularProgressStrokeWidth ?? this.circularProgressStrokeWidth,
      tooltipBackgroundColor:
          tooltipBackgroundColor ?? this.tooltipBackgroundColor,
      tooltipTextStyle: tooltipTextStyle ?? this.tooltipTextStyle,
      tooltipPadding: tooltipPadding ?? this.tooltipPadding,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerColorLight: dividerColorLight ?? this.dividerColorLight,
      dividerColorDark: dividerColorDark ?? this.dividerColorDark,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerIndent: dividerIndent ?? this.dividerIndent,
      listTileIconColor: listTileIconColor ?? this.listTileIconColor,
      listTileIconColorLight:
          listTileIconColorLight ?? this.listTileIconColorLight,
      listTileIconColorDark:
          listTileIconColorDark ?? this.listTileIconColorDark,
      listTileTitleStyle: listTileTitleStyle ?? this.listTileTitleStyle,
      listTileSubtitleStyle:
          listTileSubtitleStyle ?? this.listTileSubtitleStyle,
      listTileSelectedColor:
          listTileSelectedColor ?? this.listTileSelectedColor,
      listTileSelectedColorLight:
          listTileSelectedColorLight ?? this.listTileSelectedColorLight,
      listTileSelectedColorDark:
          listTileSelectedColorDark ?? this.listTileSelectedColorDark,
      tabBarIndicatorColor: tabBarIndicatorColor ?? this.tabBarIndicatorColor,
      tabBarIndicatorColorLight:
          tabBarIndicatorColorLight ?? this.tabBarIndicatorColorLight,
      tabBarIndicatorColorDark:
          tabBarIndicatorColorDark ?? this.tabBarIndicatorColorDark,
      tabBarLabelColor: tabBarLabelColor ?? this.tabBarLabelColor,
      tabBarLabelColorLight:
          tabBarLabelColorLight ?? this.tabBarLabelColorLight,
      tabBarLabelColorDark: tabBarLabelColorDark ?? this.tabBarLabelColorDark,
      tabBarUnselectedLabelColor:
          tabBarUnselectedLabelColor ?? this.tabBarUnselectedLabelColor,
      tabBarUnselectedLabelColorLight:
          tabBarUnselectedLabelColorLight ??
          this.tabBarUnselectedLabelColorLight,
      tabBarUnselectedLabelColorDark:
          tabBarUnselectedLabelColorDark ?? this.tabBarUnselectedLabelColorDark,
      tabBarIndicatorWeight:
          tabBarIndicatorWeight ?? this.tabBarIndicatorWeight,
      dataTableHeadingRowColor:
          dataTableHeadingRowColor ?? this.dataTableHeadingRowColor,
      dataTableHeadingRowColorLight:
          dataTableHeadingRowColorLight ?? this.dataTableHeadingRowColorLight,
      dataTableHeadingRowColorDark:
          dataTableHeadingRowColorDark ?? this.dataTableHeadingRowColorDark,
      dataTableDataRowColor:
          dataTableDataRowColor ?? this.dataTableDataRowColor,
      dataTableDataRowColorLight:
          dataTableDataRowColorLight ?? this.dataTableDataRowColorLight,
      dataTableDataRowColorDark:
          dataTableDataRowColorDark ?? this.dataTableDataRowColorDark,
      dataTableDividerThickness:
          dataTableDividerThickness ?? this.dataTableDividerThickness,
      chipBackgroundLight: chipBackgroundLight ?? this.chipBackgroundLight,
      chipBackgroundDark: chipBackgroundDark ?? this.chipBackgroundDark,
      chipLabelStyle: chipLabelStyle ?? this.chipLabelStyle,
      chipDeleteIconColor: chipDeleteIconColor ?? this.chipDeleteIconColor,
      chipSelectedColor: chipSelectedColor ?? this.chipSelectedColor,
      badgeBackgroundColor: badgeBackgroundColor ?? this.badgeBackgroundColor,
      badgeBackgroundColorLight:
          badgeBackgroundColorLight ?? this.badgeBackgroundColorLight,
      badgeBackgroundColorDark:
          badgeBackgroundColorDark ?? this.badgeBackgroundColorDark,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
      badgeTextColorLight: badgeTextColorLight ?? this.badgeTextColorLight,
      badgeTextColorDark: badgeTextColorDark ?? this.badgeTextColorDark,
      searchBarBackgroundLight:
          searchBarBackgroundLight ?? this.searchBarBackgroundLight,
      searchBarBackgroundDark:
          searchBarBackgroundDark ?? this.searchBarBackgroundDark,
      searchBarElevation: searchBarElevation ?? this.searchBarElevation,
      searchBarHintStyle: searchBarHintStyle ?? this.searchBarHintStyle,
      segmentedButtonSelectedColor:
          segmentedButtonSelectedColor ?? this.segmentedButtonSelectedColor,
      segmentedButtonSelectedColorLight:
          segmentedButtonSelectedColorLight ??
          this.segmentedButtonSelectedColorLight,
      segmentedButtonSelectedColorDark:
          segmentedButtonSelectedColorDark ??
          this.segmentedButtonSelectedColorDark,
      segmentedButtonForegroundColor:
          segmentedButtonForegroundColor ?? this.segmentedButtonForegroundColor,
      segmentedButtonForegroundColorLight:
          segmentedButtonForegroundColorLight ??
          this.segmentedButtonForegroundColorLight,
      segmentedButtonForegroundColorDark:
          segmentedButtonForegroundColorDark ??
          this.segmentedButtonForegroundColorDark,
      popupMenuBackgroundLight:
          popupMenuBackgroundLight ?? this.popupMenuBackgroundLight,
      popupMenuBackgroundDark:
          popupMenuBackgroundDark ?? this.popupMenuBackgroundDark,
      popupMenuElevation: popupMenuElevation ?? this.popupMenuElevation,
      popupMenuShape: popupMenuShape ?? this.popupMenuShape,
      expansionTileBackgroundColor:
          expansionTileBackgroundColor ?? this.expansionTileBackgroundColor,
      expansionTileBackgroundColorLight:
          expansionTileBackgroundColorLight ??
          this.expansionTileBackgroundColorLight,
      expansionTileBackgroundColorDark:
          expansionTileBackgroundColorDark ??
          this.expansionTileBackgroundColorDark,
      expansionTileCollapsedBackgroundColor:
          expansionTileCollapsedBackgroundColor ??
          this.expansionTileCollapsedBackgroundColor,
      expansionTileCollapsedBackgroundColorLight:
          expansionTileCollapsedBackgroundColorLight ??
          this.expansionTileCollapsedBackgroundColorLight,
      expansionTileCollapsedBackgroundColorDark:
          expansionTileCollapsedBackgroundColorDark ??
          this.expansionTileCollapsedBackgroundColorDark,
      expansionTileIconColor:
          expansionTileIconColor ?? this.expansionTileIconColor,
      expansionTileIconColorLight:
          expansionTileIconColorLight ?? this.expansionTileIconColorLight,
      expansionTileIconColorDark:
          expansionTileIconColorDark ?? this.expansionTileIconColorDark,
      fontFamily: fontFamily ?? this.fontFamily,
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      highlightColorLight: highlightColorLight ?? this.highlightColorLight,
      highlightColorDark: highlightColorDark ?? this.highlightColorDark,
      hoverColor: hoverColor ?? this.hoverColor,
      focusColor: focusColor ?? this.focusColor,
      disabledColor: disabledColor ?? this.disabledColor,
      shadowColor: shadowColor ?? this.shadowColor,
      visualDensity: visualDensity ?? this.visualDensity,
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
    );
  }

  /// Merges this config with another, giving priority to the other config's non-null values
  SACThemeConfig merge(SACThemeConfig? other) {
    if (other == null) return this;
    return SACThemeConfig(
      primary: other.primary ?? primary,
      primaryLight: other.primaryLight ?? primaryLight,
      primaryDark: other.primaryDark ?? primaryDark,
      secondary: other.secondary ?? secondary,
      secondaryLight: other.secondaryLight ?? secondaryLight,
      secondaryDark: other.secondaryDark ?? secondaryDark,
      error: other.error ?? error,
      errorLight: other.errorLight ?? errorLight,
      errorDark: other.errorDark ?? errorDark,
      success: other.success ?? success,
      successLight: other.successLight ?? successLight,
      successDark: other.successDark ?? successDark,
      backgroundLight: other.backgroundLight ?? backgroundLight,
      surfaceLight: other.surfaceLight ?? surfaceLight,
      borderLight: other.borderLight ?? borderLight,
      textPrimaryLight: other.textPrimaryLight ?? textPrimaryLight,
      textMutedLight: other.textMutedLight ?? textMutedLight,
      backgroundDark: other.backgroundDark ?? backgroundDark,
      surfaceDark: other.surfaceDark ?? surfaceDark,
      borderDark: other.borderDark ?? borderDark,
      textPrimaryDark: other.textPrimaryDark ?? textPrimaryDark,
      textMutedDark: other.textMutedDark ?? textMutedDark,
      lightRed: other.lightRed ?? lightRed,
      purple: other.purple ?? purple,
      grey: other.grey ?? grey,
      darkGrey: other.darkGrey ?? darkGrey,
      scaffoldBackgroundLight:
          other.scaffoldBackgroundLight ?? scaffoldBackgroundLight,
      scaffoldBackgroundDark:
          other.scaffoldBackgroundDark ?? scaffoldBackgroundDark,
      appBarBackgroundLight:
          other.appBarBackgroundLight ?? appBarBackgroundLight,
      appBarBackgroundDark: other.appBarBackgroundDark ?? appBarBackgroundDark,
      appBarForegroundLight:
          other.appBarForegroundLight ?? appBarForegroundLight,
      appBarForegroundDark: other.appBarForegroundDark ?? appBarForegroundDark,
      appBarElevation: other.appBarElevation ?? appBarElevation,
      appBarCenterTitle: other.appBarCenterTitle ?? appBarCenterTitle,
      appBarTitleTextStyle: other.appBarTitleTextStyle ?? appBarTitleTextStyle,
      appBarIconTheme: other.appBarIconTheme ?? appBarIconTheme,
      bottomNavBackgroundLight:
          other.bottomNavBackgroundLight ?? bottomNavBackgroundLight,
      bottomNavBackgroundDark:
          other.bottomNavBackgroundDark ?? bottomNavBackgroundDark,
      bottomNavSelectedColor:
          other.bottomNavSelectedColor ?? bottomNavSelectedColor,
      bottomNavUnselectedColor:
          other.bottomNavUnselectedColor ?? bottomNavUnselectedColor,
      bottomNavElevation: other.bottomNavElevation ?? bottomNavElevation,
      bottomNavType: other.bottomNavType ?? bottomNavType,
      navigationBarBackgroundLight:
          other.navigationBarBackgroundLight ?? navigationBarBackgroundLight,
      navigationBarBackgroundDark:
          other.navigationBarBackgroundDark ?? navigationBarBackgroundDark,
      navigationBarIndicatorColor:
          other.navigationBarIndicatorColor ?? navigationBarIndicatorColor,
      navigationBarHeight: other.navigationBarHeight ?? navigationBarHeight,
      navigationRailBackgroundLight:
          other.navigationRailBackgroundLight ?? navigationRailBackgroundLight,
      navigationRailBackgroundDark:
          other.navigationRailBackgroundDark ?? navigationRailBackgroundDark,
      navigationRailSelectedColor:
          other.navigationRailSelectedColor ?? navigationRailSelectedColor,
      navigationRailUnselectedColor:
          other.navigationRailUnselectedColor ?? navigationRailUnselectedColor,
      drawerBackgroundLight:
          other.drawerBackgroundLight ?? drawerBackgroundLight,
      drawerBackgroundDark: other.drawerBackgroundDark ?? drawerBackgroundDark,
      drawerWidth: other.drawerWidth ?? drawerWidth,
      drawerElevation: other.drawerElevation ?? drawerElevation,
      fabBackgroundLight: other.fabBackgroundLight ?? fabBackgroundLight,
      fabBackgroundDark: other.fabBackgroundDark ?? fabBackgroundDark,
      fabForegroundLight: other.fabForegroundLight ?? fabForegroundLight,
      fabForegroundDark: other.fabForegroundDark ?? fabForegroundDark,
      fabElevation: other.fabElevation ?? fabElevation,
      fabShape: other.fabShape ?? fabShape,
      elevatedButtonStyle: other.elevatedButtonStyle ?? elevatedButtonStyle,
      elevatedButtonBackgroundColor:
          other.elevatedButtonBackgroundColor ?? elevatedButtonBackgroundColor,
      elevatedButtonBackgroundColorLight:
          other.elevatedButtonBackgroundColorLight ??
              elevatedButtonBackgroundColorLight,
      elevatedButtonBackgroundColorDark:
          other.elevatedButtonBackgroundColorDark ??
              elevatedButtonBackgroundColorDark,
      elevatedButtonForegroundColor:
          other.elevatedButtonForegroundColor ?? elevatedButtonForegroundColor,
      elevatedButtonForegroundColorLight:
          other.elevatedButtonForegroundColorLight ??
              elevatedButtonForegroundColorLight,
      elevatedButtonForegroundColorDark:
          other.elevatedButtonForegroundColorDark ??
              elevatedButtonForegroundColorDark,
      outlinedButtonStyle: other.outlinedButtonStyle ?? outlinedButtonStyle,
      outlinedButtonTextColor:
          other.outlinedButtonTextColor ?? outlinedButtonTextColor,
      outlinedButtonTextColorLight:
          other.outlinedButtonTextColorLight ?? outlinedButtonTextColorLight,
      outlinedButtonTextColorDark:
          other.outlinedButtonTextColorDark ?? outlinedButtonTextColorDark,
      outlinedButtonBorderColor:
          other.outlinedButtonBorderColor ?? outlinedButtonBorderColor,
      outlinedButtonBorderColorLight:
          other.outlinedButtonBorderColorLight ??
              outlinedButtonBorderColorLight,
      outlinedButtonBorderColorDark:
          other.outlinedButtonBorderColorDark ?? outlinedButtonBorderColorDark,
      textButtonStyle: other.textButtonStyle ?? textButtonStyle,
      textButtonTextColor: other.textButtonTextColor ?? textButtonTextColor,
      textButtonTextColorLight:
          other.textButtonTextColorLight ?? textButtonTextColorLight,
      textButtonTextColorDark:
          other.textButtonTextColorDark ?? textButtonTextColorDark,
      filledButtonStyle: other.filledButtonStyle ?? filledButtonStyle,
      filledButtonBackgroundColor:
          other.filledButtonBackgroundColor ?? filledButtonBackgroundColor,
      filledButtonBackgroundColorLight:
          other.filledButtonBackgroundColorLight ??
              filledButtonBackgroundColorLight,
      filledButtonBackgroundColorDark:
          other.filledButtonBackgroundColorDark ??
              filledButtonBackgroundColorDark,
      filledButtonForegroundColor:
          other.filledButtonForegroundColor ?? filledButtonForegroundColor,
      filledButtonForegroundColorLight:
          other.filledButtonForegroundColorLight ??
              filledButtonForegroundColorLight,
      filledButtonForegroundColorDark:
          other.filledButtonForegroundColorDark ??
              filledButtonForegroundColorDark,
      iconButtonStyle: other.iconButtonStyle ?? iconButtonStyle,
      cardColorLight: other.cardColorLight ?? cardColorLight,
      cardColorDark: other.cardColorDark ?? cardColorDark,
      cardElevation: other.cardElevation ?? cardElevation,
      cardShape: other.cardShape ?? cardShape,
      cardMargin: other.cardMargin ?? cardMargin,
      dialogBackgroundLight:
          other.dialogBackgroundLight ?? dialogBackgroundLight,
      dialogBackgroundDark: other.dialogBackgroundDark ?? dialogBackgroundDark,
      dialogElevation: other.dialogElevation ?? dialogElevation,
      dialogShape: other.dialogShape ?? dialogShape,
      dialogTitleStyle: other.dialogTitleStyle ?? dialogTitleStyle,
      dialogContentStyle: other.dialogContentStyle ?? dialogContentStyle,
      bottomSheetBackgroundLight:
          other.bottomSheetBackgroundLight ?? bottomSheetBackgroundLight,
      bottomSheetBackgroundDark:
          other.bottomSheetBackgroundDark ?? bottomSheetBackgroundDark,
      bottomSheetElevation: other.bottomSheetElevation ?? bottomSheetElevation,
      bottomSheetShape: other.bottomSheetShape ?? bottomSheetShape,
      bottomSheetDragHandleColor:
          other.bottomSheetDragHandleColor ?? bottomSheetDragHandleColor,
      snackBarBackgroundLight:
          other.snackBarBackgroundLight ?? snackBarBackgroundLight,
      snackBarBackgroundDark:
          other.snackBarBackgroundDark ?? snackBarBackgroundDark,
      snackBarActionColor: other.snackBarActionColor ?? snackBarActionColor,
      snackBarBehavior: other.snackBarBehavior ?? snackBarBehavior,
      inputFillColorLight: other.inputFillColorLight ?? inputFillColorLight,
      inputFillColorDark: other.inputFillColorDark ?? inputFillColorDark,
      inputBorderColor: other.inputBorderColor ?? inputBorderColor,
      inputFocusedBorderColor:
          other.inputFocusedBorderColor ?? inputFocusedBorderColor,
      inputErrorBorderColor:
          other.inputErrorBorderColor ?? inputErrorBorderColor,
      inputLabelStyle: other.inputLabelStyle ?? inputLabelStyle,
      inputHintStyle: other.inputHintStyle ?? inputHintStyle,
      inputBorderRadius: other.inputBorderRadius ?? inputBorderRadius,
      checkboxFillColor: other.checkboxFillColor ?? checkboxFillColor,
      radioFillColor: other.radioFillColor ?? radioFillColor,
      switchActiveColor: other.switchActiveColor ?? switchActiveColor,
      switchInactiveColor: other.switchInactiveColor ?? switchInactiveColor,
      switchTrackColor: other.switchTrackColor ?? switchTrackColor,
      sliderActiveColor: other.sliderActiveColor ?? sliderActiveColor,
      sliderInactiveColor: other.sliderInactiveColor ?? sliderInactiveColor,
      sliderThumbColor: other.sliderThumbColor ?? sliderThumbColor,
      progressIndicatorColor:
          other.progressIndicatorColor ?? progressIndicatorColor,
      progressIndicatorBackgroundColor:
          other.progressIndicatorBackgroundColor ??
          progressIndicatorBackgroundColor,
      circularProgressStrokeWidth:
          other.circularProgressStrokeWidth ?? circularProgressStrokeWidth,
      tooltipBackgroundColor:
          other.tooltipBackgroundColor ?? tooltipBackgroundColor,
      tooltipTextStyle: other.tooltipTextStyle ?? tooltipTextStyle,
      tooltipPadding: other.tooltipPadding ?? tooltipPadding,
      dividerColor: other.dividerColor ?? dividerColor,
      dividerThickness: other.dividerThickness ?? dividerThickness,
      dividerIndent: other.dividerIndent ?? dividerIndent,
      listTileIconColor: other.listTileIconColor ?? listTileIconColor,
      listTileTitleStyle: other.listTileTitleStyle ?? listTileTitleStyle,
      listTileSubtitleStyle:
          other.listTileSubtitleStyle ?? listTileSubtitleStyle,
      listTileSelectedColor:
          other.listTileSelectedColor ?? listTileSelectedColor,
      tabBarIndicatorColor: other.tabBarIndicatorColor ?? tabBarIndicatorColor,
      tabBarLabelColor: other.tabBarLabelColor ?? tabBarLabelColor,
      tabBarUnselectedLabelColor:
          other.tabBarUnselectedLabelColor ?? tabBarUnselectedLabelColor,
      tabBarIndicatorWeight:
          other.tabBarIndicatorWeight ?? tabBarIndicatorWeight,
      dataTableHeadingRowColor:
          other.dataTableHeadingRowColor ?? dataTableHeadingRowColor,
      dataTableDataRowColor:
          other.dataTableDataRowColor ?? dataTableDataRowColor,
      dataTableDividerThickness:
          other.dataTableDividerThickness ?? dataTableDividerThickness,
      chipBackgroundLight: other.chipBackgroundLight ?? chipBackgroundLight,
      chipBackgroundDark: other.chipBackgroundDark ?? chipBackgroundDark,
      chipLabelStyle: other.chipLabelStyle ?? chipLabelStyle,
      chipDeleteIconColor: other.chipDeleteIconColor ?? chipDeleteIconColor,
      chipSelectedColor: other.chipSelectedColor ?? chipSelectedColor,
      badgeBackgroundColor: other.badgeBackgroundColor ?? badgeBackgroundColor,
      badgeTextColor: other.badgeTextColor ?? badgeTextColor,
      searchBarBackgroundLight:
          other.searchBarBackgroundLight ?? searchBarBackgroundLight,
      searchBarBackgroundDark:
          other.searchBarBackgroundDark ?? searchBarBackgroundDark,
      searchBarElevation: other.searchBarElevation ?? searchBarElevation,
      searchBarHintStyle: other.searchBarHintStyle ?? searchBarHintStyle,
      segmentedButtonSelectedColor:
          other.segmentedButtonSelectedColor ?? segmentedButtonSelectedColor,
      segmentedButtonForegroundColor:
          other.segmentedButtonForegroundColor ??
          segmentedButtonForegroundColor,
      popupMenuBackgroundLight:
          other.popupMenuBackgroundLight ?? popupMenuBackgroundLight,
      popupMenuBackgroundDark:
          other.popupMenuBackgroundDark ?? popupMenuBackgroundDark,
      popupMenuElevation: other.popupMenuElevation ?? popupMenuElevation,
      popupMenuShape: other.popupMenuShape ?? popupMenuShape,
      expansionTileBackgroundColor:
          other.expansionTileBackgroundColor ?? expansionTileBackgroundColor,
      expansionTileCollapsedBackgroundColor:
          other.expansionTileCollapsedBackgroundColor ??
          expansionTileCollapsedBackgroundColor,
      expansionTileIconColor:
          other.expansionTileIconColor ?? expansionTileIconColor,
      fontFamily: other.fontFamily ?? fontFamily,
      displayLarge: other.displayLarge ?? displayLarge,
      displayMedium: other.displayMedium ?? displayMedium,
      displaySmall: other.displaySmall ?? displaySmall,
      headlineLarge: other.headlineLarge ?? headlineLarge,
      headlineMedium: other.headlineMedium ?? headlineMedium,
      headlineSmall: other.headlineSmall ?? headlineSmall,
      titleLarge: other.titleLarge ?? titleLarge,
      titleMedium: other.titleMedium ?? titleMedium,
      titleSmall: other.titleSmall ?? titleSmall,
      bodyLarge: other.bodyLarge ?? bodyLarge,
      bodyMedium: other.bodyMedium ?? bodyMedium,
      bodySmall: other.bodySmall ?? bodySmall,
      labelLarge: other.labelLarge ?? labelLarge,
      labelMedium: other.labelMedium ?? labelMedium,
      labelSmall: other.labelSmall ?? labelSmall,
      splashColor: other.splashColor ?? splashColor,
      highlightColor: other.highlightColor ?? highlightColor,
      hoverColor: other.hoverColor ?? hoverColor,
      focusColor: other.focusColor ?? focusColor,
      disabledColor: other.disabledColor ?? disabledColor,
      shadowColor: other.shadowColor ?? shadowColor,
      visualDensity: other.visualDensity ?? visualDensity,
      materialTapTargetSize:
          other.materialTapTargetSize ?? materialTapTargetSize,
    );
  }
}
