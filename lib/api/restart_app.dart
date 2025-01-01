import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class RestartApp extends StatefulWidget {
  const RestartApp({Key? key, this.child}) : super(key: key);

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartAppState>()?.restartApp();
  }

  static void logoutAndRestart(BuildContext context) {
    GetStorage().remove(Constants.userType);
    GetStorage().remove(Constants.loginInfo).then(
      (value) {
        if (context.mounted) {
          RestartApp.restartApp(context);
        }
      },
    );
    context.findAncestorStateOfType<_RestartAppState>()?.restartApp();
  }

  @override
  State<RestartApp> createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child ?? Container(),
    );
  }
}
