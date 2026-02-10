// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:swiss_army_component/swiss_army_component.dart';
import 'package:country_state_city/country_state_city.dart' as csc;

void main() {
  runApp(const ExampleApp());
}

// =============================================================================
// THEME CONFIGURATION EXAMPLES
// =============================================================================

/// Example 1: Using default themes
class DefaultThemeApp extends StatelessWidget {
  const DefaultThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SACTheme.light(),
      darkTheme: SACTheme.dark(),
      home: const Placeholder(),
    );
  }
}

/// Example 2: Custom theme with SACThemeConfig
class CustomThemeApp extends StatelessWidget {
  const CustomThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define custom colors using SACThemeConfig
    const config = SACThemeConfig(
      // Shared fallback colors
      primary: Colors.teal,
      secondary: Colors.orange,
      error: Colors.redAccent,
      success: Colors.green,

      // Light mode specific
      primaryLight: Colors.teal,
      secondaryLight: Colors.orange,
      backgroundLight: Color(0xFFFDFCF9),
      surfaceLight: Colors.white,
      borderLight: Color(0xFFE5E5E5),

      // Dark mode specific
      primaryDark: Colors.deepPurple,
      secondaryDark: Colors.tealAccent,
      backgroundDark: Color(0xFF0E1116),
      surfaceDark: Color(0xFF161B22),
      borderDark: Color(0xFF30363D),
    );

    return MaterialApp(
      theme: SACTheme.light(config),
      darkTheme: SACTheme.dark(config),
      home: const Placeholder(),
    );
  }
}

/// Example 3: Reusable theme class extending SACThemeBase
class MyAppTheme extends SACThemeBase {
  const MyAppTheme();

  @override
  SACThemeConfig? config() => const SACThemeConfig(
    primaryLight: Colors.indigo,
    secondaryLight: Colors.amber,
    primaryDark: Colors.indigoAccent,
    secondaryDark: Colors.amberAccent,
  );
}

// Usage: final theme = MyAppTheme(); theme.light() / theme.dark()

/// Main app entry - demonstrating theme setup
class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    const config = SACThemeConfig(
      primaryLight: Colors.teal,
      secondaryLight: Colors.orange,
      primaryDark: Colors.deepPurple,
      secondaryDark: Colors.tealAccent,
    );

    return MaterialApp(
      title: 'Swiss Army Component Demo',
      theme: SACTheme.light(config),
      darkTheme: SACTheme.dark(config),
      home: const ComponentShowcase(),
    );
  }
}

/// Main showcase screen with navigation to all component demos
class ComponentShowcase extends StatelessWidget {
  const ComponentShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Swiss Army Component',
        gradientColors: [Color(0xFF10BB76), Color(0xFF086D50)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Theme Configuration', const ThemeExamples()),
          _buildSection('Buttons', const ButtonExamples()),
          _buildSection('App Bars', const AppBarExamples()),
          _buildSection('Text Widgets', const TextExamples()),
          _buildSection('Text Fields', const TextFieldExamples()),
          _buildSection('OTP Input', const OTPExamples()),
          _buildSection('Search Bars', const SearchBarExamples()),
          _buildSection('Utilities', const UtilityExamples()),
          _buildSection('Location Dropdowns', const LocationDropdownExamples()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: false,
        children: [Padding(padding: const EdgeInsets.all(16), child: content)],
      ),
    );
  }
}

// =============================================================================
// THEME CONFIGURATION SECTION
// =============================================================================

class ThemeExamples extends StatelessWidget {
  const ThemeExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigAppText('Theme System Overview'),
        vSpace(8),
        SmallAppText('Swiss Army Component provides a complete theme system:'),
        vSpace(12),

        // SACTheme usage
        MedAppText('1. SACTheme - Theme Factory'),
        vSpace(4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'SACTheme.light()  // Default light theme\n'
            'SACTheme.dark()   // Default dark theme\n'
            'SACTheme.light(config)  // Custom colors',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        vSpace(16),

        // SACThemeConfig usage
        MedAppText('2. SACThemeConfig - Color Configuration'),
        vSpace(4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'const config = SACThemeConfig(\n'
            '  primaryLight: Colors.teal,\n'
            '  primaryDark: Colors.deepPurple,\n'
            '  backgroundLight: Color(0xFFFDFCF9),\n'
            '  surfaceDark: Color(0xFF161B22),\n'
            ');',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        vSpace(16),

        vSpace(16),

        // Advanced Customization
        MedAppText('3. Advanced Component Customization'),
        vSpace(4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'SACThemeConfig(\n'
            '  // Specific overrides per component\n'
            '  scaffoldBackgroundLight: Colors.white,\n'
            '  appBarElevation: 0,\n'
            '  inputBorderRadius: 12.0,\n'
            '  fabShape: CircleBorder(),\n'
            ');',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        vSpace(8),
        SmallAppText(
          'Over 50 properties available including Scaffold, AppBar, Navigation, Buttons, Cards, Dialogs, Inputs, and more.',
        ),
        vSpace(16),

        // Typography Config
        MedAppText('4. Typography Configuration'),
        vSpace(4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'SACThemeConfig(\n'
            '  fontFamily: "Roboto",\n'
            '  displayLarge: TextStyle(\n'
            '    fontSize: 32,\n'
            '    fontWeight: FontWeight.bold,\n'
            '  ),\n'
            ');',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        vSpace(16),

        // AppColors
        MedAppText('5. AppColors - Color Constants'),
        vSpace(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _colorChip('primary', AppColors.primary),
            _colorChip('secondary', AppColors.secondary),
            _colorChip('green', AppColors.green),
            _colorChip('red', AppColors.red),
            _colorChip('grey', AppColors.grey),
            _colorChip('black', AppColors.black),
            _colorChip('white', AppColors.white),
          ],
        ),
      ],
    );
  }

  Widget _colorChip(String name, Color color) {
    return Chip(
      avatar: CircleAvatar(backgroundColor: color),
      label: Text(name, style: const TextStyle(fontSize: 12)),
    );
  }
}

// =============================================================================
// BUTTON EXAMPLES
// =============================================================================

class ButtonExamples extends StatelessWidget {
  const ButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary elevated button
        const AppElevatedButton(
          title: 'Primary Button',
          onPressed: _handlePress,
        ),
        vSpace(12),

        // Normal filled button
        const NormalElevatedButton(
          title: 'Filled Button',
          onPressed: _handlePress,
        ),
        vSpace(12),

        // Secondary button
        const AppSecondaryElevatedButton(
          label: 'Secondary Button',
          onPressed: _handlePress,
        ),
        vSpace(12),

        // Outlined button
        const AppOutlinedButton(
          label: 'Outlined Button',
          onPressed: _handlePress,
        ),
        vSpace(12),

        // Configurable buttons with custom sizes
        Row(
          children: [
            Expanded(
              child: ConfigElevatedButton(
                label: 'Sized',
                width: 160,
                bgcolour: Colors.purple,
                onPressed: () => _handlePress(),
              ),
            ),
            hSpace(12),
            Expanded(
              child: ConfigOutlinedButton(
                label: 'Outlined',
                width: 160,
                brdcolour: Colors.purple,
                onPressed: () => _handlePress(),
              ),
            ),
          ],
        ),
        vSpace(12),

        // Button with loading state
        const AppElevatedButton(
          title: 'Loading Button',
          isLoading: true,
          onPressed: null,
        ),
      ],
    );
  }

  static void _handlePress() {
    print('Button pressed!');
  }
}

// =============================================================================
// APP BAR EXAMPLES
// =============================================================================

class AppBarExamples extends StatelessWidget {
  const AppBarExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MedAppText('CustomAppBar - Gradient background with actions'),
        vSpace(8),
        SizedBox(
          height: 60,
          child: CustomAppBar(
            title: 'Dashboard',
            gradientColors: const [Colors.teal, Colors.green],
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        vSpace(16),

        MedAppText('SearchAppBar - Integrated search field'),
        vSpace(8),
        SizedBox(
          height: 60,
          child: SearchAppBar(
            hintText: 'Search products...',
            onChanged: (q) => print('Search: $q'),
            gradientColors: const [Colors.indigo, Colors.blue],
          ),
        ),
        vSpace(16),

        MedAppText('TransparentAppBar - Overlay on content'),
        vSpace(8),
        Container(
          height: 60,
          color: Colors.grey[300],
          child: const TransparentAppBar(
            title: 'Profile',
            foregroundColor: Colors.black87,
          ),
        ),
        vSpace(16),

        SmallAppText(
          'TabbedAppBar and CustomSliverAppBar require TabController/ScrollView',
        ),
      ],
    );
  }
}

// =============================================================================
// TEXT WIDGET EXAMPLES
// =============================================================================

class TextExamples extends StatelessWidget {
  const TextExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Size variants
        SmallAppText('SmallAppText - Caption text (12sp)'),
        vSpace(8),
        MedAppText('MedAppText - Body text (14sp)'),
        vSpace(8),
        BigAppText('BigAppText - Headline (18sp)'),
        vSpace(16),

        // Special text widgets
        const BrandNameText(title: 'Swiss Army'),
        vSpace(8),
        const ProductTitleText(
          title: 'Travel Backpack',
          size: ProductTitleSize.small,
        ),
        vSpace(8),
        ImportantAppText('Required Field *'),
        vSpace(16),

        // Price formatting
        Row(
          children: [
            const PriceText(
              price: '1299.99',
              currency: Currency.usd,
              showDecimals: true,
            ),
            hSpace(16),
            const PriceText(
              price: '50000',
              currency: Currency.naira,
              isProfit: true,
            ),
            hSpace(16),
            const PriceText(
              price: '-250',
              currency: Currency.eur,
              isProfit: false,
            ),
          ],
        ),
        vSpace(12),

        // Slashed price (for discounts)
        Row(
          children: [
            const SlashedPriceText(price: '1599', currency: Currency.usd),
            hSpace(16),
            const PriceText(price: '1299', currency: Currency.usd),
          ],
        ),
        vSpace(16),

        // AppText with full customization
        AppText(
          'Customizable AppText',
          style: AppTextStyle.heading,
          color: Colors.purple,
          fontWeight: FontWeight.bold,
          decoration: AppTextDecoration.underline,
        ),
      ],
    );
  }
}

// =============================================================================
// TEXT FIELD EXAMPLES
// =============================================================================

class TextFieldExamples extends StatelessWidget {
  const TextFieldExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Standard text field with label
        AppTextField(
          label: 'Email',
          hint: 'you@example.com',
          prefixIconData: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: FormValidator.isValidEmail,
        ),
        vSpace(16),

        // Password field with toggle
        const AppPasswordField(
          label: 'Password',
          hint: 'Enter your password',
          showPasswordToggle: true,
          prefixIconData: Icons.lock,
        ),
        vSpace(16),

        // Phone number input
        AppPhoneTextField(
          label: 'Phone Number',
          onChanged: (phone) => print('Phone: ${phone.completeNumber}'),
        ),
        vSpace(16),

        // Multiline text field
        const AppMultiLineTextField(
          label: 'Notes',
          hint: 'Enter your notes here...',
          maxLines: 4,
        ),
        vSpace(16),

        // Rounded/pill text field
        const AppRoundedTextField(
          hint: 'Search...',
          prefixIcon: Icon(Icons.search),
        ),
        vSpace(16),

        // Simple text field (no label)
        const NormalAppTextFormField(hint: 'Simple input without label'),
        vSpace(16),

        // Bio field
        const BioField(label: 'About You'),
      ],
    );
  }
}

// =============================================================================
// OTP INPUT EXAMPLES
// =============================================================================

class OTPExamples extends StatelessWidget {
  const OTPExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmallAppText('Standard OTP Input (6 digits)'),
        vSpace(12),
        OTPTextField(
          length: 6,
          onCompleted: (code) => print('OTP entered: $code'),
          onChanged: (value) => print('Current: $value'),
        ),
        vSpace(24),

        SmallAppText('Underline Style OTP'),
        vSpace(12),
        OTPTextField(
          length: 4,
          style: OTPStyle.underline,
          onCompleted: (code) => print('PIN: $code'),
        ),
        vSpace(24),

        SmallAppText('Filled Style with Custom Colors'),
        vSpace(12),
        OTPTextField(
          length: 6,
          style: OTPStyle.filled,
          fillColor: Colors.grey[200],
          focusedBorderColor: Colors.teal,
          onCompleted: (code) => print('Code: $code'),
        ),
        vSpace(24),

        SmallAppText('Circle Style'),
        vSpace(12),
        OTPTextField(
          length: 4,
          style: OTPStyle.circle,
          defaultBorderColor: Colors.purple,
          focusedBorderColor: Colors.deepPurple,
          onCompleted: (code) => print('Circle OTP: $code'),
        ),
      ],
    );
  }
}

// =============================================================================
// SEARCH BAR EXAMPLES
// =============================================================================

class SearchBarExamples extends StatelessWidget {
  const SearchBarExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmallAppText('Standard Search Bar'),
        vSpace(8),
        CustomSearchBar(
          hintText: 'Search products...',
          onSearch: (query) => print('Search: $query'),
          onChanged: (value) => print('Changed: $value'),
          showClearButton: true,
        ),
        vSpace(16),

        SmallAppText('Pill Style with Voice Search'),
        vSpace(8),
        CustomSearchBar(
          style: SearchBarStyle.pill,
          hintText: 'Voice search enabled',
          showVoiceButton: true,
          onVoiceSearch: () => print('Voice search tapped'),
          onSearch: (q) => print('Search: $q'),
        ),
        vSpace(16),

        SmallAppText('Filterable Search Bar'),
        vSpace(8),
        FilterableSearchBar(
          filters: const ['All', 'Products', 'Users', 'Orders'],
          selectedFilter: 'All',
          onFilterChanged: (filter) => print('Filter: $filter'),
          onSearch: (query) => print('Search with filter: $query'),
        ),
        vSpace(16),

        SmallAppText('Expandable Search Bar'),
        vSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ExpandableSearchBar(
              hintText: 'Tap to expand...',
              expandedWidth: 250,
              onSearch: (query) => print('Expandable search: $query'),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// UTILITY EXAMPLES
// =============================================================================

class UtilityExamples extends StatelessWidget {
  const UtilityExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Spacing utilities
        BigAppText('Spacing Utilities'),
        vSpace(8),
        Container(
          padding: simPad(12, 16), // Symmetric padding
          color: Colors.grey[200],
          child: Column(
            children: [
              SmallAppText('vSpace(12) - Vertical space'),
              vSpace(12),
              SmallAppText('hSpace(8) - Horizontal space (in Row)'),
              Row(
                children: [
                  const Icon(Icons.star),
                  hSpace(8),
                  const Icon(Icons.star),
                ],
              ),
              vSpace(8),
              SmallAppText('simPad(v, h) - Symmetric padding'),
            ],
          ),
        ),
        vSpace(24),

        // Form Validators
        BigAppText('Form Validators'),
        vSpace(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallAppText('• FormValidator.isValidEmail'),
            SmallAppText('• FormValidator.isValidPassword'),
            SmallAppText('• FormValidator.isValidPhone'),
            SmallAppText('• FormValidator.isValidFullName'),
            SmallAppText('• FormValidator.isValidName'),
            SmallAppText('• FormValidator.isValidUsername'),
          ],
        ),
        vSpace(16),

        // Validator demo
        AppTextField(
          label: 'Email Validation Demo',
          hint: 'test@example.com',
          validator: FormValidator.isValidEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        vSpace(24),

        // Logging
        BigAppText('Logging Utility'),
        vSpace(8),
        AppElevatedButton(
          title: 'Log Message',
          onPressed: () {
            appLog('User action', {
              'screen': 'example',
              'action': 'button_tap',
            });
          },
        ),
      ],
    );
  }
}
// =============================================================================
// LOCATION DROPDOWN EXAMPLES
// =============================================================================

class LocationDropdownExamples extends StatefulWidget {
  const LocationDropdownExamples({super.key});

  @override
  State<LocationDropdownExamples> createState() =>
      _LocationDropdownExamplesState();
}

class _LocationDropdownExamplesState extends State<LocationDropdownExamples> {
  csc.Country? _selectedCountry;
  csc.State? _selectedState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigAppText('1. Chained Selection'),
        vSpace(8),
        SmallAppText(
          'Selecting country filters states, selecting state filters cities.',
        ),
        vSpace(12),

        CountryDropdown(
          label: 'Select Country',
          value: _selectedCountry,
          onChanged: (country) {
            setState(() {
              _selectedCountry = country;
              _selectedState = null;
            });
            print('Selected: ${country?.name}');
          },
        ),
        vSpace(16),

        StateDropdown(
          label: 'Select State / Region',
          country: _selectedCountry,
          value: _selectedState,
          onChanged: (state) {
            setState(() {
              _selectedState = state;
            });
            print('Selected State: ${state?.name}');
          },
        ),
        vSpace(16),

        CityDropdown(
          label: 'Select City / LGA',
          country: _selectedCountry,
          state: _selectedState,
          onChanged: (city) {
            print('Selected City: ${city?.name}');
          },
        ),

        vSpace(32),
        Divider(),
        vSpace(16),

        BigAppText('2. Independent Usage (e.g., Nigeria Only)'),
        vSpace(8),
        SmallAppText(
          'You can use StateDropdown without a selectable CountryDropdown if you provide a fixed country object. This example fixes the country to Nigeria to show the custom LGA data.',
        ),
        vSpace(12),

        // Example: Independent State for Nigeria
        StateDropdown(
          label: 'Select State (Nigeria Only)',
          // Manually constructing a Country object for Nigeria
          country: csc.Country(
            name: 'Nigeria',
            isoCode: 'NG',
            phoneCode: '234',
            currency: 'NGN',
            flag: '🇳🇬',
            latitude: '',
            longitude: '',
          ),
          value: _independentState,
          onChanged: (val) {
            setState(() {
              _independentState = val;
              _independentCity = null;
            });
          },
        ),
        vSpace(16),

        // City/LGA for the independent state
        CityDropdown(
          label: 'Select LGA (Official List)',
          country: csc.Country(
            name: 'Nigeria',
            isoCode: 'NG',
            phoneCode: '234',
            currency: 'NGN',
            flag: '🇳🇬',
            latitude: '',
            longitude: '',
          ),
          state: _independentState,
          value: _independentCity,
          onChanged: (val) => setState(() => _independentCity = val),
        ),

        vSpace(24),
        Divider(),
        vSpace(16),

        BigAppText('3. Independent Usage (e.g., USA Only)'),
        vSpace(8),
        SmallAppText('Example for United States, using default package data.'),
        vSpace(12),

        // Example: Independent State for US
        StateDropdown(
          label: 'Select State (USA Only)',
          country: csc.Country(
            name: 'United States',
            isoCode: 'US',
            phoneCode: '1',
            currency: 'USD',
            flag: '🇺🇸',
            latitude: '',
            longitude: '',
          ),
          value: _usState,
          onChanged: (val) {
            setState(() {
              _usState = val;
              _usCity = null;
            });
          },
        ),
        vSpace(16),

        CityDropdown(
          label: 'Select City',
          country: csc.Country(
            name: 'United States',
            isoCode: 'US',
            phoneCode: '1',
            currency: 'USD',
            flag: '🇺🇸',
            latitude: '',
            longitude: '',
          ),
          state: _usState,
          value: _usCity,
          onChanged: (val) => setState(() => _usCity = val),
        ),
      ],
    );
  }

  csc.State? _independentState;
  csc.City? _independentCity;

  csc.State? _usState;
  csc.City? _usCity;
}
