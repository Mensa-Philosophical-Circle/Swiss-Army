import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../utils/utils.dart';
import 'textfields.dart';

export 'package:intl_phone_field/countries.dart';
export 'package:intl_phone_field/phone_number.dart';

/// A robust, beautiful phone text field with pixel-perfect country flags.
/// Flags are rendered using high-fidelity asset images bundled in `intl_phone_field`.
class AppPhoneTextField extends StatefulWidget {
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
    this.height,
    this.contentPadding,
    this.phoneValidator,
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
  final String? Function(String?)? phoneValidator;

  @override
  State<AppPhoneTextField> createState() => _AppPhoneTextFieldState();
}

class _AppPhoneTextFieldState extends State<AppPhoneTextField> {
  late Country _selectedCountry;
  late TextEditingController _effectiveController;

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController();
    _selectedCountry = countries.firstWhere(
      (c) => c.code.toUpperCase() == widget.initialCountryCode.toUpperCase(),
      orElse: () => countries.firstWhere(
        (c) => c.code == 'NG',
        orElse: () => countries.first,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AppPhoneTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null && widget.controller != _effectiveController) {
      _effectiveController = widget.controller!;
    }
  }

  void _onNumberChanged(String val) {
    final pn = PhoneNumber(
      countryISOCode: _selectedCountry.code,
      countryCode: '+${_selectedCountry.dialCode}',
      number: val,
    );
    widget.onChanged?.call(pn);
  }

  void _showCountryPicker(BuildContext context) {
    if (!widget.enabled || widget.readOnly) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _CountryPickerSheet(
        selectedCode: _selectedCountry.code,
        onSelect: (Country country) {
          setState(() {
            _selectedCountry = country;
          });
          widget.onCountryChanged?.call(country.code);
          _onNumberChanged(_effectiveController.text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLabelColor = widget.labelColor ??
        theme.inputDecorationTheme.labelStyle?.color ??
        AppColors.black;
    final effectiveHintColor = widget.hintColor ??
        theme.inputDecorationTheme.hintStyle?.color ??
        AppColors.grey200;
    final effectiveBorderColor = widget.borderColor ??
        theme.inputDecorationTheme.enabledBorder?.borderSide.color ??
        AppColors.grey100;
    final effectiveFocusedBorderColor = widget.focusedBorderColor ??
        theme.inputDecorationTheme.focusedBorder?.borderSide.color ??
        AppColors.primary;
    final effectiveErrorBorderColor = widget.errorBorderColor ??
        theme.inputDecorationTheme.errorBorder?.borderSide.color ??
        AppColors.red;
    final effectiveTextColor =
        widget.textColor ?? theme.textTheme.bodyLarge?.color ?? AppColors.black;
    final effectiveRadius = widget.borderRadius ?? 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null && widget.labelPosition == LabelPosition.above) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label!,
                style: widget.labelStyle ??
                    TextStyle(
                      color: effectiveLabelColor,
                      fontSize: (widget.labelFontSize ?? 14.0).sp,
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
                      fontSize: (widget.labelFontSize ?? 14.0).sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: (widget.labelSpacing ?? 8.0).h),
        ],
        TextFormField(
          controller: _effectiveController,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s\-]+$')),
          ],
          cursorColor: widget.cursorColor ??
              theme.textSelectionTheme.cursorColor ??
              AppColors.primary,
          cursorHeight: 20.h,
          style: TextStyle(
            color: effectiveTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          onChanged: _onNumberChanged,
          validator: (value) {
            final complete = '+${_selectedCountry.dialCode}${value ?? ''}';
            if (widget.phoneValidator != null) {
              return widget.phoneValidator!(complete);
            }
            if (widget.validator != null) {
              final pn = PhoneNumber(
                countryISOCode: _selectedCountry.code,
                countryCode: '+${_selectedCountry.dialCode}',
                number: value ?? '',
              );
              return widget.validator!(pn);
            }
            if (value != null && value.isNotEmpty) {
              final digits = value.replaceAll(RegExp(r'\D'), '');
              if (digits.length < _selectedCountry.minLength ||
                  digits.length > _selectedCountry.maxLength) {
                return widget.invalidNumberMessage ?? 'Invalid phone number';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: effectiveHintColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            isDense: false,
            counterText: '',
            fillColor: !widget.enabled
                ? (theme.brightness == Brightness.dark
                    ? AppColors.grey800.withValues(alpha: 0.5)
                    : AppColors.grey100)
                : (widget.backgroundColor ??
                    (theme.brightness == Brightness.light
                        ? AppColors.white
                        : (theme.inputDecorationTheme.fillColor ??
                            AppColors.white))),
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(effectiveRadius),
              borderSide: BorderSide(
                color: effectiveBorderColor,
                width: widget.borderWidth ?? 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(effectiveRadius),
              borderSide: BorderSide(
                color: effectiveBorderColor,
                width: widget.borderWidth ?? 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(effectiveRadius),
              borderSide: BorderSide(
                color: effectiveFocusedBorderColor,
                width: widget.borderWidth ?? 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(effectiveRadius),
              borderSide: BorderSide(
                color: effectiveErrorBorderColor,
                width: widget.borderWidth ?? 1.0,
              ),
            ),
            prefixIcon: InkWell(
              onTap: () => _showCountryPicker(context),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(effectiveRadius),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showCountryFlag) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3.r),
                        child: Image.asset(
                          'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                          package: 'intl_phone_field',
                          width: 24.w,
                          height: 16.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Text(
                            _selectedCountry.flag,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      '+${_selectedCountry.dialCode}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: effectiveTextColor,
                      ),
                    ),
                    if (widget.showDropdownIcon) ...[
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 20.sp,
                        color: widget.dropdownIconColor ?? AppColors.grey,
                      ),
                    ],
                    SizedBox(width: 6.w),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet({
    required this.selectedCode,
    required this.onSelect,
  });

  final String selectedCode;
  final ValueChanged<Country> onSelect;

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  late List<Country> _filtered;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = List.of(countries);
  }

  void _filter(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filtered = List.of(countries);
      } else {
        _filtered = countries.where((c) {
          return c.name.toLowerCase().contains(query) ||
              c.dialCode.contains(query) ||
              c.code.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _filter,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search country or code...',
                filled: true,
                fillColor: theme.brightness == Brightness.light
                    ? Colors.grey.shade100
                    : Colors.grey.shade900,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final c = _filtered[index];
                final isSelected =
                    c.code.toUpperCase() == widget.selectedCode.toUpperCase();
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: Image.asset(
                      'assets/flags/${c.code.toLowerCase()}.png',
                      package: 'intl_phone_field',
                      width: 28.w,
                      height: 18.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Text(
                        c.flag,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ),
                  title: Text(
                    c.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    '+${c.dialCode}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppColors.primary : Colors.grey,
                    ),
                  ),
                  onTap: () {
                    widget.onSelect(c);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
