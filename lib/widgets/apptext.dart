import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

/// Text style preset variants
enum AppTextStyle { small, medium, large, heading, display, caption, label }

/// Text decoration style variants
enum AppTextDecoration { none, underline, lineThrough, overline }

/// A highly customizable text widget with extensive configuration options.
///
/// Features:
/// - Multiple style presets (small, medium, large, heading, display, caption, label)
/// - Full typography customization
/// - Text decorations (underline, strikethrough, etc.)
/// - Gradient text support
/// - Selectable text option
/// - Tap gestures with callbacks
/// - Rich text with highlighted portions
/// - Security validation
///
/// Example usage:
/// ```dart
/// AppText(
///   'Hello World',
///   style: AppTextStyle.heading,
///   color: AppColors.primary,
///   fontWeight: FontWeight.bold,
///   gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
/// )
/// ```
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    // ============== Style Configuration ==============
    this.style = AppTextStyle.medium,
    this.textStyle,
    // ============== Color Configuration ==============
    this.color,
    this.backgroundColor,
    this.decorationColor,
    this.gradient,
    // ============== Typography Configuration ==============
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    // ============== Text Decoration ==============
    this.decoration,
    this.decorationStyle,
    this.decorationThickness,
    // ============== Text Layout ==============
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.softWrap,
    // ============== Shadows ==============
    this.shadows,
    // ============== Interaction ==============
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.selectable = false,
    // ============== Accessibility ==============
    this.semanticsLabel,
    // ============== Security ==============
    this.enableSecurity,
  });

  final String data;
  // ============== Style Configuration ==============
  final AppTextStyle style;
  final TextStyle? textStyle;
  // ============== Color Configuration ==============
  final Color? color;
  final Color? backgroundColor;
  final Color? decorationColor;
  final Gradient? gradient;
  // ============== Typography Configuration ==============
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  // ============== Text Decoration ==============
  final AppTextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  // ============== Text Layout ==============
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  // ============== Shadows ==============
  final List<Shadow>? shadows;
  // ============== Interaction ==============
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final bool selectable;
  // ============== Accessibility ==============
  final String? semanticsLabel;
  // ============== Security ==============
  final bool? enableSecurity;
  // ============== Default Values ==============
  static const double _defaultSmallFontSize = 12.0;
  static const double _defaultMediumFontSize = 14.0;
  static const double _defaultLargeFontSize = 16.0;
  static const double _defaultHeadingFontSize = 20.0;
  static const double _defaultDisplayFontSize = 28.0;
  static const double _defaultCaptionFontSize = 11.0;
  static const double _defaultLabelFontSize = 13.0;

  double _getDefaultFontSize() {
    switch (style) {
      case AppTextStyle.small:
        return _defaultSmallFontSize;
      case AppTextStyle.medium:
        return _defaultMediumFontSize;
      case AppTextStyle.large:
        return _defaultLargeFontSize;
      case AppTextStyle.heading:
        return _defaultHeadingFontSize;
      case AppTextStyle.display:
        return _defaultDisplayFontSize;
      case AppTextStyle.caption:
        return _defaultCaptionFontSize;
      case AppTextStyle.label:
        return _defaultLabelFontSize;
    }
  }

  TextDecoration? _getTextDecoration() {
    if (decoration == null) return null;
    switch (decoration!) {
      case AppTextDecoration.none:
        return TextDecoration.none;
      case AppTextDecoration.underline:
        return TextDecoration.underline;
      case AppTextDecoration.lineThrough:
        return TextDecoration.lineThrough;
      case AppTextDecoration.overline:
        return TextDecoration.overline;
    }
  }

  TextStyle _buildTextStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // 1. Pick base style from Theme based on AppTextStyle enum
    TextStyle baseStyle;
    switch (style) {
      case AppTextStyle.small:
        baseStyle = textTheme.bodySmall ?? const TextStyle(fontSize: 12);
        break;
      case AppTextStyle.medium:
        baseStyle = textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
        break;
      case AppTextStyle.large:
        baseStyle = textTheme.bodyLarge ?? const TextStyle(fontSize: 16);
        break;
      case AppTextStyle.heading:
        baseStyle =
            textTheme.titleLarge ??
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
        break;
      case AppTextStyle.display:
        baseStyle =
            textTheme.displayLarge ??
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
        break;
      case AppTextStyle.caption:
        baseStyle = textTheme.labelSmall ?? const TextStyle(fontSize: 11);
        break;
      case AppTextStyle.label:
        baseStyle = textTheme.labelMedium ?? const TextStyle(fontSize: 13);
        break;
    }

    // 2. Merge User Provided textStyle Prop (Merges on top of Theme)
    TextStyle effectiveStyle = baseStyle.merge(textStyle);

    // 3. Apply Local Property Overrides (Individual props win)
    if (fontFamily != null) {
      effectiveStyle = effectiveStyle.copyWith(fontFamily: fontFamily);
    }

    if (color != null) {
      effectiveStyle = effectiveStyle.copyWith(color: color);
    }

    if (fontSize != null) {
      // We still use validateTextFontSize to enforce security if enabled
      final validatedFontSize = validateTextFontSize(
        fontSize,
        defaultValue: effectiveStyle.fontSize ?? _getDefaultFontSize().sp,
        enableSecurity: enableSecurity,
      );
      effectiveStyle = effectiveStyle.copyWith(fontSize: validatedFontSize);
    }

    if (fontWeight != null) {
      effectiveStyle = effectiveStyle.copyWith(fontWeight: fontWeight);
    }

    if (fontStyle != null) {
      effectiveStyle = effectiveStyle.copyWith(fontStyle: fontStyle);
    }

    if (letterSpacing != null) {
      final validated = validateLetterSpacing(
        letterSpacing,
        enableSecurity: enableSecurity,
      );
      effectiveStyle = effectiveStyle.copyWith(letterSpacing: validated);
    }

    if (wordSpacing != null) {
      final validated = validateWordSpacing(
        wordSpacing,
        enableSecurity: enableSecurity,
      );
      effectiveStyle = effectiveStyle.copyWith(wordSpacing: validated);
    }

    if (height != null) {
      final validated = validateLineHeight(
        height,
        enableSecurity: enableSecurity,
      );
      effectiveStyle = effectiveStyle.copyWith(height: validated);
    }

    if (backgroundColor != null) {
      effectiveStyle = effectiveStyle.copyWith(
        backgroundColor: backgroundColor,
      );
    }

    if (shadows != null) {
      final validated = validateTextShadows(
        shadows,
        enableSecurity: enableSecurity,
      );
      effectiveStyle = effectiveStyle.copyWith(shadows: validated);
    }

    if (decorationColor != null) {
      effectiveStyle = effectiveStyle.copyWith(
        decorationColor: decorationColor,
      );
    }

    if (decorationThickness != null) {
      final validated = validateDecorationThickness(
        decorationThickness,
        enableSecurity: enableSecurity,
      );
      effectiveStyle = effectiveStyle.copyWith(decorationThickness: validated);
    }

    // Decoration (underline, etc.)
    if (decoration != null) {
      effectiveStyle = effectiveStyle.copyWith(
        decoration: _getTextDecoration(),
        decorationStyle: decorationStyle,
      );
    }

    // Gradient handled in build(), but if we want color to be null when gradient is present:
    if (gradient != null) {
      effectiveStyle = effectiveStyle.copyWith(color: null);
    }

    return effectiveStyle;
  }

  @override
  Widget build(BuildContext context) {
    final validatedContent = validateTextContent(
      data,
      enableSecurity: enableSecurity,
    );

    final validatedMaxLines = validateMaxLines(
      maxLines,
      enableSecurity: enableSecurity,
    );

    final textWidget = Text(
      validatedContent,
      style: _buildTextStyle(context),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: validatedMaxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
    );

    Widget result;

    // Apply gradient if specified
    if (gradient != null) {
      result = ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: textWidget,
      );
    } else {
      result = textWidget;
    }

    // Wrap with selectable if needed
    if (selectable) {
      result = SelectableText(
        validatedContent,
        style: _buildTextStyle(context),
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: validatedMaxLines,
        semanticsLabel: semanticsLabel,
        onTap: onTap,
      );
    }

    // Wrap with gesture detector if callbacks are provided
    if (!selectable &&
        (onTap != null || onLongPress != null || onDoubleTap != null)) {
      result = GestureDetector(
        onTap: onTap != null ? () => safeTextCallback(onTap) : null,
        onLongPress: onLongPress != null
            ? () => safeTextCallback(onLongPress)
            : null,
        onDoubleTap: onDoubleTap != null
            ? () => safeTextCallback(onDoubleTap)
            : null,
        child: result,
      );
    }

    return result;
  }
}

/// Convenience widget for small text
class SmallAppText extends StatelessWidget {
  const SmallAppText(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.alignment,
    this.maxLines,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.overflow,
    this.softWrap,
    this.shadows,
    this.onTap,
    this.selectable = false,
    this.textStyle,
    this.backgroundColor,
    this.gradient,
    this.semanticsLabel,
    this.enableSecurity,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final AppTextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final bool? softWrap;
  final List<Shadow>? shadows;
  final VoidCallback? onTap;
  final bool selectable;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Gradient? gradient;
  final String? semanticsLabel;
  final bool? enableSecurity;

  @override
  Widget build(BuildContext context) {
    return AppText(
      data,
      style: AppTextStyle.small,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textAlign: alignment,
      maxLines: maxLines,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      overflow: overflow,
      softWrap: softWrap,
      shadows: shadows,
      onTap: onTap,
      selectable: selectable,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      gradient: gradient,
      semanticsLabel: semanticsLabel,
      enableSecurity: enableSecurity,
    );
  }
}

/// Convenience widget for medium text
class MedAppText extends StatelessWidget {
  const MedAppText(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.alignment,
    this.maxLines,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.overflow,
    this.softWrap,
    this.shadows,
    this.onTap,
    this.selectable = false,
    this.textStyle,
    this.backgroundColor,
    this.gradient,
    this.semanticsLabel,
    this.enableSecurity,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final AppTextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final bool? softWrap;
  final List<Shadow>? shadows;
  final VoidCallback? onTap;
  final bool selectable;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Gradient? gradient;
  final String? semanticsLabel;
  final bool? enableSecurity;

  @override
  Widget build(BuildContext context) {
    return AppText(
      data,
      style: AppTextStyle.medium,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textAlign: alignment,
      maxLines: maxLines,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      overflow: overflow,
      softWrap: softWrap,
      shadows: shadows,
      onTap: onTap,
      selectable: selectable,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      gradient: gradient,
      semanticsLabel: semanticsLabel,
      enableSecurity: enableSecurity,
    );
  }
}

/// Convenience widget for large/big text
class BigAppText extends StatelessWidget {
  const BigAppText(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.alignment,
    this.maxLines,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.overflow,
    this.softWrap,
    this.shadows,
    this.onTap,
    this.selectable = false,
    this.textStyle,
    this.backgroundColor,
    this.gradient,
    this.semanticsLabel,
    this.enableSecurity,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final AppTextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final bool? softWrap;
  final List<Shadow>? shadows;
  final VoidCallback? onTap;
  final bool selectable;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Gradient? gradient;
  final String? semanticsLabel;
  final bool? enableSecurity;

  @override
  Widget build(BuildContext context) {
    return AppText(
      data,
      style: AppTextStyle.large,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textAlign: alignment,
      maxLines: maxLines,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      overflow: overflow,
      softWrap: softWrap,
      shadows: shadows,
      onTap: onTap,
      selectable: selectable,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      gradient: gradient,
      semanticsLabel: semanticsLabel,
      enableSecurity: enableSecurity,
    );
  }
}

/// Supported currency types for price formatting
enum Currency { naira, tl, usd, eur, gbp, jpy, cny, inr, custom }

/// A customizable price/currency text widget with formatting.
///
/// Features:
/// - Multiple currency support
/// - Automatic number formatting with commas
/// - Profit/loss indicators
/// - Decimal control
/// - Full typography customization
///
/// Example:
/// ```dart
/// PriceText(
///   price: '1234567.89',
///   currency: Currency.usd,
///   isProfit: true,
///   showDecimals: true,
/// )
/// ```
class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.price,
    // ============== Currency Configuration ==============
    this.currency = Currency.tl,
    this.customCurrencySymbol,
    this.currencyPosition = CurrencyPosition.before,
    this.currencySpacing,
    // ============== Format Configuration ==============
    this.showDecimals = true,
    this.decimalPlaces = 2,
    this.thousandsSeparator = ',',
    this.decimalSeparator = '.',
    this.isProfit,
    this.compactFormat = false,
    this.maxLength,
    // ============== Style Configuration ==============
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textStyle,
    // ============== Layout Configuration ==============
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.overflow,
    // ============== Profit/Loss Styling ==============
    this.profitColor,
    this.lossColor,
    this.profitPrefix = '+ ',
    this.lossPrefix = '- ',
    this.showProfitLossColors = true,
    // ============== Security ==============
    this.enableSecurity,
  });

  final String price;

  // ============== Currency Configuration ==============
  final Currency currency;
  final String? customCurrencySymbol;
  final CurrencyPosition currencyPosition;
  final double? currencySpacing;

  // ============== Format Configuration ==============
  final bool showDecimals;
  final int decimalPlaces;
  final String thousandsSeparator;
  final String decimalSeparator;
  final bool? isProfit;
  final bool compactFormat;
  final int? maxLength;

  // ============== Style Configuration ==============
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextStyle? textStyle;

  // ============== Layout Configuration ==============
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  // ============== Profit/Loss Styling ==============
  final Color? profitColor;
  final Color? lossColor;
  final String profitPrefix;
  final String lossPrefix;
  final bool showProfitLossColors;

  // ============== Security ==============
  final bool? enableSecurity;

  static const double _defaultFontSize = 16.0;
  static const double _defaultCurrencySpacing = 2.0;
  static const int _defaultMaxLength = 20;

  String get _currencySymbol {
    if (customCurrencySymbol != null) return customCurrencySymbol!;
    switch (currency) {
      case Currency.naira:
        return '₦';
      case Currency.tl:
        return '₺';
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      case Currency.jpy:
        return '¥';
      case Currency.cny:
        return '¥';
      case Currency.inr:
        return '₹';
      case Currency.custom:
        return '';
    }
  }

  String _formatNumber(String priceStr) {
    if (priceStr.isEmpty) return '0';

    double? numPrice = double.tryParse(priceStr);
    if (numPrice == null) return priceStr;

    if (compactFormat) {
      return _formatCompact(numPrice);
    }

    String wholeNumber = numPrice.truncate().abs().toString();
    String decimal = '';

    if (showDecimals) {
      double decimalPart = (numPrice - numPrice.truncate()).abs();
      String decimalStr = decimalPart.toStringAsFixed(decimalPlaces);
      if (decimalStr != '0.${'0' * decimalPlaces}') {
        decimal = decimalSeparator + decimalStr.substring(2);
      }
    }

    // Format with thousands separator
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formatted = wholeNumber.replaceAllMapped(
      reg,
      (Match match) => '${match[1]}$thousandsSeparator',
    );

    return formatted + decimal;
  }

  String _formatCompact(double value) {
    double absValue = value.abs();
    if (absValue >= 1e12) {
      return '${(absValue / 1e12).toStringAsFixed(1)}T';
    } else if (absValue >= 1e9) {
      return '${(absValue / 1e9).toStringAsFixed(1)}B';
    } else if (absValue >= 1e6) {
      return '${(absValue / 1e6).toStringAsFixed(1)}M';
    } else if (absValue >= 1e3) {
      return '${(absValue / 1e3).toStringAsFixed(1)}K';
    }
    return absValue.toStringAsFixed(showDecimals ? decimalPlaces : 0);
  }

  Color? _getColor(BuildContext context) {
    if (isProfit != null && showProfitLossColors) {
      if (isProfit!) {
        return profitColor ?? Colors.green;
      } else {
        return lossColor ?? Theme.of(context).colorScheme.error;
      }
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    String cleanPrice = price.replaceAll(RegExp(r'[+-]'), '').trim();
    String formattedNumber = _formatNumber(cleanPrice);

    String indicator = '';
    if (isProfit != null) {
      indicator = isProfit! ? profitPrefix : lossPrefix;
    }

    final spacing = currencySpacing ?? _defaultCurrencySpacing;
    final spacer = ' ' * (spacing ~/ 2).clamp(1, 3);

    String formattedPrice;
    if (currencyPosition == CurrencyPosition.before) {
      formattedPrice = '$indicator$_currencySymbol$spacer$formattedNumber';
    } else {
      formattedPrice = '$indicator$formattedNumber$spacer$_currencySymbol';
    }

    final effectiveMaxLength = maxLength ?? _defaultMaxLength;
    if (formattedPrice.length > effectiveMaxLength) {
      formattedPrice = '${formattedPrice.substring(0, effectiveMaxLength)}...';
    }

    final validatedFontSize = validateTextFontSize(
      fontSize,
      defaultValue: _defaultFontSize.sp,
      enableSecurity: enableSecurity,
    );

    return Text(
      formattedPrice,
      style:
          textStyle ??
          TextStyle(
            fontSize: validatedFontSize,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: _getColor(context),
          ),
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

/// Currency position relative to the amount
enum CurrencyPosition { before, after }

/// A text widget with strikethrough for showing original/discounted prices.
class SlashedPriceText extends StatelessWidget {
  const SlashedPriceText({
    super.key,
    required this.price,
    this.currency = Currency.tl,
    this.customCurrencySymbol,
    this.currencyPosition = CurrencyPosition.before,
    this.currencySpacing,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textStyle,
    this.decorationColor,
    this.decorationThickness,
    this.decorationStyle,
    this.maxLines = 1,
    this.textAlign,
    this.showDecimals = true,
    this.decimalPlaces = 2,
    this.thousandsSeparator = ',',
    this.enableSecurity,
  });

  final String price;
  final Currency currency;
  final String? customCurrencySymbol;
  final CurrencyPosition currencyPosition;
  final double? currencySpacing;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextStyle? textStyle;
  final Color? decorationColor;
  final double? decorationThickness;
  final TextDecorationStyle? decorationStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool showDecimals;
  final int decimalPlaces;
  final String thousandsSeparator;
  final bool? enableSecurity;

  static const double _defaultFontSize = 14.0;

  String get _currencySymbol {
    if (customCurrencySymbol != null) return customCurrencySymbol!;
    switch (currency) {
      case Currency.naira:
        return '₦';
      case Currency.tl:
        return '₺';
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      case Currency.jpy:
        return '¥';
      case Currency.cny:
        return '¥';
      case Currency.inr:
        return '₹';
      case Currency.custom:
        return '';
    }
  }

  String _formatNumber(String priceStr) {
    if (priceStr.isEmpty) return '0';
    double? numPrice = double.tryParse(priceStr);
    if (numPrice == null) return priceStr;

    String wholeNumber = numPrice.truncate().abs().toString();
    String decimal = '';

    if (showDecimals) {
      double decimalPart = (numPrice - numPrice.truncate()).abs();
      String decimalStr = decimalPart.toStringAsFixed(decimalPlaces);
      if (decimalStr != '0.${'0' * decimalPlaces}') {
        decimal = '.${decimalStr.substring(2)}';
      }
    }

    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formatted = wholeNumber.replaceAllMapped(
      reg,
      (Match match) => '${match[1]}$thousandsSeparator',
    );

    return formatted + decimal;
  }

  @override
  Widget build(BuildContext context) {
    final formattedNumber = _formatNumber(price);
    final spacing = currencySpacing ?? 2.0;
    final spacer = ' ' * (spacing ~/ 2).clamp(1, 3);

    String formattedPrice;
    if (currencyPosition == CurrencyPosition.before) {
      formattedPrice = '$_currencySymbol$spacer$formattedNumber';
    } else {
      formattedPrice = '$formattedNumber$spacer$_currencySymbol';
    }

    final validatedFontSize = validateTextFontSize(
      fontSize,
      defaultValue: _defaultFontSize.sp,
      enableSecurity: enableSecurity,
    );

    return Text(
      formattedPrice,
      style:
          textStyle ??
          TextStyle(
            fontSize: validatedFontSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            decoration: TextDecoration.lineThrough,
            decorationColor: decorationColor ?? color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            decorationThickness: decorationThickness,
            decorationStyle: decorationStyle,
          ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// A text widget for brand names with customizable styling.
class BrandNameText extends StatelessWidget {
  const BrandNameText({
    super.key,
    required this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.size = BrandNameSize.medium,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.textStyle,
    this.letterSpacing,
    this.uppercase = false,
    this.onTap,
    this.enableSecurity,
  });

  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final BrandNameSize size;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final double? letterSpacing;
  final bool uppercase;
  final VoidCallback? onTap;
  final bool? enableSecurity;

  static const double _smallFontSize = 12.0;
  static const double _mediumFontSize = 16.0;
  static const double _largeFontSize = 20.0;

  double _getDefaultFontSize() {
    switch (size) {
      case BrandNameSize.small:
        return _smallFontSize;
      case BrandNameSize.medium:
        return _mediumFontSize;
      case BrandNameSize.large:
        return _largeFontSize;
    }
  }

  FontWeight _getDefaultFontWeight() {
    switch (size) {
      case BrandNameSize.small:
        return FontWeight.w500;
      case BrandNameSize.medium:
        return FontWeight.w600;
      case BrandNameSize.large:
        return FontWeight.bold;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayText = uppercase ? title.toUpperCase() : title;

    final validatedFontSize = validateTextFontSize(
      fontSize,
      defaultValue: _getDefaultFontSize().sp,
      enableSecurity: enableSecurity,
    );

    final validatedLetterSpacing = validateLetterSpacing(
      letterSpacing,
      enableSecurity: enableSecurity,
    );

    Widget textWidget = Text(
      displayText,
      style:
          textStyle ??
          TextStyle(
            fontSize: validatedFontSize,
            fontWeight: fontWeight ?? _getDefaultFontWeight(),
            color: color,
            letterSpacing: validatedLetterSpacing,
          ),
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );

    if (onTap != null) {
      textWidget = GestureDetector(
        onTap: () => safeTextCallback(onTap),
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// Size presets for brand name text
enum BrandNameSize { small, medium, large }

/// A text widget for product titles with customizable styling.
class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.size = ProductTitleSize.medium,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.textStyle,
    this.letterSpacing,
    this.onTap,
    this.enableSecurity,
  });

  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final ProductTitleSize size;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final double? letterSpacing;
  final VoidCallback? onTap;
  final bool? enableSecurity;

  static const double _smallFontSize = 12.0;
  static const double _mediumFontSize = 14.0;
  static const double _largeFontSize = 16.0;

  double _getDefaultFontSize() {
    switch (size) {
      case ProductTitleSize.small:
        return _smallFontSize;
      case ProductTitleSize.medium:
        return _mediumFontSize;
      case ProductTitleSize.large:
        return _largeFontSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    final validatedFontSize = validateTextFontSize(
      fontSize,
      defaultValue: _getDefaultFontSize().sp,
      enableSecurity: enableSecurity,
    );

    final validatedLetterSpacing = validateLetterSpacing(
      letterSpacing,
      enableSecurity: enableSecurity,
    );

    Widget textWidget = Text(
      title,
      style:
          textStyle ??
          TextStyle(
            fontSize: validatedFontSize,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color,
            letterSpacing: validatedLetterSpacing,
          ),
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );

    if (onTap != null) {
      textWidget = GestureDetector(
        onTap: () => safeTextCallback(onTap),
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// Size presets for product title text
enum ProductTitleSize { small, medium, large }

/// A text widget with a required field indicator (asterisk).
class ImportantAppText extends StatelessWidget {
  const ImportantAppText(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.alignment,
    this.maxLines,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.indicatorColor,
    this.indicatorFontSize,
    this.indicatorFontWeight,
    this.indicatorText = '*',
    this.indicatorSpacing,
    this.indicatorPosition = IndicatorPosition.after,
    this.textStyle,
    this.backgroundColor,
    this.semanticsLabel,
    this.enableSecurity,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final Color? indicatorColor;
  final double? indicatorFontSize;
  final FontWeight? indicatorFontWeight;
  final String indicatorText;
  final double? indicatorSpacing;
  final IndicatorPosition indicatorPosition;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final String? semanticsLabel;
  final bool? enableSecurity;

  static const double _defaultFontSize = 20.0;
  static const double _defaultIndicatorOffset = 2.0;

  @override
  Widget build(BuildContext context) {
    final validatedContent = validateTextContent(
      data,
      enableSecurity: enableSecurity,
    );

    final validatedFontSize = validateTextFontSize(
      fontSize,
      defaultValue: _defaultFontSize.sp,
      enableSecurity: enableSecurity,
    );

    final validatedMaxLines = validateMaxLines(
      maxLines,
      enableSecurity: enableSecurity,
    );

    final validatedLetterSpacing = validateLetterSpacing(
      letterSpacing,
      enableSecurity: enableSecurity,
    );

    final validatedWordSpacing = validateWordSpacing(
      wordSpacing,
      enableSecurity: enableSecurity,
    );

    final validatedHeight = height != null
        ? validateLineHeight(height, enableSecurity: enableSecurity)
        : null;

    final mainTextStyle =
        textStyle ??
        TextStyle(
          color: color,
          fontSize: validatedFontSize,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontStyle: fontStyle,
          letterSpacing: validatedLetterSpacing,
          wordSpacing: validatedWordSpacing,
          height: validatedHeight,
          backgroundColor: backgroundColor,
        );

    final indicatorStyle = TextStyle(
      color: indicatorColor ?? Theme.of(context).colorScheme.error,
      fontSize: indicatorFontSize ?? (validatedFontSize ?? 14.sp) + 2,
      fontWeight: indicatorFontWeight ?? FontWeight.bold,
    );

    final spacing = indicatorSpacing ?? _defaultIndicatorOffset;

    Widget result = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: indicatorPosition == IndicatorPosition.before
          ? [
              Text(indicatorText, style: indicatorStyle),
              SizedBox(width: spacing),
              Flexible(
                child: Text(
                  validatedContent,
                  overflow: TextOverflow.ellipsis,
                  maxLines: validatedMaxLines,
                  textAlign: alignment,
                  style: mainTextStyle,
                ),
              ),
            ]
          : [
              Flexible(
                child: Text(
                  validatedContent,
                  overflow: TextOverflow.ellipsis,
                  maxLines: validatedMaxLines,
                  textAlign: alignment,
                  style: mainTextStyle,
                ),
              ),
              SizedBox(width: spacing),
              Text(indicatorText, style: indicatorStyle),
            ],
    );

    if (semanticsLabel != null) {
      result = Semantics(label: semanticsLabel, child: result);
    }

    return result;
  }
}

/// Position of the required indicator
enum IndicatorPosition { before, after }

/// A rich text widget with highlighted portions.
///
/// Example:
/// ```dart
/// HighlightedText(
///   text: 'Hello World, this is a test',
///   highlights: ['World', 'test'],
///   highlightColor: Colors.yellow,
/// )
/// ```
class HighlightedText extends StatelessWidget {
  const HighlightedText({
    super.key,
    required this.text,
    required this.highlights,
    this.highlightColor,
    this.highlightTextColor,
    this.highlightFontWeight,
    this.highlightBackgroundColor,
    this.caseSensitive = false,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textStyle,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.onHighlightTap,
    this.enableSecurity,
  });

  final String text;
  final List<String> highlights;
  final Color? highlightColor;
  final Color? highlightTextColor;
  final FontWeight? highlightFontWeight;
  final Color? highlightBackgroundColor;
  final bool caseSensitive;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextStyle? textStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final void Function(String)? onHighlightTap;
  final bool? enableSecurity;

  static const double _defaultFontSize = 14.0;

  @override
  Widget build(BuildContext context) {
    final validatedContent = validateTextContent(
      text,
      enableSecurity: enableSecurity,
    );

    final validatedFontSize = validateTextFontSize(
      fontSize,
      defaultValue: _defaultFontSize.sp,
      enableSecurity: enableSecurity,
    );

    final baseStyle =
        textStyle ??
        TextStyle(
          fontSize: validatedFontSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
        );

    final highlightStyle = baseStyle.copyWith(
      color: highlightTextColor ?? highlightColor ?? Theme.of(context).colorScheme.primary,
      fontWeight: highlightFontWeight ?? FontWeight.bold,
      backgroundColor: highlightBackgroundColor,
    );

    final List<InlineSpan> spans = [];
    String remaining = validatedContent;

    while (remaining.isNotEmpty) {
      int earliestIndex = remaining.length;
      String? foundHighlight;

      for (final highlight in highlights) {
        final index = caseSensitive
            ? remaining.indexOf(highlight)
            : remaining.toLowerCase().indexOf(highlight.toLowerCase());
        if (index != -1 && index < earliestIndex) {
          earliestIndex = index;
          foundHighlight = remaining.substring(index, index + highlight.length);
        }
      }

      if (foundHighlight != null && earliestIndex < remaining.length) {
        if (earliestIndex > 0) {
          spans.add(
            TextSpan(
              text: remaining.substring(0, earliestIndex),
              style: baseStyle,
            ),
          );
        }

        spans.add(
          TextSpan(
            text: foundHighlight,
            style: highlightStyle,
            recognizer: onHighlightTap != null
                ? (TapGestureRecognizer()
                    ..onTap = () => onHighlightTap!(foundHighlight!))
                : null,
          ),
        );

        remaining = remaining.substring(earliestIndex + foundHighlight.length);
      } else {
        spans.add(TextSpan(text: remaining, style: baseStyle));
        break;
      }
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

/// A text widget that automatically truncates with "Read More" functionality.
class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.collapsedLines = 3,
    this.expandText = 'Read more',
    this.collapseText = 'Show less',
    this.linkColor,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textStyle,
    this.textAlign,
    this.animationDuration,
    this.enableSecurity,
  });

  final String text;
  final int collapsedLines;
  final String expandText;
  final String collapseText;
  final Color? linkColor;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Duration? animationDuration;
  final bool? enableSecurity;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  static const double _defaultFontSize = 14.0;
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final validatedContent = validateTextContent(
      widget.text,
      enableSecurity: widget.enableSecurity,
    );

    final validatedFontSize = validateTextFontSize(
      widget.fontSize,
      defaultValue: _defaultFontSize.sp,
      enableSecurity: widget.enableSecurity,
    );

    final baseStyle =
        widget.textStyle ??
        TextStyle(
          fontSize: validatedFontSize,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: widget.color,
        );

    final linkStyle = baseStyle.copyWith(
      color: widget.linkColor ?? Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: validatedContent, style: baseStyle);
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.collapsedLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return AnimatedSize(
          duration: widget.animationDuration ?? _defaultAnimationDuration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                validatedContent,
                style: baseStyle,
                maxLines: _isExpanded ? null : widget.collapsedLines,
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
                textAlign: widget.textAlign,
              ),
              if (isOverflowing)
                GestureDetector(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      _isExpanded ? widget.collapseText : widget.expandText,
                      style: linkStyle,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
