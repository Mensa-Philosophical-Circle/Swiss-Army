import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../utils/utils.dart';

/// TextField style variants
enum TextFieldStyle { outlined, filled, underline, rounded, pill }

/// TextField label position
enum LabelPosition { above, inside, floating }

/// A highly customizable text form field with extensive configuration options.
///
/// Features:
/// - Multiple style presets (outlined, filled, underline, rounded, pill)
/// - Label positioning (above, inside, floating)
/// - Prefix/suffix icons with customization
/// - Error state with custom styling
/// - Loading state indicator
/// - Character counter
/// - Password visibility toggle
/// - Full accessibility support
/// - Security validation
///
/// Example usage:
/// ```dart
/// AppTextField(
///   style: TextFieldStyle.outlined,
///   label: 'Email',
///   hint: 'Enter your email',
///   prefixIconData: Icons.email,
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    // ============== Controllers & Focus ==============
    this.controller,
    this.focusNode,
    // ============== Callbacks ==============
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.onFocusChanged,
    // ============== Style Configuration ==============
    this.fieldStyle = TextFieldStyle.outlined,
    this.labelPosition = LabelPosition.above,
    // ============== Text Configuration ==============
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixText,
    this.suffixText,
    // ============== Size Configuration ==============
    this.height,
    this.width,
    this.contentPadding,
    this.borderRadius,
    this.borderWidth,
    this.labelSpacing,
    // ============== Color Configuration ==============
    this.backgroundColor,
    this.focusedBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.errorColor,
    this.cursorColor,
    this.iconColor,
    this.focusedIconColor,
    this.prefixTextColor,
    this.suffixTextColor,
    // ============== Typography Configuration ==============
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.labelFontSize,
    this.labelFontWeight,
    this.hintFontSize,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.counterStyle,
    // ============== Icon Configuration ==============
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconData,
    this.suffixIconData,
    this.prefixIconSize,
    this.suffixIconSize,
    this.prefixIconColor,
    this.suffixIconColor,
    // ============== Keyboard Configuration ==============
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.showCursor,
    // ============== Password Configuration ==============
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.showPasswordToggle = false,
    this.passwordVisibleIcon,
    this.passwordHiddenIcon,
    // ============== Input Configuration ==============
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.showCounter = false,
    this.inputFormatters,
    this.autofillHints,
    // ============== Validation Configuration ==============
    this.autovalidateMode,
    this.isRequired = false,
    this.requiredIndicatorColor,
    // ============== State Configuration ==============
    this.isLoading = false,
    this.loadingWidget,
    // ============== Accessibility ==============
    this.semanticsLabel,
    // ============== Security ==============
    this.enableSecurity,
  });

  // ============== Controllers & Focus ==============
  final TextEditingController? controller;
  final FocusNode? focusNode;

  // ============== Callbacks ==============
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(bool)? onFocusChanged;

  // ============== Style Configuration ==============
  final TextFieldStyle fieldStyle;
  final LabelPosition labelPosition;

  // ============== Text Configuration ==============
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? counterText;
  final String? prefixText;
  final String? suffixText;

  // ============== Size Configuration ==============
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final double? borderWidth;
  final double? labelSpacing;

  // ============== Color Configuration ==============
  final Color? backgroundColor;
  final Color? focusedBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? errorColor;
  final Color? cursorColor;
  final Color? iconColor;
  final Color? focusedIconColor;
  final Color? prefixTextColor;
  final Color? suffixTextColor;

  // ============== Typography Configuration ==============
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final double? hintFontSize;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final TextStyle? counterStyle;

  // ============== Icon Configuration ==============
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  // ============== Keyboard Configuration ==============
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool? showCursor;

  // ============== Password Configuration ==============
  final bool obscureText;
  final String obscuringCharacter;
  final bool showPasswordToggle;
  final Widget? passwordVisibleIcon;
  final Widget? passwordHiddenIcon;

  // ============== Input Configuration ==============
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool showCounter;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  // ============== Validation Configuration ==============
  final AutovalidateMode? autovalidateMode;
  final bool isRequired;
  final Color? requiredIndicatorColor;

  // ============== State Configuration ==============
  final bool isLoading;
  final Widget? loadingWidget;

  // ============== Accessibility ==============
  final String? semanticsLabel;

  // ============== Security ==============
  final bool? enableSecurity;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;
  bool _hasError = false;

  // ============== Default Values ==============
  static const double _defaultFontSize = 14.0;
  static const double _defaultLabelFontSize = 16.0;
  static const double _defaultHintFontSize = 14.0;
  static const double _defaultBorderRadius = 12.0;
  static const double _defaultBorderWidth = 1.5;
  static const double _defaultLabelSpacing = 8.0;
  static const double _defaultIconSize = 24.0;
  static const double _defaultContentPaddingH = 16.0;
  static const double _defaultContentPaddingV = 14.0;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
    widget.onFocusChanged?.call(_focusNode.hasFocus);
  }

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  // ============== Getters with Validation ==============

  double? get _fontSize => validateTextFieldFontSize(
    widget.fontSize,
    defaultValue: _defaultFontSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double? get _labelFontSize => validateTextFieldFontSize(
    widget.labelFontSize,
    defaultValue: _defaultLabelFontSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double? get _hintFontSize => validateTextFieldFontSize(
    widget.hintFontSize,
    defaultValue: _defaultHintFontSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double? get _borderRadius => validateTextFieldBorderRadius(
    widget.borderRadius,
    defaultValue: _getDefaultBorderRadius(),
    enableSecurity: widget.enableSecurity,
  );

  double? get _borderWidth => validateTextFieldBorderWidth(
    widget.borderWidth,
    defaultValue: _defaultBorderWidth,
    enableSecurity: widget.enableSecurity,
  );

  double? get _labelSpacing => validateLabelSpacing(
    widget.labelSpacing,
    defaultValue: _defaultLabelSpacing.h,
    enableSecurity: widget.enableSecurity,
  );

  double? get _prefixIconSize => validateTextFieldIconSize(
    widget.prefixIconSize,
    defaultValue: _defaultIconSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  double? get _suffixIconSize => validateTextFieldIconSize(
    widget.suffixIconSize,
    defaultValue: _defaultIconSize.sp,
    enableSecurity: widget.enableSecurity,
  );

  int get _maxLines => validateTextFieldMaxLines(
    widget.maxLines,
    enableSecurity: widget.enableSecurity,
  );

  int? get _minLines => widget.minLines != null
      ? validateTextFieldMinLines(
          widget.minLines,
          enableSecurity: widget.enableSecurity,
        )
      : null;

  double _getDefaultBorderRadius() {
    switch (widget.fieldStyle) {
      case TextFieldStyle.pill:
        return 50.0;
      case TextFieldStyle.rounded:
        return 20.0;
      case TextFieldStyle.underline:
        return 0;
      case TextFieldStyle.outlined:
      case TextFieldStyle.filled:
        return _defaultBorderRadius;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (widget.fieldStyle) {
      case TextFieldStyle.filled:
        return isDark
            ? AppColors.grey800
            : (Theme.of(context).inputDecorationTheme.fillColor ??
                AppColors.grey300);
      case TextFieldStyle.outlined:
      case TextFieldStyle.underline:
      case TextFieldStyle.rounded:
      case TextFieldStyle.pill:
        return isDark
            ? (Theme.of(context).inputDecorationTheme.fillColor ??
                  AppColors.grey900)
            : AppColors.white;
    }
  }

  Color get _borderColor {
    if (_hasError || widget.errorText != null) {
      return widget.errorBorderColor ??
          Theme.of(
            context,
          ).inputDecorationTheme.errorBorder?.borderSide.color ??
          AppColors.red;
    }
    if (_isFocused) {
      return widget.focusedBorderColor ??
          Theme.of(
            context,
          ).inputDecorationTheme.focusedBorder?.borderSide.color ??
          AppColors.primary;
    }
    return widget.borderColor ??
        Theme.of(
          context,
        ).inputDecorationTheme.enabledBorder?.borderSide.color ??
        AppColors.grey100;
  }

  Color get _iconColor {
    if (!widget.enabled) return AppColors.grey;
    if (_isFocused) {
      return widget.focusedIconColor ?? widget.iconColor ?? AppColors.primary;
    }
    return widget.iconColor ?? AppColors.grey;
  }

  Color get _textColor =>
      widget.textColor ??
      Theme.of(context).textTheme.bodyLarge?.color ??
      AppColors.black;

  Color get _hintColor =>
      widget.hintColor ??
      Theme.of(context).inputDecorationTheme.hintStyle?.color ??
      AppColors.grey200;

  Color get _labelColor =>
      widget.labelColor ??
      Theme.of(context).inputDecorationTheme.labelStyle?.color ??
      AppColors.black;

  Color get _cursorColor => widget.cursorColor ?? AppColors.primary;

  Color get _errorColor =>
      widget.errorColor ??
      Theme.of(context).inputDecorationTheme.errorStyle?.color ??
      AppColors.red;

  EdgeInsetsGeometry get _contentPadding {
    return widget.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: validateContentPadding(
            _defaultContentPaddingH,
            defaultValue: _defaultContentPaddingH,
            enableSecurity: widget.enableSecurity,
          )!,
          vertical: validateContentPadding(
            _defaultContentPaddingV,
            defaultValue: _defaultContentPaddingV,
            enableSecurity: widget.enableSecurity,
          )!,
        );
  }

  InputBorder _buildBorder({Color? color, double? width}) {
    final borderColor = color ?? _borderColor;
    final borderWidth = width ?? _borderWidth;

    switch (widget.fieldStyle) {
      case TextFieldStyle.outlined:
      case TextFieldStyle.filled:
      case TextFieldStyle.rounded:
      case TextFieldStyle.pill:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius ?? 4.0),
          borderSide: BorderSide(color: borderColor, width: borderWidth ?? 1.0),
        );
      case TextFieldStyle.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth ?? 1.0),
        );
    }
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.hint,
      hintStyle:
          widget.hintStyle ??
          TextStyle(color: _hintColor, fontSize: _hintFontSize),
      helperText: widget.helperText,
      helperStyle:
          widget.helperStyle ??
          TextStyle(color: AppColors.grey, fontSize: 12.sp),
      errorText: widget.errorText,
      errorStyle:
          widget.errorStyle ?? TextStyle(color: _errorColor, fontSize: 12.sp),
      counterText: widget.showCounter ? widget.counterText : '',
      counterStyle: widget.counterStyle,
      prefixText: widget.prefixText,
      prefixStyle: TextStyle(
        color: widget.prefixTextColor ?? _textColor,
        fontSize: _fontSize,
      ),
      suffixText: widget.suffixText,
      suffixStyle: TextStyle(
        color: widget.suffixTextColor ?? _textColor,
        fontSize: _fontSize,
      ),
      labelText:
          widget.labelPosition == LabelPosition.floating ||
              widget.labelPosition == LabelPosition.inside
          ? widget.label
          : null,
      labelStyle:
          widget.labelStyle ??
          TextStyle(
            color: _labelColor,
            fontSize: _labelFontSize,
            fontWeight: widget.labelFontWeight ?? FontWeight.normal,
          ),
      floatingLabelStyle: TextStyle(
        color: _isFocused ? AppColors.primary : _labelColor,
        fontSize: _labelFontSize,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: _backgroundColor,
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      // Use _borderColor which already resolves focusedBorderColor → theme → AppColors.primary
      focusedBorder: _buildBorder(color: _borderColor),
      errorBorder: _buildBorder(color: _errorColor),
      focusedErrorBorder: _buildBorder(
        color: _errorColor,
        width: (_borderWidth ?? 1.0) + 0.5,
      ),
      disabledBorder: _buildBorder(color: AppColors.grey100),
      contentPadding: _contentPadding,
      prefixIcon: _buildPrefixIcon(),
      suffixIcon: _buildSuffixIcon(),
      prefixIconConstraints: BoxConstraints(
        minWidth: (_prefixIconSize ?? 24.0) + 24,
        minHeight: _prefixIconSize ?? 24.0,
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: (_suffixIconSize ?? 24.0) + 24,
        minHeight: _suffixIconSize ?? 24.0,
      ),
      isDense: widget.fieldStyle == TextFieldStyle.pill,
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: widget.prefixIcon,
      );
    }

    if (widget.prefixIconData != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Icon(
          widget.prefixIconData,
          size: _prefixIconSize,
          color: widget.prefixIconColor ?? _iconColor,
        ),
      );
    }

    return null;
  }

  Widget? _buildSuffixIcon() {
    final List<Widget> suffixWidgets = [];

    // Loading indicator
    if (widget.isLoading) {
      suffixWidgets.add(
        widget.loadingWidget ??
            SizedBox(
              width: (_suffixIconSize ?? 24.0) * 0.8,
              height: (_suffixIconSize ?? 24.0) * 0.8,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_iconColor),
              ),
            ),
      );
    }

    // Password toggle
    if (widget.showPasswordToggle && widget.obscureText) {
      suffixWidgets.add(
        GestureDetector(
          onTap: _togglePasswordVisibility,
          child: _obscureText
              ? (widget.passwordHiddenIcon ??
                    Icon(
                      Icons.visibility_off_outlined,
                      size: _suffixIconSize,
                      color: widget.suffixIconColor ?? _iconColor,
                    ))
              : (widget.passwordVisibleIcon ??
                    Icon(
                      Icons.visibility_outlined,
                      size: _suffixIconSize,
                      color: widget.suffixIconColor ?? _iconColor,
                    )),
        ),
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      suffixWidgets.add(widget.suffixIcon!);
    } else if (widget.suffixIconData != null && !widget.showPasswordToggle) {
      suffixWidgets.add(
        Icon(
          widget.suffixIconData,
          size: _suffixIconSize,
          color: widget.suffixIconColor ?? _iconColor,
        ),
      );
    }

    if (suffixWidgets.isEmpty) return null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: suffixWidgets
            .map(
              (w) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: w,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLabel() {
    if (widget.label == null || widget.labelPosition != LabelPosition.above) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label!,
              style:
                  widget.labelStyle ??
                  TextStyle(
                    color: _labelColor,
                    fontSize: _labelFontSize,
                    fontWeight: widget.labelFontWeight ?? FontWeight.w500,
                  ),
            ),
            if (widget.isRequired)
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  '*',
                  style: TextStyle(
                    color: widget.requiredIndicatorColor ?? AppColors.red,
                    fontSize: _labelFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: _labelSpacing),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      style:
          widget.textStyle ??
          TextStyle(
            color: _textColor,
            fontSize: _fontSize,
            fontWeight: widget.fontWeight ?? FontWeight.normal,
          ),
      decoration: _buildInputDecoration(),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      obscureText: widget.showPasswordToggle
          ? _obscureText
          : widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      maxLength: widget.maxLength,
      maxLines: widget.obscureText ? 1 : _maxLines,
      minLines: _minLines,
      expands: widget.expands,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      showCursor: widget.showCursor,
      cursorColor: _cursorColor,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: (value) {
        final error = widget.validator?.call(value);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _hasError = error != null);
        });
        return error;
      },
      onChanged: (value) {
        safeTextFieldCallback(widget.onChanged, value, context: 'onChanged');
      },
      onFieldSubmitted: (value) {
        safeTextFieldCallback(
          widget.onSubmitted,
          value,
          context: 'onSubmitted',
        );
      },
      onTap: () {
        safeTextFieldVoidCallback(widget.onTap, context: 'onTap');
      },
      onEditingComplete: () {
        safeTextFieldVoidCallback(
          widget.onEditingComplete,
          context: 'onEditingComplete',
        );
      },
      onSaved: widget.onSaved,
    );

    // Build the text field, applying optional height constraint
    Widget fieldWidget = textField;
    final double? effectiveHeight =
        widget.maxLines == 1 ? (widget.height ?? context.inputHeight) : null;

    if (effectiveHeight != null || widget.width != null) {
      fieldWidget = SizedBox(
        width: widget.width,
        height: effectiveHeight,
        child: textField,
      );
    }

    Widget result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_buildLabel(), fieldWidget],
    );

    if (widget.semanticsLabel != null) {
      result = Semantics(
        label: widget.semanticsLabel,
        textField: true,
        child: result,
      );
    }

    return result;
  }
}

/// Convenience wrapper for password text field
class AppPasswordField extends StatelessWidget {
  const AppPasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.labelPosition = LabelPosition.above,
    this.fieldStyle = TextFieldStyle.outlined,
    this.textInputAction,
    this.autofocus = false,
    this.enabled = true,
    this.isRequired = false,
    this.showPasswordToggle = true,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.prefixIconData,
    this.enableSecurity,
    this.height,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final LabelPosition labelPosition;
  final TextFieldStyle fieldStyle;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enabled;
  final bool isRequired;
  final bool showPasswordToggle;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final IconData? prefixIconData;
  final bool? enableSecurity;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: label ?? 'Password',
      hint: hint ?? 'Enter your password',
      labelPosition: labelPosition,
      fieldStyle: fieldStyle,
      obscureText: true,
      showPasswordToggle: showPasswordToggle,
      prefixIconData: prefixIconData ?? Icons.lock_outline,
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      enabled: enabled,
      isRequired: isRequired,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      enableSecurity: enableSecurity,
      height: height,
    );
  }
}

/// App Phone Text Field with international phone input
class AppPhoneTextField extends StatelessWidget {
  const AppPhoneTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.onChanged,
    this.onCountryChanged,
    this.validator,
    this.initialCountryCode = 'NG',
    this.labelPosition = LabelPosition.above,
    this.labelStyle,
    this.labelFontSize,
    this.labelFontWeight,
    this.labelColor,
    this.labelSpacing,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.backgroundColor,
    this.cursorColor,
    this.textColor,
    this.hintColor,
    this.dropdownIconColor,
    this.showDropdownIcon = true,
    this.showCountryFlag = true,
    this.enabled = true,
    this.readOnly = false,
    this.isRequired = false,
    this.requiredIndicatorColor,
    this.invalidNumberMessage,
    this.enableSecurity,
    // ============== Size Configuration ==============
    this.height,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final void Function(PhoneNumber)? onChanged;
  final void Function(String)? onCountryChanged;
  final String? Function(PhoneNumber?)? validator;
  final String initialCountryCode;
  final LabelPosition labelPosition;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final Color? labelColor;
  final double? labelSpacing;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? backgroundColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? dropdownIconColor;
  final bool showDropdownIcon;
  final bool showCountryFlag;
  final bool enabled;
  final bool readOnly;
  final bool isRequired;
  final Color? requiredIndicatorColor;
  final String? invalidNumberMessage;
  final bool? enableSecurity;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;

  // ============== Default Values ==============
  static const double _defaultLabelFontSize = 16.0;
  static const double _defaultLabelSpacing = 8.0;
  static const double _defaultBorderRadius = 12.0;
  static const double _defaultBorderWidth = 1.5;

  double? get _labelFontSize => validateTextFieldFontSize(
    labelFontSize,
    defaultValue: _defaultLabelFontSize.sp,
    enableSecurity: enableSecurity,
  );

  double? get _labelSpacing => validateLabelSpacing(
    labelSpacing,
    defaultValue: _defaultLabelSpacing.h,
    enableSecurity: enableSecurity,
  );

  double? get _borderRadius => validateTextFieldBorderRadius(
    borderRadius,
    defaultValue: _defaultBorderRadius,
    enableSecurity: enableSecurity,
  );

  double? get _borderWidth => validateTextFieldBorderWidth(
    borderWidth,
    defaultValue: _defaultBorderWidth,
    enableSecurity: enableSecurity,
  );

  @override
  Widget build(BuildContext context) {
    // Resolve theme colors
    final theme = Theme.of(context);
    final effectiveLabelColor =
        labelColor ??
        theme.inputDecorationTheme.labelStyle?.color ??
        AppColors.black;
    final effectiveHintColor =
        hintColor ??
        theme.inputDecorationTheme.hintStyle?.color ??
        AppColors.grey200;
    final effectiveBorderColor =
        borderColor ??
        theme.inputDecorationTheme.enabledBorder?.borderSide.color ??
        AppColors.grey100;
    final effectiveFocusedBorderColor =
        focusedBorderColor ??
        theme.inputDecorationTheme.focusedBorder?.borderSide.color ??
        AppColors.primary;
    final effectiveErrorBorderColor =
        errorBorderColor ??
        theme.inputDecorationTheme.errorBorder?.borderSide.color ??
        AppColors.red;
    final effectiveTextColor =
        textColor ?? theme.textTheme.bodyLarge?.color ?? AppColors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && labelPosition == LabelPosition.above) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label!,
                style:
                    labelStyle ??
                    TextStyle(
                      color: effectiveLabelColor,
                      fontSize: _labelFontSize,
                      fontWeight: labelFontWeight ?? FontWeight.w500,
                    ),
              ),
              if (isRequired)
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: requiredIndicatorColor ?? AppColors.red,
                      fontSize: _labelFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: _labelSpacing),
        ],
        SizedBox(
          height: height ?? context.inputHeight,
          child: IntlPhoneField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: effectiveHintColor),
              filled: true,
              fillColor: !enabled
                  ? (theme.brightness == Brightness.dark
                      ? AppColors.grey800.withValues(alpha: 0.5)
                      : AppColors.grey100)
                  : (backgroundColor ??
                      theme.inputDecorationTheme.fillColor ??
                      AppColors.white),
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_borderRadius ?? 4.0),
                borderSide: BorderSide(
                  color: effectiveBorderColor,
                  width: _borderWidth ?? 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_borderRadius ?? 4.0),
                borderSide: BorderSide(
                  color: effectiveBorderColor,
                  width: _borderWidth ?? 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_borderRadius ?? 4.0),
                borderSide: BorderSide(
                  color: effectiveFocusedBorderColor,
                  width: _borderWidth ?? 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_borderRadius ?? 4.0),
                borderSide: BorderSide(
                  color: effectiveErrorBorderColor,
                  width: _borderWidth ?? 1.0,
                ),
              ),
            ),
            initialCountryCode: initialCountryCode,
            onChanged: onChanged,
            onCountryChanged: onCountryChanged != null
                ? (country) => onCountryChanged!(country.code)
                : null,
            validator: validator,
            cursorColor:
                cursorColor ??
                theme.textSelectionTheme.cursorColor ??
                AppColors.primary,
            style: TextStyle(color: effectiveTextColor),
            showDropdownIcon: showDropdownIcon,
            dropdownIconPosition: IconPosition.trailing,
            dropdownIcon: Icon(
              Icons.arrow_drop_down,
              color: dropdownIconColor ?? AppColors.grey,
            ),
            flagsButtonPadding: EdgeInsets.only(left: 12.w),
            showCountryFlag: showCountryFlag,
            enabled: enabled,
            readOnly: readOnly,
            invalidNumberMessage: invalidNumberMessage ?? 'Invalid phone number',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }
}

/// Multiline text field for longer text input
class AppMultiLineTextField extends StatelessWidget {
  const AppMultiLineTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.labelPosition = LabelPosition.above,
    this.fieldStyle = TextFieldStyle.outlined,
    this.minLines = 3,
    this.maxLines = 10,
    this.maxLength,
    this.showCounter = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.enabled = true,
    this.readOnly = false,
    this.isRequired = false,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.contentPadding,
    this.labelFontSize,
    this.fontSize,
    this.hintFontSize,
    this.enableSecurity,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final LabelPosition labelPosition;
  final TextFieldStyle fieldStyle;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool showCounter;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool enabled;
  final bool readOnly;
  final bool isRequired;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? labelFontSize;
  final double? fontSize;
  final double? hintFontSize;
  final bool? enableSecurity;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helperText: helperText,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      labelPosition: labelPosition,
      fieldStyle: fieldStyle,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      showCounter: showCounter,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      readOnly: readOnly,
      isRequired: isRequired,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      backgroundColor: backgroundColor,
      contentPadding:
          contentPadding ??
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      labelFontSize: labelFontSize,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      enableSecurity: enableSecurity,
    );
  }
}

/// Rounded/pill shaped text field for search and modern UIs
class AppRoundedTextField extends StatelessWidget {
  const AppRoundedTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.prefixIconData,
    this.suffixIconData,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
    this.fontSize,
    this.hintFontSize,
    this.iconSize,
    this.height,
    this.contentPadding,
    this.isPill = true,
    this.showBorder = false,
    this.enableSecurity,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final bool showPasswordToggle;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;
  final double? fontSize;
  final double? hintFontSize;
  final double? iconSize;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final bool isPill;
  final bool showBorder;
  final bool? enableSecurity;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      hint: hint,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      prefixIconData: prefixIconData,
      suffixIconData: suffixIconData,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      obscureText: obscureText,
      showPasswordToggle: showPasswordToggle,
      fieldStyle: isPill ? TextFieldStyle.pill : TextFieldStyle.rounded,
      backgroundColor:
          backgroundColor ??
          (Theme.of(context).inputDecorationTheme.fillColor ??
              (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.grey800
                  : AppColors.white)),
      borderColor: showBorder
          ? (borderColor ??
                (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.grey700
                    : AppColors.grey200))
          : Colors.transparent,
      focusedBorderColor: showBorder
          ? (focusedBorderColor ?? AppColors.primary)
          : Colors.transparent,
      cursorColor: cursorColor,
      textColor: textColor,
      hintColor: hintColor,
      iconColor: iconColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      prefixIconSize: iconSize,
      suffixIconSize: iconSize,
      height: height,
      contentPadding: contentPadding,
      labelPosition: LabelPosition.inside,
      enableSecurity: enableSecurity,
    );
  }
}

/// Simple text field without label - backwards compatibility wrapper
class NormalAppTextFormField extends StatelessWidget {
  const NormalAppTextFormField({
    super.key,
    this.obscureText = false,
    this.controller,
    this.hint,
    this.label,
    this.keyboardType,
    this.fontsize,
    this.validator,
    this.onSaved,
    this.color,
    this.bordercolor,
  });

  final bool obscureText;
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Function? onSaved;
  final Color? color;
  final Color? bordercolor;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved as void Function(String?)?,
      backgroundColor: color,
      borderColor: bordercolor,
      focusedBorderColor: bordercolor,
      fontSize: fontsize,
      fieldStyle: TextFieldStyle.outlined,
      labelPosition: LabelPosition.above,
    );
  }
}

/// Bio/message text field - backwards compatibility wrapper
class BioField extends StatelessWidget {
  const BioField({
    super.key,
    this.controller,
    this.label,
    this.fontsize,
    this.validator,
    this.hint,
    this.bordercolor,
    this.minLines = 3,
    this.maxLines = 10,
  });

  final TextEditingController? controller;
  final double? fontsize;
  final FormFieldValidator<String>? validator;
  final String? label;
  final String? hint;
  final Color? bordercolor;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return AppMultiLineTextField(
      controller: controller,
      label: label,
      hint: hint ?? 'Send us a message',
      validator: validator,
      borderColor: bordercolor,
      focusedBorderColor: bordercolor ?? AppColors.primary,
      fontSize: fontsize,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
