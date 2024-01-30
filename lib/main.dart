import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:quitanda_udemy/src/config/pages_routes.dart';
import 'package:quitanda_udemy/src/pages/auth/controller/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quitanda',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const <Locale>[Locale('pt', 'BR')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.transparent),
        useMaterial3: true,
      ),
      getPages: Pages.pages,
      initialRoute: Routes.splashRoute,
    );
  }
}
