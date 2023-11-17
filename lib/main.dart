import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/generated/l10n.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';

import 'package:meetroombooking/src/config/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LanguageController>();
    return GetBuilder<LanguageController>(
      init: controller,
      builder: (_) {
        print(controller.locale);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            fontFamily: 'KantumruyPro',
          ),
          localizationsDelegates: const [
            L.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: L.delegate.supportedLocales,
          locale: controller.locale.value,
          routerConfig: router,
        );
      },
    );
  }
}
