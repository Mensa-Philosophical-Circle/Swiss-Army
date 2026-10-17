# Swiss Army Component

A reusable Flutter component library with widgets, theme helpers, validators, and a small CLI. This README answers the most common “how do I use X?” questions with examples for every component we ship.

## Install

Add to `pubspec.yaml`:

```yaml
dependencies:
  swiss_army_component: ^1.0.0
```

Or from the CLI (run inside your Flutter app directory):

```bash
sac install
flutter pub get
```

## What’s Inside (and Examples)

Import once:

```dart
import 'package:swiss_army_component/swiss_army_component.dart';
```

### Buttons

```dart
Column(
  children: [
    const AppElevatedButton(
      title: 'Primary',
      onPressed: doSomething,
    ),
    const NormalElevatedButton(
      title: 'Filled',
      onPressed: doSomething,
    ),
    const AppSecondaryElevatedButton(
      label: 'Secondary',
      onPressed: doSomething,
    ),
    const AppOutlinedButton(
      label: 'Outline',
      onPressed: doSomething,
    ),
    const ConfigElevatedButton(
      label: 'Sized 40%',
      width: 160,
      onPressed: doSomething,
    ),
    const ConfigOutlinedButton(
      label: 'Outlined 40%',
      width: 160,
      onPressed: doSomething,
    ),
  ],
);
```

Key props: `bgColor/textColor`, `radius`, `width/height`, `brdColor`, `buttonHeight`.

### Social Login

```dart
Column(
  children: [
    SocialButton(
      provider: SocialProvider.google,
      onPressed: () => handleGoogleSignIn(),
    ),
    SocialButton(
      provider: SocialProvider.apple,
      onPressed: () => handleAppleSignIn(),
    ),
    SocialButton(
      provider: SocialProvider.facebook,
      onPressed: () => handleFacebookSignIn(),
    ),
  ],
);
```

**Customization:**
`SocialButton` allows full control over `bgColor`, `textColor`, `iconWidget`, `borderRadius`, `padding`, and more. If no overrides are provided, it uses standard provider branding.

```dart
SocialButton(
  provider: SocialProvider.google,
  onPressed: () {},
  label: 'Sign in with Google',
  bgColor: Colors.blue,
  textColor: Colors.white,
  borderRadius: 20,
  iconWidget: Icon(Icons.g_mobiledata, color: Colors.white),
);
```

### App Bars

```dart
// Basic with gradient
Scaffold(
  appBar: const CustomAppBar(
    title: 'Dashboard',
    gradientColors: [Color(0xFF10BB76), Color(0xFF086D50)],
  ),
);

// Solid background + custom back
CustomAppBar(
  title: 'Settings',
  backgroundColor: Colors.indigo,
  onBack: () => Navigator.pop(context),
);

// Transparent overlay
const TransparentAppBar(
  title: 'Profile',
  foregroundColor: Colors.white,
);

// Search bar
SearchAppBar(
  hintText: 'Search products...',
  onChanged: (q) => filter(q),
  gradientColors: [Colors.teal, Colors.green],
);

// Tabbed
TabbedAppBar(
  title: 'Orders',
  tabs: const [Tab(text: 'Active'), Tab(text: 'History')],
  controller: tabController,
);

// Sliver (collapsing)
CustomScrollView(
  slivers: [
    CustomSliverAppBar(
      title: 'Profile',
      expandedHeight: 200,
      gradientColors: [Colors.purple, Colors.deepPurple],
    ),
    SliverList(...),
  ],
);
```

Key props: `gradientColors`, `backgroundColor`, `transparent`, `actions`, `bottom`, `leading`, `onBack`, `titleWidget`, `height`, `elevation`, `shape`.

### Search

```dart
// size controls bottom margin if ismargin=true
const CustomSearchBar(16);
```

### Text Widgets

```dart
const BrandNameText(title: 'Swiss Army');
const ProductTitleText(title: 'Travel Backpack', smallSize: true);
SmallAppText('Caption');
MedAppText('Body');
BigAppText('Headline');
ImportantAppText('Required Field');
PriceText(price: '1299.95', currency: Currency.naira, isProfit: true);
const SlashedPriceText(price: '1599', currency: '₺');
```

**Note:** `AppText` defaults to Google Fonts (Poppins), but you can use custom asset fonts by providing the `fontFamily` property or a `textStyle` with a font family.

### Spacing Helpers

```dart
Column(
  children: [
    vSpace(12),
    hSpace(8),
    Padding(padding: simPad(12, 16), child: const Text('Padded')),
  ],
);
```

### Text Fields

```dart
// Labeled input with validation
AppTextFormField(
  label: 'Email',
  hint: 'you@example.com',
  keyboardType: TextInputType.emailAddress,
  validator: FormValidator.isValidEmail,
  textInputAction: TextInputAction.done,
);

// Minimal input
const NormalAppTextFormField(
  hint: 'Username',
  textInputAction: TextInputAction.next,
);

// Phone input
AppPhoneTextField(
  label: 'Phone',
  onChanged: (number) => debugPrint(number.completeNumber),
);

// Multiline
const AppMultiLineTextFormField(
  label: 'Notes',
  maxLines: 5,
  textInputAction: TextInputAction.newline,
);

// Rounded pill input
const AppRoundedTextFormField(
  hint: 'Search',
  prefixIcon: IconButton(icon: Icon(Icons.search), onPressed: null),
);

// Bio/long text
const BioField(label: 'About you');
```

### OTP Input

```dart
OTPTextField(
  controller: otpController,
  onCompleted: (code) => debugPrint('OTP: $code'),
);
```

6-digit input using `pinput`, with a disabled soft keyboard by default.

### Validators

```dart
Form(
  child: AppTextFormField(
    label: 'Password',
    obscureText: true,
    validator: FormValidator.isValidPassword,
    textInputAction: TextInputAction.done,
  ),
);
```

Available checks: `isValidEmail`, `isValidFullName`, `isValidName`, `isValidUsername`, `isValidPhone`, `isValidPassword`.

### Logging

```dart
appLog('User logged in', {'id': userId});
```

### Theme (Light/Dark + Overrides)

```dart
// Default palettes
MaterialApp(
  theme: SACTheme.light(),
  darkTheme: SACTheme.dark(),
);

// Per-mode overrides
final config = SACThemeConfig(
  // Shared base colors (fallback)
  primary: Colors.blue,
  secondary: Colors.amber,

  // --- Light Mode Overrides ---
  primaryLight: Colors.teal,
  backgroundLight: const Color(0xFFFDFCF9), // Light background
  scaffoldBackgroundLight: Colors.white,    // specific scaffold color
  appBarBackgroundLight: Colors.white,      // specific app bar color
  inputFillColorLight: Colors.grey[100],    // specific input color

  // --- Dark Mode Overrides ---
  primaryDark: Colors.deepPurple,
  backgroundDark: const Color(0xFF0E1116),  // Dark background
  scaffoldBackgroundDark: Colors.black,     // specific scaffold color
  appBarBackgroundDark: Colors.grey[900],   // specific app bar color
  inputFillColorDark: Colors.grey[800],     // specific input color

  // --- Component Geometry (Shared) ---
  appBarElevation: 0,
  inputBorderRadius: 12.0,
  fontFamily: 'Roboto',
);

MaterialApp(
  theme: SACTheme.light(config),
  darkTheme: SACTheme.dark(config),
);
```

### Advanced Theme Customization

`SACThemeConfig` supports over 50 properties for granular control over every component:

- **Structure**: `scaffoldBackground...`, `appBarBackground...`, `drawerWidth`, `visualDensity`
- **Navigation**: `bottomNav...`, `navigationBar...`, `navigationRail...`
- **Buttons**: `fab...`, `elevatedButtonStyle`, `outlinedButtonStyle`, etc.
- **Inputs**: `inputFillColor...`, `inputBorderRadius`, `switchActiveColor`, `checkboxFillColor`
- **Surfaces**: `cardColor...`, `dialogBackground...`, `bottomSheet...`, `snackBar...`
- **Typography**: `fontFamily`, `displayLarge`, `bodyMedium`, etc.

Mode-specific fields (`...Light` / `...Dark`) allow you to create completely distinct visual identities for light and dark modes while sharing structural traits like border radius.

### CLI Commands

To use the `sac` command-line tool globally, first activate it:

```bash
dart pub global activate swiss_army_component
```

Make sure `~/.pub-cache/bin` is in your PATH. Then you can use:

- `sac install` — Sets up a project in one go (see below)
- `sac doctor` — Quick environment check
- `sac examples` — Prints code snippets for reference

#### What `sac install` sets up

Run it in a new Flutter project (`flutter create my_app`, then `cd my_app`, then `sac install`):

- adds `swiss_army_component`, `get`, `flutter_screenutil` and `liquid_glass_widgets` to `pubspec.yaml` and runs `flutter pub get`;
- writes the GetX layout under `lib/app/` (`routes`, `bindings`, `modules`, `data`, `utils`, `widgets`), a theme in `utils/theme/app_theme.dart` (change the colour there and every screen follows), a new `main.dart` and a smoke test;
- gives you ready screens: **splash**, **sign in** (validated form, API call left for you) and a **main** screen with a bottom bar that is native on each platform: liquid glass on iOS, Material 3 on Android;
- adds the frontend rules as `AGENTS.md` and the checks that enforce them in `scripts/` (files of 200 lines at most, text only through `BigAppText`/`MedAppText`/`SmallAppText`, font weight w600 at most, words as translation keys with every language complete, widgets kept with their screen, nothing written twice, views/controllers/data kept apart, no secrets or plain http, SVG/WebP assets). Run them with `bash scripts/quality_gate.sh`, and before every commit with `bash scripts/setup_hooks.sh`;
- installs the GetX command line (`dart pub global activate get_cli`), so you can add screens with `get create page:orders`, which also adds the route.

Files you have already written are kept (it says which); `--force` replaces them. `--no-template` only adds the dependency, `--no-cli` skips the GetX command line.

## Exports Map

Public API (from swiss_army_component.dart):

- Widgets: AppElevatedButton, NormalElevatedButton, AppSecondaryElevatedButton, AppOutlinedButton, ConfigElevatedButton, ConfigOutlinedButton, CustomAppBar, CustomSearchBar, OTPTextField, text widgets (SmallAppText, MedAppText, BigAppText, PriceText, SlashedPriceText, BrandNameText, ProductTitleText, ImportantAppText), spacing helpers (vSpace, hSpace, simPad), text fields (AppTextFormField, NormalAppTextFormField, AppPhoneTextField, AppMultiLineTextFormField, AppRoundedTextFormField, BioField).
- Theme: SACTheme, SACThemeConfig, SACThemeBase, AppChipTheme, AppColors.
- Utilities: FormValidator, appLog.

## Project Structure

```
lib/
├── widgets/                  # Reusable UI components
├── utils/                    # Theme + validators + logging
│   ├── theme/                # Theme builders and config
│   ├── validators/           # Form validators
│   └── logging/              # Logging utility
└── swiss_army_component.dart # Public exports
```

## Publishing to pub.dev

1. Bump version in `pubspec.yaml`.
2. Update `CHANGELOG.md`.
3. Run `flutter pub publish`.

## Support

For issues, feature requests, or questions:

- Open an issue on [GitHub Issues](https://github.com/Mensa-Philosophical-Circle/Swiss-Army/issues)
- Check existing issues before filing new ones
