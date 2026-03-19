import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';
import 'widget.dart';

/// A secure elevated button with debouncing, loading states, and accessibility.
///
/// Security Features:
/// - Debouncing to prevent rapid/double clicks
/// - Safe callback execution with error handling
/// - Input validation for sizes
/// - Accessibility support with semantic labels
class AppElevatedButton extends StatefulWidget {
  final void Function()? onPressed;
  final String? title;
  final Widget? child;
  final Color? bgColor;
  final Color? textColor;
  final Color? disabledBgColor;
  final Color? disabledTextColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final BorderSide? side;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final double? iconSpacing;

  /// Enable debouncing to prevent rapid clicks. Defaults to true.
  final bool enableDebounce;

  /// Debounce duration. Defaults to 300ms.
  final Duration debounceDuration;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Exclude from semantics tree.
  final bool excludeFromSemantics;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.title,
    this.child,
    this.bgColor,
    this.textColor,
    this.disabledBgColor,
    this.disabledTextColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.side,
    this.isLoading = false,
    this.loadingWidget,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.iconSpacing,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.enableSecurity,
  });

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;

      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'AppElevatedButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'AppElevatedButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = widget.textColor;
    final safeHeight = validateSize(
      widget.height,
      defaultValue: null,
      enableSecurity: widget.enableSecurity,
    );
    final safeFontSize = validateFontSize(
      widget.fontSize,
      defaultValue: null,
      enableSecurity: widget.enableSecurity,
    );
    final safeElevation = validateElevation(
      widget.elevation,
      defaultValue: null,
      enableSecurity: widget.enableSecurity,
    );
    final safeIconSize = validateSize(
      widget.iconSize,
      defaultValue: 18.sp,
      min: 10,
      max: 48,
      enableSecurity: widget.enableSecurity,
    );

    Widget content;
    if (widget.isLoading) {
      content =
          widget.loadingWidget ??
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveTextColor ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          );
    } else if (widget.child != null) {
      content = widget.child!;
    } else {
      final textWidget = SmallAppText(
        sanitizeButtonText(widget.title, enableSecurity: widget.enableSecurity),
        color: effectiveTextColor,
        fontWeight: widget.fontWeight ?? FontWeight.w600,
        fontSize: safeFontSize,
      );

      if (widget.prefixIcon != null || widget.suffixIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: safeIconSize,
                color: effectiveTextColor,
              ),
              SizedBox(width: widget.iconSpacing ?? 8.w),
            ],
            textWidget,
            if (widget.suffixIcon != null) ...[
              SizedBox(width: widget.iconSpacing ?? 8.w),
              Icon(
                widget.suffixIcon,
                size: safeIconSize,
                color: effectiveTextColor,
              ),
            ],
          ],
        );
      } else {
        content = textWidget;
      }
    }

    final button = SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? context.buttonHeight,
      child: ElevatedButton(
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        clipBehavior: widget.clipBehavior,
        statesController: widget.statesController,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor,
          foregroundColor: widget.textColor,
          disabledBackgroundColor: widget.disabledBgColor,
          disabledForegroundColor: widget.disabledTextColor,
          minimumSize: safeHeight != null ? Size(0, safeHeight) : null,
          padding: widget.padding,
          elevation: safeElevation,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10.r),
            side: widget.side ?? BorderSide.none,
          ),
        ),
        child: content,
      ),
    );

    if (widget.excludeFromSemantics) {
      return ExcludeSemantics(child: button);
    }

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}

/// A simple elevated button with debouncing and security features.
class NormalElevatedButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final Color? color;
  final Color? txtcolor;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? elevation;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const NormalElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.color,
    this.txtcolor,
    this.padding,
    this.radius,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.elevation,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<NormalElevatedButton> createState() => _NormalElevatedButtonState();
}

class _NormalElevatedButtonState extends State<NormalElevatedButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'NormalElevatedButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'NormalElevatedButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = widget.txtcolor ?? AppColors.white;
    final safeRadius = validateBorderRadius(
      widget.radius,
      defaultValue: 10.r,
      enableSecurity: widget.enableSecurity,
    );

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      final textWidget = SmallAppText(
        sanitizeButtonText(widget.title, enableSecurity: widget.enableSecurity),
        color: effectiveTextColor,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      );

      if (widget.prefixIcon != null || widget.suffixIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
              SizedBox(width: 8.w),
            ],
            textWidget,
            if (widget.suffixIcon != null) ...[
              SizedBox(width: 8.w),
              Icon(
                widget.suffixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
            ],
          ],
        );
      } else {
        content = textWidget;
      }
    }

    final button = SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? context.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: widget.height != null
              ? Size(0, widget.height!)
              : Size(0, context.buttonHeight),
          padding: widget.padding,
          backgroundColor: widget.color,
          elevation: validateElevation(
            widget.elevation,
            defaultValue: null,
            enableSecurity: widget.enableSecurity,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(safeRadius!),
          ),
        ),
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}

/// Secondary elevated button with debouncing and security features.
class AppSecondaryElevatedButton extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const AppSecondaryElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.elevation,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<AppSecondaryElevatedButton> createState() =>
      _AppSecondaryElevatedButtonState();
}

class _AppSecondaryElevatedButtonState
    extends State<AppSecondaryElevatedButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'AppSecondaryElevatedButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'AppSecondaryElevatedButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = widget.textColor;

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            effectiveTextColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else if (widget.prefixIcon != null || widget.suffixIcon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null) ...[
            Icon(widget.prefixIcon, size: 18.sp, color: effectiveTextColor),
            SizedBox(width: 8.w),
          ],
          SmallAppText(
            sanitizeButtonText(
              widget.label,
              enableSecurity: widget.enableSecurity,
            ),
            color: effectiveTextColor,
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(width: 8.w),
            Icon(widget.suffixIcon, size: 18.sp, color: effectiveTextColor),
          ],
        ],
      );
    } else {
      content = SmallAppText(
        sanitizeButtonText(widget.label, enableSecurity: widget.enableSecurity),
        color: effectiveTextColor,
      );
    }

    final button = SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? context.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor,
          padding: widget.padding,
          minimumSize: widget.height != null
              ? Size(0, widget.height!)
              : Size(0, context.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              validateBorderRadius(
                widget.radius,
                defaultValue: 10.0,
                enableSecurity: widget.enableSecurity,
              )!,
            ),
          ),
          elevation: validateElevation(
            widget.elevation,
            defaultValue: 0,
            enableSecurity: widget.enableSecurity,
          ),
          disabledBackgroundColor: widget.bgColor?.withValues(alpha: 0.5),
        ),
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}

/// Outlined button with debouncing and security features.
class AppOutlinedButton extends StatefulWidget {
  final String? label;
  final Color? bgColor;
  final Color? textcolour;
  final Color? brdColor;
  final Widget? child;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool? hideBorder;
  final void Function()? onPressed;
  final double? borderWidth;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const AppOutlinedButton({
    super.key,
    this.label,
    this.bgColor,
    this.brdColor,
    this.hideBorder,
    this.onPressed,
    this.child,
    this.buttonHeight,
    this.buttonWidth,
    this.textcolour,
    this.borderWidth,
    this.radius,
    this.padding,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.fontWeight,
    this.fontSize,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'AppOutlinedButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'AppOutlinedButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = widget.textcolour;

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (widget.child != null) {
      content = widget.child!;
    } else {
      final textWidget = SmallAppText(
        sanitizeButtonText(widget.label, enableSecurity: widget.enableSecurity),
        color: effectiveTextColor,
        fontWeight: widget.fontWeight ?? FontWeight.w600,
        fontSize: widget.fontSize,
      );

      if (widget.prefixIcon != null || widget.suffixIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
              SizedBox(width: 8.w),
            ],
            textWidget,
            if (widget.suffixIcon != null) ...[
              SizedBox(width: 8.w),
              Icon(
                widget.suffixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
            ],
          ],
        );
      } else {
        content = textWidget;
      }
    }

    final button = SizedBox(
      width: widget.buttonWidth ?? double.infinity,
      height: widget.buttonHeight ?? context.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: widget.buttonHeight != null
              ? Size(0, widget.buttonHeight!)
              : Size(0, context.buttonHeight),
          backgroundColor: widget.bgColor ?? Colors.transparent,
          side: widget.hideBorder == true
              ? BorderSide.none
              : BorderSide(
                  width: widget.borderWidth ?? 1.0,
                  color: widget.brdColor ?? Theme.of(context).primaryColor,
                ),
          padding: widget.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              validateBorderRadius(
                widget.radius,
                defaultValue: 10.0,
                enableSecurity: widget.enableSecurity,
              )!, // Defaults to 10.0 so ! is safe here if we keep default, but better to allow null if we want full theme
            ),
          ),
          elevation: 0,
        ),
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}

/// Configurable elevated button with debouncing and security features.
class ConfigElevatedButton extends StatefulWidget {
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final String label;
  final Color? bgcolour;
  final Color? textcolour;
  final BorderRadiusGeometry? radius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final FontWeight? fontWeight;
  final double? fontSize;
  final BorderSide? side;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const ConfigElevatedButton({
    super.key,
    this.width,
    this.height,
    this.onPressed,
    required this.label,
    this.bgcolour,
    this.textcolour,
    this.radius,
    this.padding,
    this.elevation,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.fontWeight,
    this.fontSize,
    this.side,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<ConfigElevatedButton> createState() => _ConfigElevatedButtonState();
}

class _ConfigElevatedButtonState extends State<ConfigElevatedButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'ConfigElevatedButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'ConfigElevatedButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveTextColor = widget.textcolour ?? AppColors.white;

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      final textWidget = SmallAppText(
        sanitizeButtonText(widget.label),
        color: effectiveTextColor,
        fontWeight: widget.fontWeight,
        fontSize: widget.fontSize,
      );

      if (widget.prefixIcon != null || widget.suffixIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
              SizedBox(width: 8.w),
            ],
            textWidget,
            if (widget.suffixIcon != null) ...[
              SizedBox(width: 8.w),
              Icon(
                widget.suffixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
            ],
          ],
        );
      } else {
        content = textWidget;
      }
    }

    final button = SizedBox(
      width: widget.width ?? screenWidth * 0.40,
      height: widget.height ?? 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgcolour ?? AppColors.primary,
          padding: widget.padding ?? simPad(0, 14),
          shape: RoundedRectangleBorder(
            borderRadius: widget.radius ?? BorderRadius.circular(10.0),
            side: widget.side ?? BorderSide.none,
          ),
          elevation: validateElevation(
            widget.elevation,
            defaultValue: 0,
            enableSecurity: widget.enableSecurity,
          ),
          disabledBackgroundColor: (widget.bgcolour ?? AppColors.primary)
              .withValues(alpha: 0.5),
        ),
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}

/// Configurable outlined button with debouncing and security features.
class ConfigOutlinedButton extends StatefulWidget {
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final String label;
  final Color? brdcolour;
  final Color? textcolour;
  final Color? bgColour;
  final double? radius;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const ConfigOutlinedButton({
    super.key,
    this.width,
    this.height,
    this.onPressed,
    required this.label,
    this.brdcolour,
    this.textcolour,
    this.bgColour,
    this.radius,
    this.borderWidth,
    this.padding,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.fontWeight,
    this.fontSize,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<ConfigOutlinedButton> createState() => _ConfigOutlinedButtonState();
}

class _ConfigOutlinedButtonState extends State<ConfigOutlinedButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'ConfigOutlinedButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'ConfigOutlinedButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveTextColor = widget.textcolour ?? AppColors.black;

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      final textWidget = SmallAppText(
        sanitizeButtonText(widget.label, enableSecurity: widget.enableSecurity),
        color: effectiveTextColor,
        fontWeight: widget.fontWeight,
        fontSize: widget.fontSize,
      );

      if (widget.prefixIcon != null || widget.suffixIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
              SizedBox(width: 8.w),
            ],
            textWidget,
            if (widget.suffixIcon != null) ...[
              SizedBox(width: 8.w),
              Icon(
                widget.suffixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
            ],
          ],
        );
      } else {
        content = textWidget;
      }
    }

    final button = SizedBox(
      width: widget.width ?? screenWidth * 0.40,
      height: widget.height ?? context.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: widget.height != null
              ? Size(0, widget.height!)
              : Size(0, context.buttonHeight),
          backgroundColor: widget.bgColour ?? AppColors.white,
          padding: widget.padding ?? simPad(0, 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              validateBorderRadius(
                widget.radius,
                defaultValue: 10.0,
                enableSecurity: widget.enableSecurity,
              )!,
            ),
            side: BorderSide(
              color: widget.brdcolour ?? AppColors.grey200,
              width: widget.borderWidth ?? 1.0,
            ),
          ),
          elevation: 0,
          disabledBackgroundColor: (widget.bgColour ?? AppColors.white)
              .withValues(alpha: 0.5),
        ),
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}

/// Icon button with debouncing and security features.
class AppIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? bgColor;
  final double? size;
  final double? iconSize;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;
  final bool enabled;
  final BorderSide? side;
  final double? elevation;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.bgColor,
    this.size,
    this.iconSize,
    this.radius,
    this.padding,
    this.tooltip,
    this.enabled = true,
    this.side,
    this.elevation,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'AppIconButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'AppIconButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeSize = validateSize(
      widget.size,
      defaultValue: 48.w,
      min: 24,
      max: 120,
      enableSecurity: widget.enableSecurity,
    );
    final safeIconSize = validateSize(
      widget.iconSize,
      defaultValue: 24.sp,
      min: 12,
      max: 60,
      enableSecurity: widget.enableSecurity,
    );

    final button = SizedBox(
      width: safeSize,
      height: safeSize,
      child: ElevatedButton(
        onPressed: widget.enabled && !_isDebouncing ? _handlePress : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor ?? AppColors.primary,
          padding: widget.padding ?? EdgeInsets.zero,
          elevation: validateElevation(
            widget.elevation,
            defaultValue: 0,
            enableSecurity: widget.enableSecurity,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              validateBorderRadius(
                widget.radius,
                defaultValue: 12.r,
                enableSecurity: widget.enableSecurity,
              )!,
            ),
            side: widget.side ?? BorderSide.none,
          ),
        ),
        child: Icon(
          widget.icon,
          size: safeIconSize,
          color: widget.iconColor ?? AppColors.white,
        ),
      ),
    );

    Widget result = button;

    if (widget.tooltip != null) {
      result = Tooltip(message: widget.tooltip!, child: button);
    }

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled,
        child: result,
      );
    }

    return result;
  }
}

/// Text button with debouncing and security features.
class AppTextButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const AppTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.enabled = true,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'AppTextButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'AppTextButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.textColor ?? AppColors.primary;

    final button = TextButton(
      onPressed: widget.enabled && !_isDebouncing ? _handlePress : null,
      style: TextButton.styleFrom(
        padding:
            widget.padding ??
            EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        minimumSize: widget.fontSize != null ? Size(0, widget.fontSize! * 2) : Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefixIcon != null) ...[
            Icon(
              widget.prefixIcon,
              size: widget.iconSize ?? 16.sp,
              color: effectiveColor,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            sanitizeButtonText(
              widget.label,
              enableSecurity: widget.enableSecurity,
            ),
            style: TextStyle(
              color: effectiveColor,
              fontSize: validateFontSize(
                widget.fontSize,
                defaultValue: 14.sp,
                enableSecurity: widget.enableSecurity,
              ),
              fontWeight: widget.fontWeight ?? FontWeight.w500,
              decoration: widget.decoration,
            ),
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(width: 4.w),
            Icon(
              widget.suffixIcon,
              size: widget.iconSize ?? 16.sp,
              color: effectiveColor,
            ),
          ],
        ],
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled,
        child: button,
      );
    }

    return button;
  }
}

/// Gradient button with debouncing and security features.
class AppGradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final List<Color> gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;
  final List<double>? gradientStops;
  final BoxShadow? shadow;
  final bool enableDebounce;
  final Duration debounceDuration;
  final String? semanticLabel;

  /// Enable security validation (size limits, text sanitization).
  /// Defaults to null (uses global ButtonSecurityConfig.enforceValidation).
  /// Set to true to force enable, false to force disable.
  final bool? enableSecurity;

  const AppGradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.gradientColors = const [Color(0xFF10BB76), Color(0xFF086D50)],
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSize,
    this.gradientStops,
    this.shadow,
    this.enableDebounce = true,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.enableSecurity,
  });

  @override
  State<AppGradientButton> createState() => _AppGradientButtonState();
}

class _AppGradientButtonState extends State<AppGradientButton> {
  bool _isDebouncing = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    if (widget.enableDebounce) {
      if (_isDebouncing) return;
      setState(() => _isDebouncing = true);
      _debounceTimer?.cancel();

      safeExecute(widget.onPressed, context: 'AppGradientButton');

      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) setState(() => _isDebouncing = false);
      });
    } else {
      safeExecute(widget.onPressed, context: 'AppGradientButton');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = widget.textColor ?? AppColors.white;
    final safeRadius = validateBorderRadius(
      widget.radius,
      defaultValue: 10.r,
      enableSecurity: widget.enableSecurity,
    );

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
        ),
      );
    } else {
      final textWidget = SmallAppText(
        sanitizeButtonText(widget.label, enableSecurity: widget.enableSecurity),
        color: effectiveTextColor,
        fontWeight: widget.fontWeight ?? FontWeight.w600,
        fontSize: validateFontSize(
          widget.fontSize,
          defaultValue: 14.sp,
          enableSecurity: widget.enableSecurity,
        ),
      );

      if (widget.prefixIcon != null || widget.suffixIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
              SizedBox(width: 8.w),
            ],
            textWidget,
            if (widget.suffixIcon != null) ...[
              SizedBox(width: 8.w),
              Icon(
                widget.suffixIcon,
                size: widget.iconSize ?? 18.sp,
                color: effectiveTextColor,
              ),
            ],
          ],
        );
      } else {
        content = textWidget;
      }
    }

    final button = Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? context.buttonHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.enabled
              ? widget.gradientColors
              : widget.gradientColors
                    .map((c) => c.withValues(alpha: 0.5))
                    .toList(),
          begin: widget.gradientBegin,
          end: widget.gradientEnd,
          stops: widget.gradientStops,
        ),
        borderRadius: BorderRadius.circular(safeRadius!),
        boxShadow: widget.shadow != null ? [widget.shadow!] : null,
      ),
      child: ElevatedButton(
        onPressed: widget.enabled && !widget.isLoading && !_isDebouncing
            ? _handlePress
            : null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, widget.height ?? context.buttonHeight),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(safeRadius),
          ),
        ),
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled && !widget.isLoading,
        child: button,
      );
    }

    return button;
  }
}
