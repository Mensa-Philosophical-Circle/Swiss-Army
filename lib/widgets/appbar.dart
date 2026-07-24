import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

/// A secure, customizable AppBar with input validation and safe callbacks.
///
/// Security Features:
/// - Input validation for sizes, heights, and font sizes
/// - Safe callback execution with error handling
/// - Text sanitization to prevent overflow
/// - Accessibility support with semantic labels
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final double height;
  final bool centerTitle;
  final double elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Widget? leading;
  final double? leadingWidth;
  final bool showBackButton;
  final IconData backIcon;
  final double backIconSize;
  final Color? backIconColor;
  final VoidCallback? onBack;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final double actionsIconThemePadding;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final List<double>? gradientStops;
  final BoxDecoration? flexibleSpaceDecoration;
  final bool transparent;
  final Color? titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final TextStyle? titleTextStyle;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? foregroundColor;
  final bool forceMaterialTransparency;
  final ScrollNotificationPredicate? notificationPredicate;
  final Clip clipBehavior;
  final bool primary;
  final bool excludeHeaderSemantics;
  final Widget? flexibleSpace;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? toolbarHeight;
  final ShapeBorder? shape;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextStyle? toolbarTextStyle;
  final String? semanticLabel;
  final bool? enableSecurity;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.height = 60.0,
    this.centerTitle = true,
    this.elevation = 0,
    this.shadowColor,
    this.surfaceTintColor,
    this.leading,
    this.leadingWidth,
    this.showBackButton = true,
    this.backIcon = Icons.arrow_back_ios,
    this.backIconSize = 24,
    this.backIconColor,
    this.onBack,
    this.automaticallyImplyLeading,
    this.actions,
    this.actionsIconThemePadding = 0,
    this.backgroundColor,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.gradientStops,
    this.flexibleSpaceDecoration,
    this.transparent = false,
    this.titleColor,
    this.titleFontSize = 20.0,
    this.titleFontWeight = FontWeight.bold,
    this.titleTextStyle,
    this.bottom,
    this.systemOverlayStyle,
    this.foregroundColor,
    this.forceMaterialTransparency = false,
    this.notificationPredicate,
    this.clipBehavior = Clip.none,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.flexibleSpace,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.toolbarTextStyle,
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    validateAppBarHeight(
          height,
          defaultValue: 60.0,
          enableSecurity: enableSecurity,
        ) +
        (bottom?.preferredSize.height ?? 0),
  );

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    if (!showBackButton) return const SizedBox.shrink();

    return IconButton(
      icon: Icon(
        backIcon,
        size: validateIconSize(
          backIconSize,
          defaultValue: 24,
          enableSecurity: enableSecurity,
        ),
        color: backIconColor ?? foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () => safeAppBarCallback(
        onBack ?? () => Get.back(),
        context: 'back button',
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }

  Widget? _buildFlexibleSpace() {
    if (flexibleSpace != null) return flexibleSpace;
    if (transparent) return null;

    if (flexibleSpaceDecoration != null) {
      return Container(decoration: flexibleSpaceDecoration);
    }

    final validGradient = validateGradientColors(
      gradientColors,
      enableSecurity: enableSecurity,
    );
    if (validGradient != null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: validGradient,
            begin: gradientBegin,
            end: gradientEnd,
            stops: gradientStops,
          ),
        ),
      );
    }

    return null;
  }

  Widget _buildTitle(BuildContext context) {
    if (titleWidget != null) return titleWidget!;

    final style =
        titleTextStyle ??
        TextStyle(
          color: titleColor ?? Theme.of(context).colorScheme.onPrimary,
          fontSize: validateTitleFontSize(
            titleFontSize,
            defaultValue: 20.0,
            enableSecurity: enableSecurity,
          ),
          fontWeight: titleFontWeight,
        );

    return Text(
      sanitizeTitleText(title, enableSecurity: enableSecurity),
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolvedBg = transparent
        ? Colors.transparent
        : (gradientColors != null ? Colors.transparent : backgroundColor);

    final validActions = validateActions(
      actions,
      enableSecurity: enableSecurity,
    );
    final safeHeight = validateAppBarHeight(
      height,
      defaultValue: 60.0,
      enableSecurity: enableSecurity,
    );
    final safeElevation = validateAppBarElevation(
      elevation,
      defaultValue: 0,
      enableSecurity: enableSecurity,
    );

    final appBar = AppBar(
      leading: _buildLeading(context),
      leadingWidth: leadingWidth,
      automaticallyImplyLeading:
          automaticallyImplyLeading ?? (leading == null && showBackButton),
      title: _buildTitle(context),
      centerTitle: centerTitle,
      actions: validActions,
      flexibleSpace: _buildFlexibleSpace(),
      bottom: bottom,
      elevation: safeElevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor ?? Colors.transparent,
      backgroundColor: resolvedBg,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleTextStyle: titleTextStyle,
      toolbarTextStyle: toolbarTextStyle,
      systemOverlayStyle: validateSystemOverlayStyle(systemOverlayStyle),
      forceMaterialTransparency: forceMaterialTransparency,
      clipBehavior: clipBehavior,
      toolbarHeight: toolbarHeight ?? safeHeight,
      toolbarOpacity: toolbarOpacity.clamp(0.0, 1.0),
      bottomOpacity: bottomOpacity.clamp(0.0, 1.0),
      shape: shape,
    );

    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, header: true, child: appBar);
    }

    return appBar;
  }
}

/// A secure sliver version of [CustomAppBar] for use in CustomScrollView.
class CustomSliverAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final double expandedHeight;
  final double collapsedHeight;
  final bool pinned;
  final bool floating;
  final bool snap;
  final bool stretch;
  final double stretchTriggerOffset;
  final VoidCallback? onStretchTrigger;
  final Widget? leading;
  final bool showBackButton;
  final IconData backIcon;
  final Color? backIconColor;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final ShapeBorder? shape;
  final Color? titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final String? semanticLabel;
  final bool? enableSecurity;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.expandedHeight = 200.0,
    this.collapsedHeight = 60.0,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.stretch = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.leading,
    this.showBackButton = true,
    this.backIcon = Icons.arrow_back_ios,
    this.backIconColor,
    this.onBack,
    this.actions,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.titleColor,
    this.titleFontSize = 20.0,
    this.titleFontWeight = FontWeight.bold,
    this.semanticLabel,
    this.enableSecurity,
  });

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    if (!showBackButton) return null;

    return IconButton(
      icon: Icon(
        backIcon,
        color: backIconColor ?? foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () => safeAppBarCallback(
        onBack ?? () => Get.back(),
        context: 'CustomSliverAppBar.back',
      ),
    );
  }

  Widget _buildFlexibleSpace(BuildContext context) {
    if (flexibleSpace != null) return flexibleSpace!;

    final validGradient = validateGradientColors(
      gradientColors,
      enableSecurity: enableSecurity,
    );

    return FlexibleSpaceBar(
      centerTitle: centerTitle,
      title:
          titleWidget ??
          Text(
            sanitizeTitleText(title, enableSecurity: enableSecurity),
            style: TextStyle(
              color: titleColor ?? Theme.of(context).colorScheme.onPrimary,
              fontSize: validateTitleFontSize(
                titleFontSize,
                defaultValue: 20.0,
                enableSecurity: enableSecurity,
              ),
              fontWeight: titleFontWeight,
            ),
          ),
      background: validGradient != null
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: validGradient,
                  begin: gradientBegin,
                  end: gradientEnd,
                ),
              ),
            )
          : Container(color: backgroundColor ?? Theme.of(context).colorScheme.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sliverAppBar = SliverAppBar(
      leading: _buildLeading(context),
      actions: validateActions(actions, enableSecurity: enableSecurity),
      expandedHeight: validateAppBarHeight(
        expandedHeight,
        defaultValue: 200.0,
        enableSecurity: enableSecurity,
      ),
      collapsedHeight: validateAppBarHeight(
        collapsedHeight,
        defaultValue: 60.0,
        enableSecurity: enableSecurity,
      ),
      pinned: pinned,
      floating: floating,
      snap: snap,
      stretch: stretch,
      stretchTriggerOffset: stretchTriggerOffset.clamp(0, 500),
      onStretchTrigger: onStretchTrigger != null
          ? () async => safeAppBarCallback(onStretchTrigger, context: 'stretch')
          : null,
      elevation: validateAppBarElevation(
        elevation,
        defaultValue: 0,
        enableSecurity: enableSecurity,
      ),
      backgroundColor: gradientColors != null
          ? Colors.transparent
          : backgroundColor,
      foregroundColor: foregroundColor,
      flexibleSpace: _buildFlexibleSpace(context),
      bottom: bottom,
      shape: shape,
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
    );

    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, header: true, child: sliverAppBar);
    }

    return sliverAppBar;
  }
}

/// A simple transparent AppBar for overlaying content.
class TransparentAppBar extends CustomAppBar {
  const TransparentAppBar({
    super.key,
    super.title,
    super.titleWidget,
    super.actions,
    super.leading,
    super.showBackButton = true,
    super.backIcon,
    super.backIconColor,
    super.onBack,
    super.elevation = 0,
    super.systemOverlayStyle = SystemUiOverlayStyle.light,
    super.semanticLabel,
    super.enableSecurity,
  }) : super(transparent: true);
}

/// Secure SearchAppBar with input validation and safe callbacks.
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onBack;
  final VoidCallback? onClear;
  final bool autofocus;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final Color? iconColor;
  final Color? textColor;
  final Color? hintColor;
  final double height;
  final List<Widget>? actions;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final bool showBackButton;
  final IconData backIcon;
  final bool showClearButton;
  final int maxSearchLength;
  final String? semanticLabel;
  final bool? enableSecurity;

  const SearchAppBar({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onBack,
    this.onClear,
    this.autofocus = true,
    this.backgroundColor,
    this.gradientColors,
    this.iconColor,
    this.textColor,
    this.hintColor,
    this.height = 60.0,
    this.actions,
    this.inputDecoration,
    this.textStyle,
    this.showBackButton = true,
    this.backIcon = Icons.arrow_back_ios,
    this.showClearButton = true,
    this.maxSearchLength = 200,
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    validateAppBarHeight(
      height,
      defaultValue: 60.0,
      enableSecurity: enableSecurity,
    ),
  );

  void _handleChange(String value) {
    if (onChanged == null) return;
    final sanitized = value.length > maxSearchLength
        ? value.substring(0, maxSearchLength)
        : value;
    safeValueChanged(onChanged, sanitized, context: 'SearchAppBar.onChanged');
  }

  void _handleSubmit(String value) {
    if (onSubmitted == null) return;
    final sanitized = value.length > maxSearchLength
        ? value.substring(0, maxSearchLength)
        : value;
    safeValueChanged(
      onSubmitted,
      sanitized,
      context: 'SearchAppBar.onSubmitted',
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? Theme.of(context).colorScheme.onPrimary;
    final effectiveTextColor = textColor ?? Theme.of(context).colorScheme.onPrimary;
    final effectiveHintColor = hintColor ?? Theme.of(context).colorScheme.onPrimary.withOpacity(0.7);

    Widget? flexibleSpace;
    final validGradient = validateGradientColors(
      gradientColors,
      enableSecurity: enableSecurity,
    );
    if (validGradient != null) {
      flexibleSpace = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: validGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    }

    final appBar = AppBar(
      backgroundColor: gradientColors != null
          ? Colors.transparent
          : backgroundColor,
      flexibleSpace: flexibleSpace,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: showBackButton
          ? IconButton(
              icon: Icon(backIcon, color: effectiveIconColor),
              onPressed: () => safeAppBarCallback(
                onBack ?? () => Get.back(),
                context: 'SearchAppBar.back',
              ),
            )
          : null,
      title: TextField(
        controller: controller,
        autofocus: autofocus,
        onChanged: _handleChange,
        onSubmitted: _handleSubmit,
        maxLength: maxSearchLength,
        buildCounter:
            (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) => null,
        style: textStyle ?? TextStyle(color: effectiveTextColor),
        cursorColor: effectiveTextColor,
        decoration:
            inputDecoration ??
            InputDecoration(
              hintText: sanitizeHintText(
                hintText,
                enableSecurity: enableSecurity,
              ),
              hintStyle: TextStyle(color: effectiveHintColor),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
      ),
      actions: [
        if (showClearButton)
          IconButton(
            icon: Icon(Icons.close, color: effectiveIconColor),
            onPressed: () {
              controller?.clear();
              safeAppBarCallback(onClear, context: 'SearchAppBar.clear');
            },
          ),
        ...?validateActions(actions, enableSecurity: enableSecurity),
      ],
    );

    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, textField: true, child: appBar);
    }

    return appBar;
  }
}

/// Secure TabbedAppBar with input validation and safe callbacks.
class TabbedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final double height;
  final double tabBarHeight;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final TabBarIndicatorSize indicatorSize;
  final EdgeInsetsGeometry? indicatorPadding;
  final Decoration? indicator;
  final String? semanticLabel;
  final bool? enableSecurity;

  const TabbedAppBar({
    super.key,
    this.title,
    this.titleWidget,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.backgroundColor,
    this.gradientColors,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.height = 60.0,
    this.tabBarHeight = 48.0,
    this.leading,
    this.showBackButton = true,
    this.onBack,
    this.actions,
    this.indicatorSize = TabBarIndicatorSize.label,
    this.indicatorPadding,
    this.indicator,
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    validateAppBarHeight(
          height,
          defaultValue: 60.0,
          enableSecurity: enableSecurity,
        ) +
        validateAppBarHeight(
          tabBarHeight,
          defaultValue: 48.0,
          enableSecurity: enableSecurity,
        ),
  );

  @override
  Widget build(BuildContext context) {
    Widget? flexibleSpace;
    final validGradient = validateGradientColors(
      gradientColors,
      enableSecurity: enableSecurity,
    );
    if (validGradient != null) {
      flexibleSpace = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: validGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    }

    final validTabs = validateTabs(tabs, enableSecurity: enableSecurity);

    final appBar = AppBar(
      backgroundColor: gradientColors != null
          ? Colors.transparent
          : backgroundColor,
      flexibleSpace: flexibleSpace,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading:
          leading ??
          (showBackButton
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onPrimary),
                  onPressed: () => safeAppBarCallback(
                    onBack ?? () => Get.back(),
                    context: 'TabbedAppBar.back',
                  ),
                )
              : null),
      title:
          titleWidget ??
          (title != null
              ? Text(
                  sanitizeTitleText(title, enableSecurity: enableSecurity),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: validateTitleFontSize(
                      20,
                      defaultValue: 20,
                      enableSecurity: enableSecurity,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null),
      actions: validateActions(actions, enableSecurity: enableSecurity),
      bottom: TabBar(
        controller: controller,
        tabs: validTabs,
        isScrollable: isScrollable,
        indicatorColor: indicatorColor ?? Theme.of(context).colorScheme.onPrimary,
        labelColor: labelColor ?? Theme.of(context).colorScheme.onPrimary,
        unselectedLabelColor: unselectedLabelColor ?? Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
        indicatorSize: indicatorSize,
        indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
        indicator: indicator,
      ),
    );

    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, header: true, child: appBar);
    }

    return appBar;
  }
}
