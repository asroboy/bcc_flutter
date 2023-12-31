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
      theme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Constants.colorBiruGelap,
              onPrimary: Colors.white,
              secondary: Colors.blue,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white54,
              onBackground: Colors.black87,
              surface: Colors.black87,
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
