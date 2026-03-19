import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

/// SearchBar style variants
enum SearchBarStyle { outlined, filled, underline, rounded, pill }

/// SearchBar animation types
enum SearchBarAnimationType { none, fade, slide, scale }

/// A highly customizable search bar widget with extensive configuration options.
///
/// Features:
/// - Multiple style presets (outlined, filled, underline, rounded, pill)
/// - Configurable appearance (colors, sizes, borders, icons)
/// - Search debouncing to prevent excessive API calls
/// - Clear button with animation
/// - Voice search support (optional)
/// - Loading state indicator
/// - Error state styling
/// - Full accessibility support
/// - Security validation for input
///
/// Example usage:
/// ```dart
/// CustomSearchBar(
///   style: SearchBarStyle.rounded,
///   hintText: 'Search products...',
///   onSearch: (query) => performSearch(query),
///   onChanged: (value) => print(value),
///   showClearButton: true,
///   debounceMs: 300,
/// )
/// ```
class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    // ============== Controllers & Focus ==============
    this.controller,
    this.focusNode,
    // ============== Callbacks ==============
    this.onChanged,
    this.onSearch,
    this.onSubmitted,
    this.onTap,
    this.onClear,
    this.onFocusChanged,
    this.onVoiceSearch,
    // ============== Style Configuration ==============
    this.style = SearchBarStyle.outlined,
    this.animationType = SearchBarAnimationType.fade,
    // ============== Size Configuration ==============
    this.height,
    this.width,
    this.padding,
    this.contentPadding,
    this.margin,
    this.borderRadius,
    this.borderWidth,
    this.iconPaddingLeft,
    this.iconPaddingRight,
    this.iconSpacing,
    // ============== Color Configuration ==============
    this.backgroundColor,
    this.focusedBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
    this.focusedIconColor,
    this.disabledIconColor,
    this.cursorColor,
    this.shadowColor,
    this.clearButtonColor,
    this.clearButtonBackgroundColor,
    this.loadingIndicatorColor,
    // ============== Icon Configuration ==============
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconData,
    this.suffixIconData,
    this.prefixIconSize,
    this.suffixIconSize,
    this.showPrefixIcon = true,
    this.showClearButton = true,
    this.showVoiceButton = false,
    this.clearIcon,
    this.voiceIcon,
    this.clearIconSize,
    this.voiceIconData,
    // ============== Text Configuration ==============
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.maxLength,
    // ============== Keyboard Configuration ==============
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableSuggestions = true,
    this.autocorrect = true,
    // ============== Behavior Configuration ==============
    this.debounceMs,
    this.hapticFeedback = true,
    this.closeKeyboardOnSubmit = true,
    this.clearOnSubmit = false,
    this.selectAllOnFocus = false,
    // ============== State Configuration ==============
    this.isLoading = false,
    this.hasError = false,
    this.errorText,
    this.errorTextStyle,
    this.errorTextPadding,
    // ============== Animation Configuration ==============
    this.animationDuration,
    this.animationCurve,
    this.elevation,
    this.focusedElevation,
    // ============== Loading Configuration ==============
    this.loadingWidget,
    this.loadingIndicatorSize,
    this.loadingIndicatorStrokeWidth,
    // ============== Clear Button Configuration ==============
    this.clearButtonPadding,
    this.clearButtonShape,
    // ============== Input Configuration ==============
    this.inputFormatters,
    this.autofillHints,
    // ============== Accessibility ==============
    this.semanticLabel,
    // ============== Security ==============
    this.enableSecurity,
  });

  // ============== Controllers & Focus ==============
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // ============== Callbacks ==============
  /// Called when the search text changes
  final void Function(String)? onChanged;

  /// Called when search is submitted (with debounce)
  final void Function(String)? onSearch;

  /// Called when user submits via keyboard action
  final void Function(String)? onSubmitted;

  /// Called when search bar is tapped
  final VoidCallback? onTap;

  /// Called when clear button is pressed
  final VoidCallback? onClear;

  /// Called when focus state changes
  final void Function(bool)? onFocusChanged;

  /// Called when voice search button is pressed
  final VoidCallback? onVoiceSearch;

  // ============== Style Configuration ==============
  final SearchBarStyle style;
  final SearchBarAnimationType animationType;

  // ============== Size Configuration ==============
  /// Height of the search bar
  final double? height;

  /// Width of the search bar (null = full width)
  final double? width;

  /// Padding around the search bar container
  final EdgeInsetsGeometry? padding;

  /// Padding inside the search bar
  final EdgeInsetsGeometry? contentPadding;

  /// Margin around the search bar
  final EdgeInsetsGeometry? margin;

  /// Border radius of the search bar
  final double? borderRadius;

  /// Border width
  final double? borderWidth;

  /// Padding on the left side of icons
  final double? iconPaddingLeft;

  /// Padding on the right side of icons
  final double? iconPaddingRight;

  /// Spacing between suffix icons
  final double? iconSpacing;

  // ============== Color Configuration ==============
  final Color? backgroundColor;
  final Color? focusedBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;
  final Color? focusedIconColor;
  final Color? disabledIconColor;
  final Color? cursorColor;
  final Color? shadowColor;
  final Color? clearButtonColor;
  final Color? clearButtonBackgroundColor;
  final Color? loadingIndicatorColor;

  // ============== Icon Configuration ==============
  /// Custom prefix icon widget
  final Widget? prefixIcon;

  /// Custom suffix icon widget
  final Widget? suffixIcon;

  /// Icon data for prefix (used if prefixIcon is null)
  final IconData? prefixIconData;

  /// Icon data for suffix (used if suffixIcon is null)
  final IconData? suffixIconData;

  /// Size of prefix icon
  final double? prefixIconSize;

  /// Size of suffix icon
  final double? suffixIconSize;

  /// Whether to show prefix icon
  final bool showPrefixIcon;

  /// Whether to show clear button when text is present
  final bool showClearButton;

  /// Whether to show voice search button
  final bool showVoiceButton;

  /// Custom clear icon widget
  final Widget? clearIcon;

  /// Custom voice icon widget
  final Widget? voiceIcon;

  /// Size of the clear icon (ratio of suffix icon size)
  final double? clearIconSize;

  /// Icon data for voice button
  final IconData? voiceIconData;

  // ============== Text Configuration ==============
  /// Hint text (placeholder)
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLength;

  // ============== Keyboard Configuration ==============
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final bool enableSuggestions;
  final bool autocorrect;

  // ============== Behavior Configuration ==============
  /// Debounce duration in milliseconds for search callback
  final int? debounceMs;

  /// Whether to trigger haptic feedback on actions
  final bool hapticFeedback;

  /// Whether to close keyboard on submit
  final bool closeKeyboardOnSubmit;

  /// Whether to clear text on submit
  final bool clearOnSubmit;

  /// Whether to select all text when focused
  final bool selectAllOnFocus;

  // ============== State Configuration ==============
  /// Whether the search is currently loading
  final bool isLoading;

  /// Whether the search bar is in error state
  final bool hasError;

  /// Error text to display
  final String? errorText;

  /// Style for error text
  final TextStyle? errorTextStyle;

  /// Padding for error text
  final EdgeInsetsGeometry? errorTextPadding;

  // ============== Animation Configuration ==============
  final Duration? animationDuration;
  final Curve? animationCurve;
  final double? elevation;
  final double? focusedElevation;

  // ============== Loading Configuration ==============
  /// Custom loading widget
  final Widget? loadingWidget;

  /// Size of the loading indicator
  final double? loadingIndicatorSize;

  /// Stroke width of the loading indicator
  final double? loadingIndicatorStrokeWidth;

  // ============== Clear Button Configuration ==============
  /// Padding inside the clear button
  final double? clearButtonPadding;

  /// Shape of the clear button background
  final BoxShape? clearButtonShape;

  // ============== Input Configuration ==============
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  // ============== Accessibility ==============
  final String? semanticLabel;

  // ============== Security ==============
  final bool? enableSecurity;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  Timer? _debounceTimer;
  bool _isFocused = false;
  bool _hasText = false;

  // ============== Default Values ==============
  static const double _defaultBorderWidth = 1.0;
  static const double _defaultIconPaddingLeft = 16.0;
  static const double _defaultIconPaddingRight = 8.0;
  static const double _defaultIconSpacing = 4.0;
  static const double _defaultPrefixIconSize = 24.0;
  static const double _defaultSuffixIconSize = 24.0;
  static const double _defaultFontSize = 16.0;
  static const double _defaultContentPaddingH = 16.0;
  static const double _defaultContentPaddingV = 12.0;
  static const double _defaultClearIconSizeRatio = 0.7;
  static const double _defaultClearButtonPadding = 4.0;
  static const double _defaultLoadingStrokeWidth = 2.0;
  static const double _defaultErrorTextFontSize = 12.0;
  static const double _defaultRoundedBorderRadius = 16.0;
  static const double _defaultBoxedBorderRadius = 12.0;
  static const int _defaultDebounceMs = 300;
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 200);
  static const String _defaultHintText = 'Search';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _hasText = _controller.text.isNotEmpty;

    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve ?? Curves.easeInOut,
      ),
    );

    if (_hasText) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller &&
        widget.controller != null) {
      _controller.removeListener(_handleTextChange);
      _controller = widget.controller!;
      _controller.addListener(_handleTextChange);
      _hasText = _controller.text.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
    _animationController.dispose();

    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
    widget.onFocusChanged?.call(_focusNode.hasFocus);

    if (_focusNode.hasFocus &&
        widget.selectAllOnFocus &&
        _controller.text.isNotEmpty) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
  }

  void _handleTextChange() {
    final hasText = _controller.text.isNotEmpty;

    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
      if (hasText) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }

    // Validate and sanitize input
    final sanitizedQuery = validateSearchQuery(
      _controller.text,
      enableSecurity: widget.enableSecurity,
    );

    safeSearchCallback(widget.onChanged, sanitizedQuery, context: 'onChanged');

    // Debounced search
    if (widget.onSearch != null) {
      _debounceTimer?.cancel();
      final debounceDuration = validateDebounceDuration(
        _debounceMs,
        enableSecurity: widget.enableSecurity,
      );
      _debounceTimer = Timer(Duration(milliseconds: debounceDuration), () {
        if (sanitizedQuery.length >= SearchBarSecurityConfig.minQueryLength) {
          safeSearchCallback(
            widget.onSearch,
            sanitizedQuery,
            context: 'onSearch',
          );
        }
      });
    }
  }

  void _handleSubmit(String value) {
    if (widget.hapticFeedback) {
      HapticFeedback.mediumImpact();
    }

    if (widget.closeKeyboardOnSubmit) {
      _focusNode.unfocus();
    }

    final sanitizedQuery = validateSearchQuery(
      value,
      enableSecurity: widget.enableSecurity,
    );

    safeSearchCallback(
      widget.onSubmitted,
      sanitizedQuery,
      context: 'onSubmitted',
    );

    if (widget.clearOnSubmit) {
      _controller.clear();
    }
  }

  void _handleClear() {
    if (widget.hapticFeedback) {
      HapticFeedback.selectionClick();
    }

    _controller.clear();
    safeSearchVoidCallback(widget.onClear, context: 'onClear');

    // Refocus after clear
    _focusNode.requestFocus();
  }

  void _handleVoiceSearch() {
    if (widget.hapticFeedback) {
      HapticFeedback.mediumImpact();
    }
    safeSearchVoidCallback(widget.onVoiceSearch, context: 'onVoiceSearch');
  }

  // ============== Getters with Validation ==============

  Duration get _animationDuration =>
      widget.animationDuration ?? _defaultAnimationDuration;

  int get _debounceMs => widget.debounceMs ?? _defaultDebounceMs;

  double get _height => validateSearchBarHeight(
    widget.height,
    defaultValue: context.inputHeight,
    enableSecurity: widget.enableSecurity,
  );

  double get _borderWidth => widget.borderWidth ?? _defaultBorderWidth;

  double get _iconPaddingLeft =>
      (widget.iconPaddingLeft ?? _defaultIconPaddingLeft).w;

  double get _iconPaddingRight =>
      (widget.iconPaddingRight ?? _defaultIconPaddingRight).w;

  double get _iconSpacing => (widget.iconSpacing ?? _defaultIconSpacing).w;

  double get _borderRadius => validateSearchBarBorderRadius(
    widget.borderRadius,
    defaultValue: _getDefaultBorderRadius(),
    enableSecurity: widget.enableSecurity,
  );

  double get _prefixIconSize => validateSearchBarIconSize(
    widget.prefixIconSize,
    defaultValue: _defaultPrefixIconSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double get _suffixIconSize => validateSearchBarIconSize(
    widget.suffixIconSize,
    defaultValue: _defaultSuffixIconSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double get _fontSize => validateSearchBarFontSize(
    widget.fontSize,
    defaultValue: _defaultFontSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double get _clearIconSize =>
      _suffixIconSize * (widget.clearIconSize ?? _defaultClearIconSizeRatio);

  double get _clearButtonPadding =>
      (widget.clearButtonPadding ?? _defaultClearButtonPadding).w;

  double get _loadingStrokeWidth =>
      widget.loadingIndicatorStrokeWidth ?? _defaultLoadingStrokeWidth;

  double get _loadingSize => widget.loadingIndicatorSize ?? _prefixIconSize;

  String get _hintText => widget.hintText ?? _defaultHintText;

  TextInputType get _keyboardType => widget.keyboardType ?? TextInputType.text;

  TextInputAction get _textInputAction =>
      widget.textInputAction ?? TextInputAction.search;

  TextCapitalization get _textCapitalization =>
      widget.textCapitalization ?? TextCapitalization.none;

  double _getDefaultBorderRadius() {
    switch (widget.style) {
      case SearchBarStyle.pill:
        return _height / 2;
      case SearchBarStyle.rounded:
        return _defaultRoundedBorderRadius;
      case SearchBarStyle.underline:
        return 0;
      case SearchBarStyle.outlined:
      case SearchBarStyle.filled:
        return _defaultBoxedBorderRadius;
    }
  }

  Color get _backgroundColor {
    if (!widget.enabled) {
      return widget.disabledBackgroundColor ??
          AppColors.grey100.withValues(alpha: 0.5);
    }
    if (_isFocused && widget.focusedBackgroundColor != null) {
      return widget.focusedBackgroundColor!;
    }
    return widget.backgroundColor ?? _getDefaultBackgroundColor();
  }

  Color _getDefaultBackgroundColor() {
    switch (widget.style) {
      case SearchBarStyle.filled:
        return AppColors.grey100;
      case SearchBarStyle.outlined:
      case SearchBarStyle.underline:
      case SearchBarStyle.rounded:
      case SearchBarStyle.pill:
        return Colors.transparent;
    }
  }

  Color get _borderColor {
    if (widget.hasError) {
      return widget.errorBorderColor ?? AppColors.red;
    }
    if (_isFocused) {
      return widget.focusedBorderColor ?? AppColors.primary;
    }
    return widget.borderColor ?? AppColors.grey200;
  }

  Color get _iconColor {
    if (!widget.enabled) {
      return widget.disabledIconColor ?? AppColors.grey;
    }
    if (_isFocused) {
      return widget.focusedIconColor ?? widget.iconColor ?? AppColors.primary;
    }
    return widget.iconColor ?? AppColors.grey;
  }

  Color get _textColor => widget.textColor ?? AppColors.black;
  Color get _hintColor => widget.hintColor ?? AppColors.grey;
  Color get _cursorColor => widget.cursorColor ?? AppColors.primary;

  Color get _clearButtonBgColor =>
      widget.clearButtonBackgroundColor ??
      AppColors.grey200.withValues(alpha: 0.5);

  Color get _clearIconColor => widget.clearButtonColor ?? _iconColor;

  Color get _loadingColor => widget.loadingIndicatorColor ?? _iconColor;

  EdgeInsetsGeometry get _contentPadding {
    return widget.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: validateSearchBarPadding(
            _defaultContentPaddingH,
            defaultValue: _defaultContentPaddingH,
            enableSecurity: widget.enableSecurity,
          ),
          vertical: validateSearchBarPadding(
            _defaultContentPaddingV,
            defaultValue: _defaultContentPaddingV,
            enableSecurity: widget.enableSecurity,
          ),
        );
  }

  EdgeInsetsGeometry get _errorTextPadding =>
      widget.errorTextPadding ??
      EdgeInsets.only(left: _iconPaddingLeft, top: 4.h);

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: _hintText,
      hintStyle:
          widget.hintStyle ??
          TextStyle(
            color: _hintColor,
            fontSize: _fontSize,
            fontWeight: widget.fontWeight ?? FontWeight.normal,
            fontFamily: widget.fontFamily,
          ),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: _contentPadding,
      prefixIcon: _buildPrefixIcon(),
      suffixIcon: _buildSuffixIcon(),
      prefixIconConstraints: BoxConstraints(
        minWidth: _prefixIconSize + _iconPaddingLeft + _iconPaddingRight,
        minHeight: _prefixIconSize,
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: _suffixIconSize + _iconPaddingLeft + _iconPaddingRight,
        minHeight: _suffixIconSize,
      ),
      counterText: '',
    );
  }

  Widget? _buildPrefixIcon() {
    if (!widget.showPrefixIcon) return null;

    if (widget.prefixIcon != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: _iconPaddingLeft,
          right: _iconPaddingRight,
        ),
        child: widget.prefixIcon,
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: _iconPaddingLeft,
        right: _iconPaddingRight,
      ),
      child: AnimatedSwitcher(
        duration: _animationDuration,
        child: widget.isLoading
            ? widget.loadingWidget ??
                  SizedBox(
                    width: _loadingSize,
                    height: _loadingSize,
                    child: CircularProgressIndicator(
                      strokeWidth: _loadingStrokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(_loadingColor),
                    ),
                  )
            : Icon(
                widget.prefixIconData ?? Icons.search,
                size: _prefixIconSize,
                color: _iconColor,
              ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return Padding(
        padding: EdgeInsets.only(
          right: _iconPaddingLeft,
          left: _iconPaddingRight,
        ),
        child: widget.suffixIcon,
      );
    }

    final List<Widget> suffixWidgets = [];

    // Clear button
    if (widget.showClearButton && _hasText) {
      suffixWidgets.add(
        FadeTransition(
          opacity: _fadeAnimation,
          child: GestureDetector(
            onTap: _handleClear,
            behavior: HitTestBehavior.opaque,
            child:
                widget.clearIcon ??
                Container(
                  padding: EdgeInsets.all(_clearButtonPadding),
                  decoration: BoxDecoration(
                    color: _clearButtonBgColor,
                    shape: widget.clearButtonShape ?? BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: _clearIconSize,
                    color: _clearIconColor,
                  ),
                ),
          ),
        ),
      );
    }

    // Voice button
    if (widget.showVoiceButton && widget.onVoiceSearch != null) {
      suffixWidgets.add(
        GestureDetector(
          onTap: _handleVoiceSearch,
          behavior: HitTestBehavior.opaque,
          child:
              widget.voiceIcon ??
              Icon(
                widget.voiceIconData ?? Icons.mic_outlined,
                size: _suffixIconSize,
                color: _iconColor,
              ),
        ),
      );
    }

    // Suffix icon data
    if (widget.suffixIconData != null) {
      suffixWidgets.add(
        Icon(widget.suffixIconData, size: _suffixIconSize, color: _iconColor),
      );
    }

    if (suffixWidgets.isEmpty) return null;

    return Padding(
      padding: EdgeInsets.only(
        right: _iconPaddingLeft,
        left: _iconPaddingRight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: suffixWidgets
            .map(
              (widget) => Padding(
                padding: EdgeInsets.symmetric(horizontal: _iconSpacing),
                child: widget,
              ),
            )
            .toList(),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    switch (widget.style) {
      case SearchBarStyle.outlined:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: _borderColor, width: _borderWidth),
        );

      case SearchBarStyle.filled:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
        );

      case SearchBarStyle.underline:
        return BoxDecoration(
          color: _backgroundColor,
          border: Border(
            bottom: BorderSide(color: _borderColor, width: _borderWidth),
          ),
        );

      case SearchBarStyle.rounded:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: _borderColor, width: _borderWidth),
          boxShadow: widget.elevation != null && widget.elevation! > 0
              ? [
                  BoxShadow(
                    color: (widget.shadowColor ?? Colors.black).withValues(
                      alpha: 0.1,
                    ),
                    blurRadius: widget.elevation! * 2,
                    offset: Offset(0, widget.elevation!),
                  ),
                ]
              : null,
        );

      case SearchBarStyle.pill:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: _borderColor, width: _borderWidth),
          boxShadow: _isFocused && (widget.focusedElevation ?? 0) > 0
              ? [
                  BoxShadow(
                    color: (widget.shadowColor ?? AppColors.primary).withValues(
                      alpha: 0.2,
                    ),
                    blurRadius: widget.focusedElevation! * 2,
                    offset: Offset(0, widget.focusedElevation!),
                  ),
                ]
              : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget searchField = AnimatedContainer(
      duration: _animationDuration,
      curve: widget.animationCurve ?? Curves.easeInOut,
      height: _height,
      width: widget.width,
      padding: widget.padding,
      margin: widget.margin,
      decoration: _buildDecoration(),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style:
            widget.textStyle ??
            TextStyle(
              color: _textColor,
              fontSize: _fontSize,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              fontFamily: widget.fontFamily,
            ),
        decoration: _buildInputDecoration(),
        keyboardType: _keyboardType,
        textInputAction: _textInputAction,
        textCapitalization: _textCapitalization,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        enableSuggestions: widget.enableSuggestions,
        autocorrect: widget.autocorrect,
        cursorColor: _cursorColor,
        maxLength: widget.maxLength ?? SearchBarSecurityConfig.maxQueryLength,
        inputFormatters: widget.inputFormatters,
        autofillHints: widget.autofillHints,
        onSubmitted: _handleSubmit,
        onTap: () {
          if (widget.hapticFeedback) {
            HapticFeedback.selectionClick();
          }
          safeSearchVoidCallback(widget.onTap, context: 'onTap');
        },
      ),
    );

    // Error text
    if (widget.hasError && widget.errorText != null) {
      searchField = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchField,
          Padding(
            padding: _errorTextPadding,
            child: Text(
              widget.errorText!,
              style:
                  widget.errorTextStyle ??
                  TextStyle(
                    color: widget.errorBorderColor ?? AppColors.red,
                    fontSize: _defaultErrorTextFontSize.sp,
                  ),
            ),
          ),
        ],
      );
    }

    // Accessibility wrapper
    if (widget.semanticLabel != null) {
      searchField = Semantics(
        label: widget.semanticLabel,
        textField: true,
        child: searchField,
      );
    }

    return searchField;
  }
}

/// A search bar with filter chips for category/tag filtering.
///
/// Example:
/// ```dart
/// FilterableSearchBar(
///   filters: ['All', 'Products', 'Users', 'Orders'],
///   selectedFilter: 'All',
///   onFilterChanged: (filter) => setFilter(filter),
///   onSearch: (query) => performSearch(query),
/// )
/// ```
class FilterableSearchBar extends StatelessWidget {
  const FilterableSearchBar({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.onSearch,
    this.onChanged,
    this.controller,
    this.hintText,
    this.style = SearchBarStyle.rounded,
    this.chipStyle,
    this.selectedChipStyle,
    this.spacing,
    this.filterScrollable = true,
    this.filterHeight,
    this.chipPaddingHorizontal,
    this.chipPaddingVertical,
    this.chipBorderRadius,
    this.selectedChipColor,
    this.unselectedChipColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.chipFontSize,
    this.chipFontWeight,
    this.selectedChipFontWeight,
    this.animationDuration,
  });

  final List<String> filters;
  final String selectedFilter;
  final void Function(String) onFilterChanged;
  final void Function(String)? onSearch;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final SearchBarStyle style;
  final TextStyle? chipStyle;
  final TextStyle? selectedChipStyle;
  final double? spacing;
  final bool filterScrollable;
  final double? filterHeight;
  final double? chipPaddingHorizontal;
  final double? chipPaddingVertical;
  final double? chipBorderRadius;
  final Color? selectedChipColor;
  final Color? unselectedChipColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double? chipFontSize;
  final FontWeight? chipFontWeight;
  final FontWeight? selectedChipFontWeight;
  final Duration? animationDuration;
  // ============== Default Values ==============
  static const double _defaultSpacing = 8.0;
  static const double _defaultFilterHeight = 40.0;
  static const double _defaultChipPaddingH = 16.0;
  static const double _defaultChipPaddingV = 8.0;
  static const double _defaultChipBorderRadius = 20.0;
  static const double _defaultChipFontSize = 14.0;
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 200);

  double get _spacing => spacing ?? _defaultSpacing;
  double get _filterHeight => (filterHeight ?? _defaultFilterHeight).h;
  double get _chipPaddingH => (chipPaddingHorizontal ?? _defaultChipPaddingH).w;
  double get _chipPaddingV => (chipPaddingVertical ?? _defaultChipPaddingV).h;
  double get _chipBorderRadius => chipBorderRadius ?? _defaultChipBorderRadius;
  double get _chipFontSize => (chipFontSize ?? _defaultChipFontSize).sp;
  Duration get _animationDuration =>
      animationDuration ?? _defaultAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          controller: controller,
          hintText: hintText,
          style: style,
          onSearch: onSearch,
          onChanged: onChanged,
        ),
        SizedBox(height: _spacing),
        SizedBox(
          height: _filterHeight,
          child: filterScrollable
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, _) => SizedBox(width: _spacing),
                  itemBuilder: (context, index) =>
                      _buildFilterChip(filters[index]),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: filters.map(_buildFilterChip).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String filter) {
    final isSelected = filter == selectedFilter;

    return GestureDetector(
      onTap: () => onFilterChanged(filter),
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: EdgeInsets.symmetric(
          horizontal: _chipPaddingH,
          vertical: _chipPaddingV,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (selectedChipColor ?? AppColors.primary)
              : (unselectedChipColor ?? AppColors.grey100),
          borderRadius: BorderRadius.circular(_chipBorderRadius),
        ),
        child: Text(
          filter,
          style:
              (isSelected ? selectedChipStyle : chipStyle) ??
              TextStyle(
                color: isSelected
                    ? (selectedTextColor ?? AppColors.white)
                    : (unselectedTextColor ?? AppColors.grey),
                fontSize: _chipFontSize,
                fontWeight: isSelected
                    ? (selectedChipFontWeight ?? FontWeight.w600)
                    : (chipFontWeight ?? FontWeight.normal),
              ),
        ),
      ),
    );
  }
}

/// A search bar that expands from an icon when tapped.
///
/// Useful for saving space in app bars.
class ExpandableSearchBar extends StatefulWidget {
  const ExpandableSearchBar({
    super.key,
    required this.onSearch,
    this.onChanged,
    this.hintText,
    this.expandedWidth,
    this.collapsedWidth,
    this.expandedWidthFactor,
    this.iconSize,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconPadding,
    this.iconData,
    this.style = SearchBarStyle.rounded,
    this.animationDuration,
    this.animationCurve,
    this.showClearButton = true,
    this.collapseOnUnfocus = true,
  });

  final void Function(String) onSearch;
  final void Function(String)? onChanged;
  final String? hintText;

  /// Explicit expanded width (overrides expandedWidthFactor)
  final double? expandedWidth;

  /// Width when collapsed (icon only)
  final double? collapsedWidth;

  /// Factor of screen width for expanded state (default: 0.7)
  final double? expandedWidthFactor;

  final double? iconSize;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final double? iconPadding;
  final IconData? iconData;
  final SearchBarStyle style;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool showClearButton;
  final bool collapseOnUnfocus;

  @override
  State<ExpandableSearchBar> createState() => _ExpandableSearchBarState();
}

class _ExpandableSearchBarState extends State<ExpandableSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late FocusNode _focusNode;

  bool _isExpanded = false;

  // ============== Default Values ==============
  static const double _defaultIconSize = 24.0;
  static const double _defaultIconPadding = 8.0;
  static const double _defaultExpandedWidthFactor = 0.7;
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 300);

  double get _iconSize => widget.iconSize ?? _defaultIconSize;
  double get _iconPadding => (widget.iconPadding ?? _defaultIconPadding).w;
  double get _collapsedWidth =>
      widget.collapsedWidth ?? (_iconSize + _iconPadding * 2);
  Duration get _animationDuration =>
      widget.animationDuration ?? _defaultAnimationDuration;
  Curve get _animationCurve => widget.animationCurve ?? Curves.easeOutCubic;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _focusNode = FocusNode();
    if (widget.collapseOnUnfocus) {
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    final expandedWidthFactor =
        widget.expandedWidthFactor ?? _defaultExpandedWidthFactor;
    _widthAnimation = Tween<double>(
      begin: _collapsedWidth,
      end: widget.expandedWidth ?? screenWidth * expandedWidthFactor,
    ).animate(CurvedAnimation(parent: _controller, curve: _animationCurve));
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.collapseOnUnfocus) {
      _focusNode.removeListener(_handleFocusChange);
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _isExpanded) {
      _collapse();
    }
  }

  void _expand() {
    setState(() => _isExpanded = true);
    _controller.forward();
    _focusNode.requestFocus();
  }

  void _collapse() {
    setState(() => _isExpanded = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return SizedBox(
          width: _widthAnimation.value,
          child: _isExpanded
              ? CustomSearchBar(
                  focusNode: _focusNode,
                  hintText: widget.hintText,
                  style: widget.style,
                  onSearch: widget.onSearch,
                  onChanged: widget.onChanged,
                  showClearButton: widget.showClearButton,
                )
              : GestureDetector(
                  onTap: _expand,
                  child: Container(
                    padding: EdgeInsets.all(_iconPadding),
                    decoration: widget.iconBackgroundColor != null
                        ? BoxDecoration(
                            color: widget.iconBackgroundColor,
                            shape: BoxShape.circle,
                          )
                        : null,
                    child: Icon(
                      widget.iconData ?? Icons.search,
                      size: _iconSize,
                      color: widget.iconColor ?? AppColors.grey,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
