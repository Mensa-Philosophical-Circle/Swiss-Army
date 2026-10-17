/// The files `sac install` puts in a new Flutter project: GetX folders (the layout `get create page:name`
/// works in), a theme from this package, and ready screens: splash, sign in and a bottom navigation shell.
/// Keys are paths from the project root; `{{app}}` is replaced by the project name.
const projectTemplate = <String, String>{
  'lib/main.dart': _main,
  'lib/app/bindings/root_binding.dart': _rootBinding,
  'lib/app/routes/app_pages.dart': _appPages,
  'lib/app/routes/app_routes.dart': _appRoutes,
  'lib/app/utils/theme/app_theme.dart': _appTheme,
  'lib/app/widgets/not_found_view.dart': _notFound,
  'lib/app/widgets/adaptive_bottom_nav.dart': _adaptiveBottomNav,
  'lib/app/modules/splash/bindings/splash_binding.dart': _splashBinding,
  'lib/app/modules/splash/controllers/splash_controller.dart':
      _splashController,
  'lib/app/modules/splash/views/splash_view.dart': _splashView,
  'lib/app/modules/sign_in/bindings/sign_in_binding.dart': _signInBinding,
  'lib/app/modules/sign_in/controllers/sign_in_controller.dart':
      _signInController,
  'lib/app/modules/sign_in/views/sign_in_view.dart': _signInView,
  'lib/app/modules/main/bindings/main_binding.dart': _mainBinding,
  'lib/app/modules/main/controllers/main_controller.dart': _mainController,
  'lib/app/modules/main/views/main_view.dart': _mainView,
  'lib/app/modules/home/bindings/home_binding.dart': _homeBinding,
  'lib/app/modules/home/controllers/home_controller.dart': _homeController,
  'lib/app/modules/home/views/home_view.dart': _homeView,
  'lib/app/modules/profile/bindings/profile_binding.dart': _profileBinding,
  'lib/app/modules/profile/controllers/profile_controller.dart':
      _profileController,
  'lib/app/modules/profile/views/profile_view.dart': _profileView,
  'lib/app/data/api/.gitkeep': '',
  'lib/app/data/models/.gitkeep': '',
  'lib/app/data/repositories/.gitkeep': '',
  'lib/app/data/services/.gitkeep': '',
  'lib/app/utils/constants/.gitkeep': '',
  'lib/app/utils/helpers/.gitkeep': '',
  'test/widget_test.dart': _widgetTest,
};

/// What a new `flutter create` leaves in these files; they are replaced without `--force` because nobody
/// has written anything in them yet.
const untouchedFlutterFiles = <String, List<String>>{
  'lib/main.dart': [
    'You have pushed the button this many times', // flutter create
    'Hello World!', // flutter create --empty
  ],
  'test/widget_test.dart': ['Counter increments smoke test'],
};

const _main = r'''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'app/bindings/root_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize(); // the glass look of the iOS bottom bar
  runApp(
    LiquidGlassWidgets.wrap(
      child: const MyApp(),
      adaptiveQuality: true,
      brightnessResolver: Theme.maybeBrightnessOf,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 927),
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: '{{app}}',
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        initialBinding: RootBinding(),
        getPages: AppPages.routes,
        unknownRoute: AppPages.unknown,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
''';

const _rootBinding = r'''
import 'package:get/get.dart';

/// What the whole app shares from the start: put services that live as long as the app here.
class RootBinding extends Bindings {
  @override
  void dependencies() {}
}
''';

const _appPages = r'''
// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';

import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../widgets/not_found_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  /// Where a route that does not exist lands.
  static final unknown = GetPage(
    name: '/not-found',
    page: () => const NotFoundView(),
  );

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
  ];
}
''';

const _appRoutes = r'''
// ignore_for_file: constant_identifier_names
part of 'app_pages.dart';
// `get create page:name` adds new routes here.

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const MAIN = _Paths.MAIN;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const SIGN_IN = '/sign-in';
  static const MAIN = '/main';
}
''';

const _appTheme = r'''
import 'package:flutter/material.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

/// The one place the look of the app is set. Change the colours here and every screen and every
/// swiss_army_component widget follows.
class AppTheme {
  AppTheme._();

  static const _config = SACThemeConfig(primary: Color(0xFF009788));

  static ThemeData get light => SACTheme.light(_config);
  static ThemeData get dark => SACTheme.dark(_config);
}
''';

const _notFound = r'''
import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Page not found')));
  }
}
''';

const _splashBinding = r'''
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // put, not lazyPut: nothing on the splash screen reads the controller, so a lazy one would never start.
    Get.put<SplashController>(SplashController());
  }
}
''';

const _splashController = r'''
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  static const _showFor = Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();
    // Check a saved session here and go to Routes.MAIN instead when there is one.
    Future.delayed(_showFor, () => Get.offAllNamed(Routes.SIGN_IN));
  }
}
''';

const _splashView = r'''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Replace with your logo: Image.asset('assets/logo/logo.png', width: 120.w).
            Icon(Icons.shield_outlined, size: 96.sp, color: Colors.white),
            SizedBox(height: 16.h),
            Text(
              '{{app}}',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _signInBinding = r'''
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
''';

const _signInController = r'''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;

  String? validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Enter your email';
    if (!GetUtils.isEmail(text)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter your password';
    return null;
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      // Call your sign in API here; this only pretends to, so the screen can be tried.
      await Future<void>.delayed(const Duration(milliseconds: 600));
      Get.offAllNamed(Routes.MAIN);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
''';

const _signInView = r'''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.h),
                Text('Welcome back', style: theme.textTheme.headlineMedium),
                SizedBox(height: 8.h),
                Text(
                  'Sign in to continue',
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: controller.email,
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),
                SizedBox(height: 16.h),
                AppPasswordField(
                  controller: controller.password,
                  label: 'Password',
                  hint: 'Your password',
                  validator: controller.validatePassword,
                  onSubmitted: (_) => controller.submit(),
                ),
                SizedBox(height: 32.h),
                Obx(
                  () => AppElevatedButton(
                    title: 'Sign in',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
''';

const _mainBinding = r'''
import 'package:get/get.dart';

import '../../home/bindings/home_binding.dart';
import '../../profile/bindings/profile_binding.dart';
import '../controllers/main_controller.dart';

/// The shell holds its tabs, so it sets up what each tab needs.
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    HomeBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
''';

const _mainController = r'''
import 'package:get/get.dart';

class MainController extends GetxController {
  final index = 0.obs;

  void select(int value) => index.value = value;
}
''';

const _mainView = r'''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/adaptive_bottom_nav.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/main_controller.dart';

/// The screen with the bottom navigation bar. Add a tab: one entry in [_tabs] and one in [_pages].
class MainView extends GetView<MainController> {
  const MainView({super.key});

  static const _pages = <Widget>[HomeView(), ProfileView()];

  static const _tabs = <AdaptiveNavItem>[
    AdaptiveNavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    AdaptiveNavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: controller.index.value, children: _pages),
        bottomNavigationBar: AdaptiveBottomNav(
          items: _tabs,
          selectedIndex: controller.index.value,
          onSelected: controller.select,
        ),
      ),
    );
  }
}
''';

const _adaptiveBottomNav = r'''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class AdaptiveNavItem {
  const AdaptiveNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

/// A bottom bar that looks native on each platform: liquid glass on iOS, Material 3 on Android.
class AdaptiveBottomNav extends StatelessWidget {
  const AdaptiveBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<AdaptiveNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final primary = Theme.of(context).colorScheme.primary;
      final muted = Theme.of(context).colorScheme.onSurfaceVariant;
      return GlassTabBar.bottom(
        tabs: [
          for (final item in items)
            GlassTab(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.label,
            ),
        ],
        selectedIndex: selectedIndex,
        onTabSelected: onSelected,
        selectedIconColor: primary,
        unselectedIconColor: muted,
        selectedLabelColor: primary,
        unselectedLabelColor: muted,
      );
    }
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.activeIcon),
            label: item.label,
          ),
      ],
    );
  }
}
''';

const _homeBinding = r'''
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
''';

const _homeController = r'''
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
''';

const _homeView = r'''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Text('Pressed ${controller.count.value} times')),
              SizedBox(height: 16.h),
              AppElevatedButton(
                title: 'Press me',
                onPressed: controller.increment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

const _profileBinding = r'''
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
''';

const _profileController = r'''
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  void signOut() {
    // Clear the saved session here.
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
''';

const _profileView = r'''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            const Spacer(),
            AppElevatedButton(title: 'Sign out', onPressed: controller.signOut),
          ],
        ),
      ),
    );
  }
}
''';

const _widgetTest = r'''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{package}}/main.dart';

void main() {
  testWidgets('starts on the splash screen, then asks to sign in', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('{{app}}'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
''';
