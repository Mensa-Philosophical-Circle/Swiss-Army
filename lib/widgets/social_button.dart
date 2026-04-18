import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/utils.dart';

/// Supported social login providers.
enum SocialProvider {
  google,
  apple,
  facebook,
  twitter,
  linkedin,
  github,
  microsoft,
  discord,
  email,
}

/// Visual style for the social button.
enum SocialButtonStyle { elevated, filled, outlined }

/// Controls which icon variant a social button should render.
enum SocialIconVariant { theme, light, dark }

/// A highly customizable button for social login interactions.
///
/// Provides sensible defaults for popular providers (Google, Apple, Facebook),
/// but allows full customization of colors, icons, labels, and styling.
///
/// Example - Default Branding:
/// ```dart
/// SocialButton(
///   provider: SocialProvider.google,
///   onPressed: () => signInWithGoogle(),
/// );
/// ```
///
/// Example - Custom Styling:
/// ```dart
/// SocialButton(
///   provider: SocialProvider.google,
///   onPressed: () => signInWithGoogle(),
///   label: 'Sign in with Google',
///   bgColor: Colors.blue,
///   textColor: Colors.white,
///   borderRadius: 20,
///   iconWidget: Icon(Icons.g_mobiledata, color: Colors.white),
/// );
/// ```
class SocialButton extends StatelessWidget {
  /// The social provider (determines default branding if no overrides).
  final SocialProvider provider;

  /// Callback when button is pressed.
  final VoidCallback? onPressed;

  /// Custom label text. Defaults to "Continue with {Provider}".
  final String? label;

  /// Custom background color. Overrides provider default.
  final Color? bgColor;

  /// Custom text color. Overrides provider default.
  final Color? textColor;

  /// Custom icon widget. Overrides the default SVG/icon for the provider.
  final Widget? iconWidget;

  /// Icon size if using default icon. Default: 20.
  final double? iconSize;

  /// Button width. Default: full width.
  final double? width;

  /// Button height. Default: 50.
  final double? height;

  /// Border radius. Default: 10.
  final double? borderRadius;

  /// Border side. Overrides provider default.
  final BorderSide? borderSide;

  /// Padding inside the button.
  final EdgeInsetsGeometry? padding;

  /// Font size for the label. Default: 15.
  final double? fontSize;

  /// Font weight for the label. Default: FontWeight.w600.
  final FontWeight? fontWeight;

  /// Elevation. Default: 0.
  final double? elevation;

  /// Show loading indicator.
  final bool isLoading;

  /// Enable/disable the button.
  final bool enabled;

  /// The visual style of the button. Default: [SocialButtonStyle.filled].
  final SocialButtonStyle style;

  /// Controls whether the provider icon uses the theme, a light icon, or a dark icon.
  final SocialIconVariant iconVariant;

  /// Spacing between icon and text. Default: 12.
  final double? iconSpacing;

  const SocialButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.label,
    this.bgColor,
    this.textColor,
    this.iconWidget,
    this.iconSize,
    this.width,
    this.height,
    this.borderRadius,
    this.borderSide,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.elevation,
    this.isLoading = false,
    this.enabled = true,
    this.style = SocialButtonStyle.filled,
    this.iconVariant = SocialIconVariant.theme,
    this.iconSpacing,
  });

  @override
  Widget build(BuildContext context) {
    // Get provider defaults
    final config = _getProviderConfig(provider, context, iconVariant);

    // Apply overrides
    final effectiveBgColor = bgColor ?? config.bgColor;
    final effectiveTextColor = textColor ?? config.textColor;
    final effectiveBorderSide = borderSide ?? config.borderSide;
    final effectiveLabel = label ?? config.defaultLabel;
    final effectiveIconSize = iconSize ?? 20.0;
    final effectiveFontSize = fontSize ?? 15.0;
    final effectiveFontWeight = fontWeight ?? FontWeight.w600;
    final effectiveIconSpacing = iconSpacing ?? 12.0;
    final effectiveRadius = borderRadius ?? 10.0;
    final effectiveHeight = height ?? context.buttonHeight;
    final effectiveElevation = elevation ?? 0.0;

    return SizedBox(
      width: width ?? double.infinity,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, effectiveHeight),
          backgroundColor: style == SocialButtonStyle.outlined
              ? Colors.transparent
              : effectiveBgColor,
          foregroundColor: effectiveTextColor,
          elevation: style == SocialButtonStyle.filled ? 0 : effectiveElevation,
          shadowColor: style == SocialButtonStyle.filled
              ? Colors.transparent
              : null,
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
            side: style == SocialButtonStyle.outlined
                ? (effectiveBorderSide ?? BorderSide(color: effectiveBgColor))
                : (effectiveBorderSide ?? BorderSide.none),
          ),
          disabledBackgroundColor: style == SocialButtonStyle.outlined
              ? Colors.transparent
              : effectiveBgColor.withValues(alpha: 0.5),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIcon(config, effectiveIconSize, effectiveTextColor),
                  SizedBox(width: effectiveIconSpacing),
                  Text(
                    effectiveLabel,
                    style: TextStyle(
                      color: effectiveTextColor,
                      fontWeight: effectiveFontWeight,
                      fontSize: effectiveFontSize,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildIcon(_SocialConfig config, double size, Color fallbackColor) {
    // If user provided a custom icon widget, use it
    if (iconWidget != null) {
      return iconWidget!;
    }

    // Otherwise, use the provider default
    if (config.isSvg) {
      return SvgPicture.string(
        config.iconData as String,
        width: size,
        height: size,
      );
    } else {
      return Icon(
        config.iconData as IconData,
        color: config.iconColor ?? fallbackColor,
        size: size,
      );
    }
  }

  _SocialConfig _getProviderConfig(
    SocialProvider provider,
    BuildContext context,
    SocialIconVariant iconVariant,
  ) {
    bool useDarkIcon() {
      switch (iconVariant) {
        case SocialIconVariant.dark:
          return true;
        case SocialIconVariant.light:
          return false;
        case SocialIconVariant.theme:
          return Theme.of(context).brightness == Brightness.dark;
      }
    }

    switch (provider) {
      case SocialProvider.google:
        return _SocialConfig(
          defaultLabel: 'Continue with Google',
          bgColor: Colors.white,
          textColor: Colors.black87,
          iconData: _googleSvg,
          isSvg: true,
          borderSide: BorderSide(color: Colors.grey.shade300),
        );
      case SocialProvider.apple:
        final isDark = useDarkIcon();
        return _SocialConfig(
          defaultLabel: 'Continue with Apple',
          bgColor: isDark ? Colors.white : Colors.black,
          textColor: isDark ? Colors.black : Colors.white,
          iconData: isDark ? _appleDarkSvg : _appleLightSvg,
          isSvg: true,
        );
      case SocialProvider.facebook:
        final isDark = useDarkIcon();
        return _SocialConfig(
          defaultLabel: 'Continue with Facebook',
          bgColor: isDark ? Colors.white : const Color(0xFF1877F2),
          textColor: isDark ? Colors.black : Colors.white,
          iconData: isDark ? _facebookBlueSvg : _facebookSvg,
          isSvg: true,
        );
      case SocialProvider.twitter:
        final isDark = useDarkIcon();
        return _SocialConfig(
          defaultLabel: 'Continue with X',
          bgColor: isDark ? Colors.white : Colors.black,
          textColor: isDark ? Colors.black : Colors.white,
          iconData: _twitterSvg,
          isSvg: true,
        );
      case SocialProvider.linkedin:
        return _SocialConfig(
          defaultLabel: 'Continue with LinkedIn',
          bgColor: const Color(0xFF0077B5),
          textColor: Colors.white,
          iconData: _linkedinSvg,
          isSvg: true,
        );
      case SocialProvider.github:
        final isDark = useDarkIcon();
        return _SocialConfig(
          defaultLabel: 'Continue with GitHub',
          bgColor: isDark ? Colors.white : const Color(0xFF24292e),
          textColor: isDark ? Colors.black : Colors.white,
          iconData: _githubSvg,
          isSvg: true,
        );
      case SocialProvider.microsoft:
        return _SocialConfig(
          defaultLabel: 'Continue with Microsoft',
          bgColor: Colors.white,
          textColor: const Color(0xFF5E5E5E),
          iconData: _microsoftSvg,
          isSvg: true,
          borderSide: BorderSide(color: Colors.grey.shade300),
        );
      case SocialProvider.discord:
        return _SocialConfig(
          defaultLabel: 'Continue with Discord',
          bgColor: const Color(0xFF5865F2),
          textColor: Colors.white,
          iconData: _discordSvg,
          isSvg: true,
        );
      case SocialProvider.email:
        return _SocialConfig(
          defaultLabel: 'Continue with Email',
          bgColor: Colors.grey.shade100,
          textColor: Colors.black,
          iconData: Icons.email_outlined,
          isSvg: false,
          iconColor: Colors.black,
        );
    }
  }
}

class _SocialConfig {
  final String defaultLabel;
  final Color bgColor;
  final Color textColor;
  final dynamic iconData; // String (SVG) or IconData
  final bool isSvg;
  final Color? iconColor;
  final BorderSide? borderSide;

  _SocialConfig({
    required this.defaultLabel,
    required this.bgColor,
    required this.textColor,
    required this.iconData,
    required this.isSvg,
    this.iconColor,
    this.borderSide,
  });
}

// --- SVG Assets ---

const _googleSvg =
    '''<svg viewBox="0 0 48 48" version="1.1" xmlns="http://www.w3.org/2000/svg"><path fill="#FFC107" d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"/><path fill="#FF3D00" d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"/><path fill="#4CAF50" d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"/><path fill="#1976D2" d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"/></svg>''';

const _facebookSvg =
    '''<svg viewBox="0 0 48 48" version="1.1" xmlns="http://www.w3.org/2000/svg"><path fill="#FFFFFF" d="M24 4C12.954 4 4 12.954 4 24C4 33.856 11.206 42.067 20.655 43.766V29.351H15.826V24H20.655V19.721C20.655 14.935 23.498 12.288 27.818 12.288C29.887 12.288 32.052 12.658 32.052 12.658V17.357H29.667C27.29 17.357 26.549 18.831 26.549 21.054V24H31.841L30.995 29.351H26.549V43.844C36.326 42.348 44 34.026 44 24C44 12.954 35.046 4 24 4Z"/></svg>''';

const _facebookBlueSvg =
    '''<svg viewBox="0 0 48 48" version="1.1" xmlns="http://www.w3.org/2000/svg"><path fill="#1877F2" d="M24 4C12.954 4 4 12.954 4 24C4 33.856 11.206 42.067 20.655 43.766V29.351H15.826V24H20.655V19.721C20.655 14.935 23.498 12.288 27.818 12.288C29.887 12.288 32.052 12.658 32.052 12.658V17.357H29.667C27.29 17.357 26.549 18.831 26.549 21.054V24H31.841L30.995 29.351H26.549V43.844C36.326 42.348 44 34.026 44 24C44 12.954 35.046 4 24 4Z"/></svg>''';

// Apple logo (black for light mode)
const _appleLightSvg =
    '''<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><path d="M22.842 22.847c-0.895 1.289-1.832 2.568-3.237 2.595-1.405 0.026-1.858-0.832-3.479-0.832s-2.105 0.816-3.416 0.868c-1.358 0.053-2.395-1.358-3.263-2.611-1.779-2.568-3.137-7.295-1.311-10.463 0.905-1.568 2.532-2.563 4.295-2.589 1.353-0.026 2.632 0.911 3.463 0.911 0.826 0 2.379-1.126 4.011-0.963 0.684 0.026 2.605 0.279 3.837 2.084-0.105 0.063-2.295 1.342-2.268 4.005 0.026 3.195 2.8 4.295 2.837 4.311-0.026 0.079-0.442 1.537-1.468 3.037zM20.258 7.642c0.758-0.921 1.268-2.2 1.132-3.484-1.089 0.042-2.411 0.726-3.195 1.642-0.705 0.816-1.321 2.126-1.153 3.384 1.216 0.095 2.458-0.611 3.216-1.542z" fill="#FFFFFF"/></svg>''';

// Apple logo (white for dark mode)
const _appleDarkSvg =
    '''<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><path d="M22.842 22.847c-0.895 1.289-1.832 2.568-3.237 2.595-1.405 0.026-1.858-0.832-3.479-0.832s-2.105 0.816-3.416 0.868c-1.358 0.053-2.395-1.358-3.263-2.611-1.779-2.568-3.137-7.295-1.311-10.463 0.905-1.568 2.532-2.563 4.295-2.589 1.353-0.026 2.632 0.911 3.463 0.911 0.826 0 2.379-1.126 4.011-0.963 0.684 0.026 2.605 0.279 3.837 2.084-0.105 0.063-2.295 1.342-2.268 4.005 0.026 3.195 2.8 4.295 2.837 4.311-0.026 0.079-0.442 1.537-1.468 3.037zM20.258 7.642c0.758-0.921 1.268-2.2 1.132-3.484-1.089 0.042-2.411 0.726-3.195 1.642-0.705 0.816-1.321 2.126-1.153 3.384 1.216 0.095 2.458-0.611 3.216-1.542z" fill="#000000"/></svg>''';

const _twitterSvg =
    '''<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" fill="currentColor"/></svg>''';

const _linkedinSvg =
    '''<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" fill="#0077B5"/></svg>''';

const _githubSvg =
    '''<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12" fill="currentColor"/></svg>''';

const _microsoftSvg =
    '''<svg viewBox="0 0 23 23" xmlns="http://www.w3.org/2000/svg"><path fill="#f35325" d="M1 1h10v10H1z"/><path fill="#81bc06" d="M12 1h10v10H12z"/><path fill="#05a6f0" d="M1 12h10v10H1z"/><path fill="#ffba08" d="M12 12h10v10H12z"/></svg>''';

const _discordSvg =
    '''<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.772-.6083 1.1588a18.2915 18.2915 0 00-5.4882 0 12.64 12.64 0 00-.6173-1.1588.0775.0775 0 00-.0785-.0371 19.7363 19.7363 0 00-4.8852 1.5151.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.419-2.1568 2.419zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.419-2.1568 2.419z" fill="#5865F2"/></svg>''';
