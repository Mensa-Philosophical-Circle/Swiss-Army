import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.prefixIcon,
    this.isLoading = false,
    this.validator,
    this.onSaved,
    this.fieldStyle = TextFieldStyle.outlined,
    this.labelPosition = LabelPosition.above,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.height,
    this.enabled = true,
  });

  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final bool isLoading;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;
  final TextFieldStyle fieldStyle;
  final LabelPosition labelPosition;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final bool enabled;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  Color get _borderColor {
    if (_hasError) {
      return Theme.of(context).colorScheme.error;
    }
    if (_isFocused) {
      return widget.borderColor ?? Theme.of(context).primaryColor;
    }
    return widget.borderColor ??
        Theme.of(
          context,
        ).inputDecorationTheme.enabledBorder?.borderSide.color ??
        AppColors.grey100;
  }

  Color get _backgroundColor {
    if (!widget.enabled) {
      return Theme.of(context).disabledColor.withValues(alpha: 0.1);
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

  double get _borderRadius {
    if (widget.borderRadius != null) return widget.borderRadius!;
    switch (widget.fieldStyle) {
      case TextFieldStyle.pill:
        return 50.0;
      case TextFieldStyle.rounded:
        return 20.0;
      case TextFieldStyle.underline:
        return 0;
      case TextFieldStyle.outlined:
      case TextFieldStyle.filled:
        return 12.0;
    }
  }

  InputBorder _getBorder(Color color) {
    if (widget.fieldStyle == TextFieldStyle.underline) {
      return UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
      );
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: widget.fieldStyle == TextFieldStyle.filled
          ? BorderSide.none
          : BorderSide(color: color, width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null &&
            widget.labelPosition == LabelPosition.above) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],

        SizedBox(
          height: widget.height ?? context.inputHeight,
          child: DropdownButtonFormField<T>(
            key: ValueKey(widget.value),
            initialValue: widget.value,
            items: widget.items,
            onChanged: widget.enabled && !widget.isLoading
                ? widget.onChanged
                : null,
            validator: (value) {
              final error = widget.validator?.call(value);
              setState(() => _hasError = error != null);
              return error;
            },
            onSaved: widget.onSaved,
            focusNode: _focusNode,
            icon: widget.isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : null,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: _backgroundColor,
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: widget.hint,
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
              prefixIcon: widget.prefixIcon,
              border: _getBorder(_borderColor),
              enabledBorder: _getBorder(_borderColor),
              focusedBorder: _getBorder(Theme.of(context).primaryColor),
              errorBorder: _getBorder(Theme.of(context).colorScheme.error),
              focusedErrorBorder: _getBorder(Theme.of(context).colorScheme.error),
            ),
            dropdownColor: isDark ? Colors.grey[850] : Colors.white,
          ),
        ),
      ],
    );
  }
}
