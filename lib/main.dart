import 'package:edc_document_archieve/gen/assets.gen.dart';
import 'package:edc_document_archieve/gen/fonts.gen.dart';
import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/local_storage_service.dart';
import 'package:edc_document_archieve/src/ui/widgets/splash_screen.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:edc_document_archieve/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'src/ui/screens/welcome/welcome_screen.dart';

void main() {
  Injector.setup();
  LocalStorageService.setupLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EDC Document Archiving',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(
          color: const Color(0xFFF5F5F5),
        ),
      ),
      home: SplashScreen.timer(
          routeName: kWelcomeRoute,
          seconds: 5,
          navigateAfterSeconds: const WelcomeScreen(),
          title: 'Document Archive Mobile',
          image: Image.asset(Assets.images.logo.path),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: const TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red,
          loadingText: const Text('Getting ready')),
      getPages: pages,
      initialRoute: '/',
    );
  }
}
