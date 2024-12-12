import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/generated/l10n.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';
import 'package:meetroombooking/src/config/router/router.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/util/helper/local_storage/local_storage.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Get.put(LanguageController());
  await LocalStorage.init();
  await dotenv.load(fileName:".env");

  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LanguageController>();
    return GetBuilder<LanguageController>(
      init: controller,
      builder: (_) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'RoomBooking',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            fontFamily: 'KantumruyPro',
            appBarTheme: AppBarTheme(
              // backgroundColor: Colors.transparent,
              elevation: 0,
              // iconTheme: const IconThemeData(color: Colors.black),
              titleTextStyle: context.appBarTextStyle,
            ),
          ),
          localizationsDelegates: const [
            L.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L.delegate.supportedLocales,
          locale: controller.locale.value,
          routerConfig: router,
        );
      },
    );
  }
}
