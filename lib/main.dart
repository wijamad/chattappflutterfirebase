import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'app/utils/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black,
  );
  await SystemChannels.platform.invokeMethod<void>(
    'SystemChrome.restoreSystemUIOverlays',
    true,
  );
  SystemChrome.restoreSystemUIOverlays();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: "ChatAPP",
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.white,
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.red[900],
              ),
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
            ).copyWith(
              colorScheme:
                  ThemeData().colorScheme.copyWith(secondary: Colors.black),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Color(0xFF686D76),
            ),
            initialRoute: authC.isSkipIntro.isTrue
                ? authC.isAuth.isTrue
                    ? Routes.HOME
                    : Routes.LOGIN
                : Routes.INTRODUCTION,
            getPages: AppPages.routes,
          );
        }
        return FutureBuilder(
          future: authC.firstInitialized(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );
  }
}
