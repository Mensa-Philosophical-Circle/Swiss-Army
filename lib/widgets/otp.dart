import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../utils/utils.dart';

/// A highly customizable OTP/PIN input field with extensive configuration options.
///
/// Features:
/// - Multiple style presets (boxed, underline, filled, circle, rounded)
/// - Configurable length (4, 5, 6, or custom)
/// - Error state with shake animation
/// - Success state styling
/// - Obscure text option for PIN entry
/// - Auto-submit on completion
/// - Haptic feedback
/// - Resend timer functionality
/// - Full accessibility support
/// - Custom cursor and animations
///
/// Example usage:
/// ```dart
/// OTPTextField(
///   length: 6,
///   style: OTPStyle.boxed,
///   onCompleted: (pin) => verifyOTP(pin),
///   onChanged: (value) => print(value),
///   autoSubmit: true,
///   hapticFeedback: true,
/// )
/// ```
///
/// OTP input style variants
enum OTPStyle { boxed, underline, filled, circle, rounded }

/// Animation types for OTP input
enum OTPAnimationType { none, scale, slide, fade, rotation }

class OTPTextField extends StatefulWidget {
  const OTPTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    this.onChanged,
    this.onSubmitted,
    this.length = 6,
    this.style = OTPStyle.boxed,
    this.animationType = OTPAnimationType.slide,
    this.pinWidth,
    this.pinHeight,
    this.spacing,
    this.borderRadius,
    this.borderWidth = 1.5,
    this.defaultBorderColor,
    this.focusedBorderColor,
    this.submittedBorderColor,
    this.errorBorderColor,
    this.successBorderColor,
    this.fillColor,
    this.focusedFillColor,
    this.submittedFillColor,
    this.errorFillColor,
    this.successFillColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textStyle,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.obscuringWidget,
    this.showCursor = true,
    this.cursorColor,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.cursor,
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.done,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableSuggestions = false,
    this.useNativeKeyboard = true,
    this.hapticFeedback = true,
    this.autoSubmit = false,
    this.closeKeyboardOnComplete = true,
    this.validator,
    this.errorText,
    this.hasError = false,
    this.isSuccess = false,
    this.errorAnimationDuration = const Duration(milliseconds: 300),
    this.showErrorAnimation = true,
    this.inputFormatters,
    this.autofillHints,
    this.enableIMEPersonalizedLearning = false,
    this.contextMenuBuilder,
    this.onTap,
    this.onLongPress,
    this.onTapOutside,
    this.mouseCursor,
    this.forceErrorState = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.pinContentAlignment = Alignment.center,
    this.separatorBuilder,
    this.preFilledWidget,
    this.followingPinTheme,
    this.disabledPinTheme,
    this.errorPinTheme,
    this.semanticLabel,
    this.enableSecurity,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int length;
  final OTPStyle style;
  final OTPAnimationType animationType;
  // ============== Size Configuration ==============
  final double? pinWidth;
  final double? pinHeight;
  final double? spacing;
  final double? borderRadius;
  final double borderWidth;
  // ============== Color Configuration ==============
  final Color? defaultBorderColor;
  final Color? focusedBorderColor;
  final Color? submittedBorderColor;
  final Color? errorBorderColor;
  final Color? successBorderColor;
  final Color? fillColor;
  final Color? focusedFillColor;
  final Color? submittedFillColor;
  final Color? errorFillColor;
  final Color? successFillColor;
  // ============== Text Configuration ==============
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextStyle? textStyle;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;
  // ============== Cursor Configuration ==============
  final bool showCursor;
  final Color? cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final Widget? cursor;
  // ============== Keyboard Configuration ==============
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final bool enableSuggestions;
  final bool useNativeKeyboard;
  // ============== Behavior Configuration ==============
  final bool hapticFeedback;
  final bool autoSubmit;
  final bool closeKeyboardOnComplete;
  // ============== Validation Configuration ==============
  final String? Function(String?)? validator;
  final String? errorText;
  final bool hasError;
  final bool isSuccess;
  final Duration errorAnimationDuration;
  final bool showErrorAnimation;
  final bool forceErrorState;
  // ============== Input Configuration ==============
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool enableIMEPersonalizedLearning;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  // ============== Interaction Configuration ==============
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final void Function(PointerDownEvent)? onTapOutside;
  final MouseCursor? mouseCursor;
  // ============== Layout Configuration ==============
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final AlignmentGeometry pinContentAlignment;
  final Widget Function(int index)? separatorBuilder;
  final Widget? preFilledWidget;
  // ============== Theme Configuration ==============
  final PinTheme? followingPinTheme;
  final PinTheme? disabledPinTheme;
  final PinTheme? errorPinTheme;
  final String? semanticLabel;
  final bool? enableSecurity;

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: widget.errorAnimationDuration,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void didUpdateWidget(OTPTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !oldWidget.hasError && widget.showErrorAnimation) {
      _triggerShake();
    }
  }

  void _triggerShake() {
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  PinAnimationType get _pinAnimationType {
    switch (widget.animationType) {
      case OTPAnimationType.none:
        return PinAnimationType.none;
      case OTPAnimationType.scale:
        return PinAnimationType.scale;
      case OTPAnimationType.slide:
        return PinAnimationType.slide;
      case OTPAnimationType.fade:
        return PinAnimationType.fade;
      case OTPAnimationType.rotation:
        return PinAnimationType.rotation;
    }
  }

  double get _pinWidth => validatePinSize(
    widget.pinWidth,
    defaultValue: 56.w,
    enableSecurity: widget.enableSecurity,
  );
  double get _pinHeight => validatePinSize(
    widget.pinHeight,
    defaultValue: 56.h,
    enableSecurity: widget.enableSecurity,
  );
  double get _fontSize => validateOTPFontSize(
    widget.fontSize,
    defaultValue: 20.sp,
    enableSecurity: widget.enableSecurity,
  );
  double get _borderRadius => validateOTPBorderRadius(
    widget.borderRadius,
    defaultValue: _getDefaultBorderRadius(),
    enableSecurity: widget.enableSecurity,
  );

  double _getDefaultBorderRadius() {
    switch (widget.style) {
      case OTPStyle.circle:
        return _pinWidth / 2;
      case OTPStyle.underline:
        return 0;
      case OTPStyle.rounded:
        return 20;
      case OTPStyle.boxed:
      case OTPStyle.filled:
        return 12;
    }
  }

  Color _defaultBorderColor(BuildContext context) =>
      widget.defaultBorderColor ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);
  Color _focusedBorderColor(BuildContext context) =>
      widget.focusedBorderColor ?? Theme.of(context).colorScheme.primary;
  Color _submittedBorderColor(BuildContext context) =>
      widget.submittedBorderColor ?? Theme.of(context).colorScheme.primary;
  Color _errorBorderColor(BuildContext context) => widget.errorBorderColor ?? Theme.of(context).colorScheme.error;
  Color _successBorderColor(BuildContext context) => widget.successBorderColor ?? Colors.green;
  Color _textColor(BuildContext context) => widget.textColor ?? Theme.of(context).colorScheme.primary;
  Color _cursorColor(BuildContext context) => widget.cursorColor ?? Theme.of(context).colorScheme.primary;

  Color? _fillColor(BuildContext context) {
    if (widget.hasError || widget.forceErrorState) {
      return widget.errorFillColor ?? Theme.of(context).colorScheme.error.withValues(alpha: 0.1);
    }
    if (widget.isSuccess) {
      return widget.successFillColor ?? Colors.green.withValues(alpha: 0.1);
    }
    return widget.fillColor;
  }

  Color _getCurrentBorderColor(BuildContext context) {
    if (widget.hasError || widget.forceErrorState) {
      return _errorBorderColor(context);
    }
    if (widget.isSuccess) {
      return _successBorderColor(context);
    }
    return _defaultBorderColor(context);
  }

  BoxDecoration _getDefaultDecoration(BuildContext context) {
    final borderColor = _getCurrentBorderColor(context);

    switch (widget.style) {
      case OTPStyle.boxed:
        return BoxDecoration(
          border: Border.all(color: borderColor, width: widget.borderWidth),
          borderRadius: BorderRadius.circular(_borderRadius),
          color: _fillColor(context),
        );

      case OTPStyle.underline:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(color: borderColor, width: widget.borderWidth),
          ),
          color: _fillColor(context),
        );

      case OTPStyle.filled:
        return BoxDecoration(
          color: _fillColor(context) ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: borderColor.withValues(alpha: 0.3),
            width: widget.borderWidth,
          ),
        );

      case OTPStyle.circle:
        return BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: widget.borderWidth),
          color: _fillColor(context),
        );

      case OTPStyle.rounded:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: _fillColor(context) ?? Colors.white,
          border: Border.all(color: borderColor, width: widget.borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        );
    }
  }

  BoxDecoration _getFocusedDecoration(BuildContext context) {
    final focusColor = widget.hasError || widget.forceErrorState
        ? _errorBorderColor(context)
        : widget.isSuccess
        ? _successBorderColor(context)
        : _focusedBorderColor(context);

    switch (widget.style) {
      case OTPStyle.boxed:
        return BoxDecoration(
          border: Border.all(color: focusColor, width: widget.borderWidth + 1),
          borderRadius: BorderRadius.circular(_borderRadius),
          color: widget.focusedFillColor ?? _fillColor(context),
        );

      case OTPStyle.underline:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: focusColor,
              width: widget.borderWidth + 1,
            ),
          ),
          color: widget.focusedFillColor ?? _fillColor(context),
        );

      case OTPStyle.filled:
        return BoxDecoration(
          color:
              widget.focusedFillColor ??
              _fillColor(context) ??
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: focusColor, width: widget.borderWidth + 1),
        );

      case OTPStyle.circle:
        return BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: focusColor, width: widget.borderWidth + 1),
          color: widget.focusedFillColor ?? _fillColor(context),
        );

      case OTPStyle.rounded:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: widget.focusedFillColor ?? _fillColor(context) ?? Colors.white,
          border: Border.all(color: focusColor, width: widget.borderWidth + 1),
          boxShadow: [
            BoxShadow(
              color: focusColor.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
    }
  }

  BoxDecoration _getSubmittedDecoration(BuildContext context) {
    final submittedColor = widget.hasError || widget.forceErrorState
        ? _errorBorderColor(context)
        : widget.isSuccess
        ? _successBorderColor(context)
        : _submittedBorderColor(context);

    switch (widget.style) {
      case OTPStyle.boxed:
        return BoxDecoration(
          border: Border.all(color: submittedColor, width: widget.borderWidth),
          borderRadius: BorderRadius.circular(_borderRadius),
          color: widget.submittedFillColor ?? _fillColor(context),
        );

      case OTPStyle.underline:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: submittedColor,
              width: widget.borderWidth,
            ),
          ),
          color: widget.submittedFillColor ?? _fillColor(context),
        );

      case OTPStyle.filled:
        return BoxDecoration(
          color:
              widget.submittedFillColor ??
              _fillColor(context) ??
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: submittedColor, width: widget.borderWidth),
        );

      case OTPStyle.circle:
        return BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: submittedColor, width: widget.borderWidth),
          color: widget.submittedFillColor ?? _fillColor(context),
        );

      case OTPStyle.rounded:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: widget.submittedFillColor ?? _fillColor(context) ?? Colors.white,
          border: Border.all(color: submittedColor, width: widget.borderWidth),
          boxShadow: [
            BoxShadow(
              color: submittedColor.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        );
    }
  }

  TextStyle _textStyle(BuildContext context) {
    return widget.textStyle ??
        TextStyle(
          fontSize: _fontSize,
          color: _textColor(context),
          fontWeight: widget.fontWeight ?? FontWeight.w600,
          fontFamily: widget.fontFamily,
        );
  }

  Widget _buildCursor(BuildContext context) {
    if (widget.cursor != null) return widget.cursor!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: widget.cursorWidth,
          height: widget.cursorHeight ?? _fontSize * 1.2,
          decoration: BoxDecoration(
            color: _cursorColor(context),
            borderRadius: BorderRadius.circular(widget.cursorWidth / 2),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  void _handleCompleted(String pin) {
    if (widget.hapticFeedback) {
      HapticFeedback.mediumImpact();
    }

    if (widget.closeKeyboardOnComplete) {
      FocusScope.of(context).unfocus();
    }

    widget.onCompleted?.call(pin);

    if (widget.autoSubmit) {
      widget.onSubmitted?.call(pin);
    }
  }

  void _handleChanged(String value) {
    if (widget.hapticFeedback && value.isNotEmpty) {
      HapticFeedback.selectionClick();
    }
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: _pinWidth,
      height: _pinHeight,
      textStyle: _textStyle(context),
      decoration: _getDefaultDecoration(context),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(
        horizontal: validateOTPSpacing(
          widget.spacing,
          defaultValue: 4.w,
          enableSecurity: widget.enableSecurity,
        ),
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: _getFocusedDecoration(context),
    );

    final submittedTheme = defaultTheme.copyWith(
      decoration: _getSubmittedDecoration(context),
    );

    final errorTheme =
        widget.errorPinTheme ??
        defaultTheme.copyWith(
          decoration: BoxDecoration(
            border: Border.all(color: _errorBorderColor(context), width: 2),
            borderRadius: BorderRadius.circular(_borderRadius),
            color: _errorBorderColor(context).withValues(alpha: 0.1),
          ),
        );

    final pinput = Pinput(
      length: validateOTPLength(
        widget.length,
        defaultValue: 6,
        enableSecurity: widget.enableSecurity,
      ),
      controller: widget.controller,
      focusNode: widget.focusNode,
      defaultPinTheme: defaultTheme,
      focusedPinTheme: focusedTheme,
      submittedPinTheme: submittedTheme,
      followingPinTheme: widget.followingPinTheme ?? defaultTheme,
      disabledPinTheme: widget.disabledPinTheme,
      errorPinTheme: widget.hasError || widget.forceErrorState
          ? errorTheme
          : null,
      forceErrorState: widget.forceErrorState,
      pinAnimationType: _pinAnimationType,
      showCursor: widget.showCursor,
      cursor: _buildCursor(context),
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      obscuringWidget: widget.obscuringWidget,
      keyboardType: widget.useNativeKeyboard
          ? widget.keyboardType
          : TextInputType.none,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      enableSuggestions: widget.enableSuggestions,
      onCompleted: _handleCompleted,
      onChanged: _handleChanged,
      onSubmitted: widget.onSubmitted,
      validator: widget.validator,
      errorText: widget.errorText,
      inputFormatters: widget.inputFormatters ?? const [],
      autofillHints: widget.autofillHints,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      contextMenuBuilder: widget.contextMenuBuilder,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapOutside: widget.onTapOutside,
      mouseCursor: widget.mouseCursor,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      pinContentAlignment: widget.pinContentAlignment,
      separatorBuilder: widget.separatorBuilder,
      preFilledWidget: widget.preFilledWidget,
    );

    Widget child = AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            widget.showErrorAnimation &&
                    (widget.hasError || widget.forceErrorState)
                ? _shakeAnimation.value *
                      ((_shakeController.value * 10).toInt().isEven ? 1 : -1)
                : 0,
            0,
          ),
          child: child,
        );
      },
      child: pinput,
    );

    if (widget.semanticLabel != null) {
      child = Semantics(
        label: widget.semanticLabel,
        textField: true,
        child: child,
      );
    }

    return child;
  }
}

/// A complete OTP verification widget with resend timer and visual feedback.
///
/// Includes:
/// - OTP input field
/// - Resend code timer
/// - Loading state
/// - Error/success states
/// - Custom styling
class OTPVerificationWidget extends StatefulWidget {
  const OTPVerificationWidget({
    super.key,
    required this.onVerify,
    this.onResend,
    this.length = 6,
    this.style = OTPStyle.boxed,
    this.resendDuration = const Duration(seconds: 60),
    this.title,
    this.subtitle,
    this.resendText = 'Resend code',
    this.resendingText = 'Sending...',
    this.titleStyle,
    this.subtitleStyle,
    this.resendTextStyle,
    this.timerTextStyle,
    this.otpController,
    this.autoFocus = true,
    this.closeKeyboardOnVerify = true,
    this.showResendButton = true,
    this.spacing = 16.0,
    this.pinWidth,
    this.pinHeight,
    this.errorText,
    this.successText,
    this.isLoading = false,
    this.loadingWidget,
    this.enabled = true,
  });
  final Future<bool> Function(String otp) onVerify;
  final Future<void> Function()? onResend;
  final int length;
  final OTPStyle style;
  final Duration resendDuration;
  final String? title;
  final String? subtitle;
  final String resendText;
  final String resendingText;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? resendTextStyle;
  final TextStyle? timerTextStyle;
  final TextEditingController? otpController;
  final bool autoFocus;
  final bool closeKeyboardOnVerify;
  final bool showResendButton;
  final double spacing;
  final double? pinWidth;
  final double? pinHeight;
  final String? errorText;
  final String? successText;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool enabled;

  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  late TextEditingController _controller;
  Timer? _resendTimer;
  int _remainingSeconds = 0;
  bool _isResending = false;
  bool _hasError = false;
  bool _isSuccess = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.otpController ?? TextEditingController();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    if (widget.otpController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    _remainingSeconds = widget.resendDuration.inSeconds;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds / 60).floor();
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _handleVerify(String otp) async {
    if (_isVerifying) return;

    setState(() {
      _isVerifying = true;
      _hasError = false;
      _isSuccess = false;
    });

    try {
      final result = await widget.onVerify(otp);
      if (mounted) {
        setState(() {
          _isSuccess = result;
          _hasError = !result;
          _isVerifying = false;
        });

        if (!result) {
          _controller.clear();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isVerifying = false;
        });
        _controller.clear();
      }
    }
  }

  Future<void> _handleResend() async {
    if (_remainingSeconds > 0 || _isResending || widget.onResend == null) {
      return;
    }

    setState(() => _isResending = true);

    try {
      await widget.onResend!();
      if (mounted) {
        _controller.clear();
        _startResendTimer();
        setState(() {
          _isResending = false;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading || _isVerifying;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style:
                widget.titleStyle ??
                TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: widget.spacing / 2),
        ],

        if (widget.subtitle != null) ...[
          Text(
            widget.subtitle!,
            style:
                widget.subtitleStyle ??
                TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: widget.spacing),
        ],

        // OTP Field
        Stack(
          alignment: Alignment.center,
          children: [
            OTPTextField(
              controller: _controller,
              length: widget.length,
              style: widget.style,
              pinWidth: widget.pinWidth,
              pinHeight: widget.pinHeight,
              onCompleted: _handleVerify,
              hasError: _hasError || widget.errorText != null,
              isSuccess: _isSuccess || widget.successText != null,
              autofocus: widget.autoFocus,
              enabled: widget.enabled && !isLoading,
              closeKeyboardOnComplete: widget.closeKeyboardOnVerify,
              hapticFeedback: true,
              showErrorAnimation: true,
            ),
            if (isLoading)
              Container(
                color: Colors.white.withValues(alpha: 0.7),
                child:
                    widget.loadingWidget ?? const CircularProgressIndicator(),
              ),
          ],
        ),

        // Error/Success Text
        if (widget.errorText != null || _hasError) ...[
          SizedBox(height: widget.spacing / 2),
          Text(
            widget.errorText ?? 'Invalid code. Please try again.',
            style: TextStyle(fontSize: 12.sp, color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ],

        if (widget.successText != null || _isSuccess) ...[
          SizedBox(height: widget.spacing / 2),
          Text(
            widget.successText ?? 'Verification successful!',
            style: TextStyle(fontSize: 12.sp, color: Colors.green),
            textAlign: TextAlign.center,
          ),
        ],

        // Resend Section
        if (widget.showResendButton && widget.onResend != null) ...[
          SizedBox(height: widget.spacing),
          if (_remainingSeconds > 0)
            Text(
              'Resend code in $_formattedTime',
              style:
                  widget.timerTextStyle ??
                  TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            )
          else
            GestureDetector(
              onTap: _handleResend,
              child: Text(
                _isResending ? widget.resendingText : widget.resendText,
                style:
                    widget.resendTextStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      color: _isResending ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6) : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      decoration: _isResending
                          ? null
                          : TextDecoration.underline,
                    ),
              ),
            ),
        ],
      ],
    );
  }
}

/// Helper class to disable keyboard focus
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
