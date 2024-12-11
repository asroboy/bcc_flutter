import 'dart:developer';
import 'dart:io';

import 'package:bcc/contants.dart';
import 'package:bcc/providers/bcc_provider.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:bcc/screen/pencaker/dashboard_tab_pencaker.dart';
import 'package:bcc/screen/perusahaan/dashboard_tab_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'my_http_override.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          log('$request');
          return null;
        },
      ));
    }
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BccProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bogor Career Center',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Constants.colorBiruGelap, foregroundColor: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Constants.colorBiruMuda;
                      }
                      return Constants.colorBiruGelap;
                    },
                  ),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white))),
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Constants.colorBiruGelap,
              onPrimary: Colors.white,
              secondary: Colors.blue,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87)),
      home: _goToMainPage(),
    );
  }

  _goToMainPage() {
    final storage = GetStorage();
    dynamic loginInfo = storage.read(Constants.loginInfo);
    String userType =
        storage.read(Constants.userType) ?? Constants.userPencaker;
    if (loginInfo != null) {
      if (userType == Constants.userPencaker) {
        return const DashboardTabPencaker();
      }
      if (userType == Constants.userPerusahaan) {
        return const DashboardTabPerusahaan();
      }
    } else {
      return const LandingTab();
    }
  }
}
