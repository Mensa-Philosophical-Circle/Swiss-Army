# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.0.0 (2026-04-18)


### Features

* Add comprehensive button styling options and standardize input/button heights to 52.0. ([c405640](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/c40564098042719a7e8ce89826d3156c5a6a57c8))
* add SocialLoginButton and flutter_svg dependency ([fd2e2de](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/fd2e2ded11ae1ddfa5ee6617fa6d8ee1be1b4047))
* apply custom font family and primary text colors to theme typography ([8dc06f4](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/8dc06f42a67813e11bf444384c2e6d2c7d9ed01d))
* Create swiss_army_component library structure ([457c668](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/457c668516727d6d2e97f543af10630195ae3bf5))
* default height fallback of 52.h for TextFields and Dropdowns ([46ff391](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/46ff39149040fdf57055658ea38c0d789c4b5ea0))
* Enhance CustomAppBar with additional properties and flexible space options ([870dadb](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/870dadb20bc4bcee4ccaae646cc6af5a9e76aab7))
* enhance SocialButton with icon variant support and improve AppTextField label color consistency ([917078a](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/917078a2f5b449cf92dccdbeec199858de29cf8c))
* Implement CLI tool for swiss_army_component ([457c668](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/457c668516727d6d2e97f543af10630195ae3bf5))
* Introduce `phoneValidator` to `AppPhoneTextField` and `isValidPhoneNumber` to `FormValidator` for enhanced phone number validation. ([2912cf6](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/2912cf61e32ef82c72958e22b08b857ede496911))
* Introduce SACThemeConfig for theme customization ([457c668](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/457c668516727d6d2e97f543af10630195ae3bf5))
* Refactor AppText to leverage theme text styles, adjust AppButton elevation to respect theme, and make text field properties nullable for improved theme integration, while removing test output files. ([4f917d5](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/4f917d57be16b124896f3db34735f197e60eb366))
* Rename package to swiss_army_component and update pubspec.yaml ([457c668](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/457c668516727d6d2e97f543af10630195ae3bf5))
* use official Nigeria 774 LGAs instead of city data ([343f91f](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/343f91febc7ea9d9fb33f5006076bdb2853b5d7b))


### Bug Fixes

* AppText theme color inheritance and custom font support ([f25363f](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/f25363f763de338fa319771292916ae3d4dce2bd))
* **AppText:** inherit fontFamily from theme by default and update docs ([ca715fe](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/ca715fe89a4b55035857a5c6a904524b7a079941))
* consistent input field heights for AppTextField and AppDropdown ([33e2c46](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/33e2c4661cd51d12d29ee355ae7607cc41f58c39))
* Correctly merge granular theme properties and standardize phone field and dropdown UI. ([757fe7b](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/757fe7b6ca13e0d7cb1c061848ff613efdefa682))
* migrate repo URLs to Mensa-Philosophical-Circle/Swiss-Army ([e07f360](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/e07f3603e7fe0a3adfe14308f233e8961193c6e4))
* migrate repo URLs to Mensa-Philosophical-Circle/Swiss-Army ([9488df8](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/9488df8f7987693463dfe2455baf11c8f48152cd))
* phone field height collapse and upgrade dependencies ([bd7da3e](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/bd7da3ec03afd03b86be4b1fb0fd4e959460afe1))
* resolve theme text style override issue (v0.4.3) ([6fee37b](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/6fee37b963d0ea2720d11832e9e6ee7bcaf0fa7f))
* revert aggressive spacing and bump to 0.5.10 ([6ce9438](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/6ce943851f7ee8614549ff87841f6699415e6546))
* **SocialLoginButton:** add full customization support ([772eabe](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/772eabeebb8f1adfc7dcc6ab783aa5e1bc4b8a29))
* text field height, cursor alignment and granular theme heights ([25dd6fb](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/commit/25dd6fb9893150b93f7a9dc7fccc8a9b6e99b812))

## [0.5.14] - 2026-04-18

### Fixed

- **SocialButton**: Added `SocialIconVariant` so callers can choose theme, light, or dark icon variants.
- **AppTextField**: Focused input label color now follows the configured label style instead of forcing the package primary color.
- **Dark Theme**: Improved consistency for focused text input labels in dark mode.



## [0.5.12] - 2026-04-12

### Fixed

- **AppTextField**: Fixed input height inconsistency caused by wrapping `TextFormField` in a fixed-height `SizedBox`. Replaced with `ConstrainedBox(minHeight)` so the input area stays consistent while validation errors and helper text expand naturally below.
- **AppDropdown**: Applied the same `SizedBox` → `ConstrainedBox(minHeight)` fix to prevent dropdown input area from shrinking when validation errors appear.

## [0.5.11] - 2026-03-20

### Fixed

- **AppPhoneTextField**: Fixed height collapse when validation errors appear. Default height is now `70.h`.
- **Dependencies**: Upgraded all packages (`google_fonts` 8.x, `flutter_svg` 2.2.4, `pinput` 6.0.2, and more).

## [0.5.10] - 2026-03-20

### Fixed

- **AppTextField & AppPhoneTextField**: Reverted vertical spacing and density changes that caused layout collapse.

## [0.5.9] - 2026-03-20

### Fixed

- **AppPhoneTextField**: Fixed cursor alignment and height issues by adding `textAlignVertical: center` and explicit `cursorHeight`.
- **AppTextField**: Standardized internal spacing and enabled `isDense: true` for perfect centering at any height.
- **Granular Heights**: Added `phoneFieldHeight` and `dropdownHeight` to `SACThemeConfig` for independent component height control.

## [0.5.8] - 2026-03-20

### Fixed

- **Phone Field UI**: Standardized `AppPhoneTextField` background to white in light mode and adjusted internal padding to fix cursor misalignment.
- **Dropdown UI**: Standardized `AppDropdown` background to white in light mode for consistency.
- **Theme Merging**: Fixed `SACThemeConfig.merge` to include all granular properties (focused borders, granular component colors), ensuring complex theme overrides are preserved.

## [0.5.7] - 2026-03-20

### Fixed

- **Phone Validation**: Added `isValidPhoneNumber` to `FormValidator` for `PhoneNumber` compatibility.
- **AppPhoneTextField**: Added `phoneValidator` parameter to support standard string-based validators.

## [0.5.6] - 2026-03-20

### Fixed

- **Theme Consistency**: Refactored `AppButton` variants to correctly merge with global theme styles, ensuring primary color inheritance.
- **Granular Theming**: Added separate color properties for Elevated, Outlined, and Filled buttons in `SACThemeConfig`.
- **Field Backgrounds**: Fixed `AppPhoneTextField` and `AppDropdown` to have a white background in light mode (consistent with other fields).
- **Height Standardization**: Standardized all buttons and inputs to a default height of 52.0 logical pixels.
- **Visual Feedback**: Added distinct disabled state background for `AppPhoneTextField`.

## [0.5.5] - 2026-03-20

### Fixed

- **AppPhoneTextField**: Now accurately respects global `inputHeight` from theme.
- **SocialButton**: Now respects global `buttonHeight` from theme and includes missing internal padding fixes.
- **Comprehensive Standardization**: Applied height standardization to all remaining input and button variants including `OTPTextField`, `AppPasswordField`, `ConfigOutlinedButton`, `AppTextButton`, and `AppGradientButton`.
- **Flexibility**: Added `height` parameter to `CountryDropdown`, `StateDropdown`, `CityDropdown`, and `AppPasswordField` for granular overrides.

## [0.5.4] - 2026-03-19

### Added

- **Standardized Component Heights**: Introduced global configuration for input and button heights through `SACThemeConfig`.
- **SACThemeExtension**: Added a custom theme extension to store and access Swiss Army component-specific properties.
- **SACThemeContext Extension**: Added a `BuildContext` extension for easy access to `inputHeight` and `buttonHeight` with a responsive fallback of `context.height * 0.07`.

### Changed

- **AppTextField**: Now respects global `inputHeight` from theme or fallback.
- **AppDropdown**: Now respects global `inputHeight` from theme or fallback.
- **CustomSearchBar**: Replaced hardcoded height with theme-aware `inputHeight` and fallback.
- **AppButtons**: Updated `AppElevatedButton`, `NormalElevatedButton`, `AppSecondaryElevatedButton`, `AppOutlinedButton`, and `ConfigElevatedButton` to respect global `buttonHeight` from theme or fallback.


### Added

- **Default Height Fallback**: Added a standard default height of `52.h` to `AppTextField`, `AppPhoneTextField`, and `AppDropdown` when no height is explicitly provided. This ensures visual consistency across all input types by default.

### Changed

- **AppDropdown**: Added `height` parameter support and updated default vertical `contentPadding` to `14.h` to match text fields.

## [0.5.2] - 2026-03-15

### Fixed

- **TextField Border Color**: Fixed an issue where the `focusedBorder` color was hardcoded to `AppColors.primary`, ignoring the theme's `focusedBorder` color or explicit `focusedBorderColor` property.
- **TextField Height**: Fixed an issue where the `height` parameter passed to `AppTextField` (and derived widgets) was being ignored.
- **AppPhoneTextField Consistency**: Added `height` and `contentPadding` parameters to `AppPhoneTextField` to ensure visual consistency with regular text fields. Default `contentPadding` now matches `AppTextField`.

## [0.5.1] - 2026-02-10

### Fixed

- **Nigeria Data Accuracy**: Replaced incomplete "City" data for Nigeria with a custom, comprehensive list of all 37 States (including FCT) and 774 official Local Government Areas (LGAs). Selecting "Nigeria" in `CountryDropdown` now automatically sources this corrected data for `StateDropdown` and `CityDropdown`.

## [0.5.0] - 2026-02-03

### Added

- **SocialButton Enhancements**:
  - Added support for new providers: X (Twitter), LinkedIn, GitHub, Microsoft, and Discord.
  - Added `style` parameter supporting `SocialButtonStyle.filled` (default), `SocialButtonStyle.outlined`, and `SocialButtonStyle.elevated`.
  - Providers now support theme-aware branding (e.g., Apple/GitHub adapt to light/dark mode).

### Fixed

- **BigAppText Theme Inheritance**: `BigAppText` now simply uses `AppTextStyle.large` which inherits from `Theme.of(context).textTheme.bodyLarge`, ensuring correct color inheritance.
- **Tests**: Improved test robustness for `widget_test.dart` and `otp_security_test.dart` by disabling noisy debug logs.

---

## [0.4.3] - 2026-02-02

### Fixed

- **Theme Configuration**: Fixed an issue where `SACThemeConfig` specific text style overrides (e.g., `bodyLarge`, `displaySmall`) were being ignored and overridden by the default primary text color. Users can now confidently override specific text styles in their theme config.

---

## [0.4.2] - 2026-01-23

### Fixed

- **SocialButton**: Added adaptive branding for Facebook. In dark mode, it now switches to a white background with a blue logo, consistent with the Apple login button branding.

---

## [0.4.1] - 2026-01-23

### Changed

- **SocialButton**: Added full customization support. Users can now override `bgColor`, `textColor`, `iconWidget`, `iconSize`, `borderRadius`, `borderSide`, `padding`, `fontSize`, `fontWeight`, `elevation`, and `iconSpacing`. Provider defaults are preserved when no overrides are specified.

---

## [0.4.0] - 2026-01-23

### Added

- **SocialButton**: New widget for social authentication with built-in branding for Google, Apple, Facebook, and Email providers. Uses embedded SVGs for logos, so no asset configuration is required.

### Dependencies

- Added `flutter_svg` for rendering SVG icons.

---

## [0.3.3] - 2026-01-23

### Changed

- **Button Elevation**: Changed default elevation for `AppElevatedButton` and `NormalElevatedButton` from `2.0` to `0.0` for a flatter, more modern default look.

---

## [0.3.2] - 2026-01-23

### Fixed

- **AppText Font Family Inheritance**: Removed hardcoded Poppins font default. `AppText` now properly inherits `fontFamily` from `Theme.of(context)`. Users can still use Poppins by setting it in their theme or via the `fontFamily` property.

---

## [0.3.1] - 2026-01-23

### Fixed

- **AppText Theme Color Inheritance**: Removed hardcoded black color default from `AppText` and all derived widgets, allowing proper color inheritance from theme.
- **Style Merging**: `AppText` now correctly prioritizes explicit properties (like `color`, `fontSize`) over the provided `textStyle`.
- **Custom Font Support**: Added support for non-Google fonts. Providing a `fontFamily` now uses a standard `TextStyle`, enabling asset-based fonts.

### Changed

- Updated text widgets to behave more predictably when composing styles.

---

## [0.3.0] - 2026-01-23

### Added

- **Comprehensive Theme System**: Expanded `SACThemeConfig` with 50+ new properties for granular control over all Flutter Material components
  - Component-specific theming: Scaffold, AppBar, BottomNavigationBar, NavigationBar, NavigationRail, Drawer, FAB
  - Button theming: ElevatedButton, OutlinedButton, TextButton, FilledButton, IconButton
  - Surface theming: Cards, Dialogs, BottomSheet, Snackbar, PopupMenu
  - Input theming: TextField decoration, Checkbox, Radio, Switch, Slider, ProgressIndicator
  - Display theming: Tooltip, Divider, ListTile, TabBar, DataTable, Chip, Badge, SearchBar, SegmentedButton, ExpansionTile
  - Typography: Full `TextTheme` customization with `fontFamily` and individual text style overrides
  - Interaction states: splash, highlight, hover, focus, disabled colors
  - Mode-specific overrides: Separate `...Light` and `...Dark` properties for complete light/dark mode customization

### Changed

- Updated `README.md` with advanced theming documentation and examples
- Enhanced `example/example.dart` to showcase new theme capabilities including typography configuration

### Fixed

- Lint issue in OTP widget: Added braces around if-statement return
- Removed unnecessary library declaration
- Removed duplicate import in test file

---

## [0.2.1] - 2026-01-23

### Added

- Comprehensive `example/example.dart` showcasing all components
- MIT LICENSE file
- `.pubignore` to exclude IDE/build files from published package

### Changed

- Updated README with CLI installation instructions (`dart pub global activate swiss_army_component`)

---

## [0.1.0] - 2026-01-22

### Added

- Initial release of My Flutter Components package
- Pre-built widgets:
  - Custom AppBar
  - Themed AppButton
  - AppText for text styling
  - OTP input field
  - SearchBar component
  - Space utilities
  - TextFields with validation
  - General widget utilities
- Complete theme system:
  - Color palette management
  - Chip theme customization
  - Responsive design support
- Utility functions:
  - Form validators
  - Text formatters
  - Device utilities
  - Application logging
  - Helper functions
- Constants:
  - API constants
  - Image paths
  - Size constants
  - Text strings
- Documentation and examples

## [0.2.0] - 2026-01-22

### Changed

- Converted repository to a pure package by removing all app template files (`lib/main.dart`, `lib/app/**`).
- Updated README and Setup Guide to focus on package usage only.
- Renamed package from `my_flutter_components` to `swiss_army_component`.

### Added

- CLI `sac` with commands:
  - `doctor` to check Flutter environment
  - `install` to add `swiss_army_component` to an app's `pubspec.yaml`
  - `examples` to print usage snippets
- Pubspec updates: version bump to `0.2.0`, `executables` entry, and CLI dependencies.
