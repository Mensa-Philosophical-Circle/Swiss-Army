import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'app/bindings/root_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/constants/app_constants.dart';
import 'app/utils/localization/app_translations.dart';
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
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        initialBinding: RootBinding(),
        getPages: AppPages.routes,
        unknownRoute: AppPages.unknown,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        translations: AppTranslations(),
        locale: Get.deviceLocale ?? AppTranslations.defaultLocale,
        fallbackLocale: AppTranslations.defaultLocale,
      ),
    );
  }
}
