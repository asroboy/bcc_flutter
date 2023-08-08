import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

void showAlertDialogWithTitle(
    String title, String content, BuildContext context) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    ),
  );
}

/// This dialog will basically show up right on top of the webview.
///
/// AlertDialog is a widget, so it needs to be wrapped in `WebViewAware`, in order
/// to be able to interact (on web) with it.
///
/// Read the `Readme.md` for more info.
void showAlertDialog(String content, BuildContext context) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: Text(content),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    ),
  );
}

void showAlertDialogWithTitleAndAction(
    String title, String content, BuildContext context, action, String text) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: action,
            child: Text(text),
            style: ElevatedButton.styleFrom(),
          ),
        ],
      ),
    ),
  );
}

void showAlertDialogWithAction(
    String content, BuildContext context, action, String text) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: action,
            child: Text(text),
            style: ElevatedButton.styleFrom(),
          ),
        ],
      ),
    ),
  );
}

void showAlertDialogWithAction2(String content, BuildContext context, action1,
    action2, String text1, String text2) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: Text(content),
        actions: [
          ElevatedButton.icon(
            onPressed: action1,
            label: Text(text1),
            icon: const Icon(Icons.cancel),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
          ),
          ElevatedButton.icon(
            onPressed: action2,
            label: Text(text2),
            icon: const Icon(Icons.check_circle_sharp),
            style: ElevatedButton.styleFrom(),
          ),
        ],
      ),
    ),
  );
}

void showAlertDialogWithTitleAndMultipleActions(String title, Widget content,
    BuildContext context, List<Widget> actionButtons) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: content,
        title: Text(title),
        actions: actionButtons,
      ),
    ),
  );
}

void showAlertDialogWithActionHapus(String content, BuildContext context,
    action1, action2, String text1, String text2) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: Text(content),
        actions: [
          ElevatedButton.icon(
            onPressed: action1,
            label: Text(text1),
            icon: const Icon(Icons.cancel),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
          ),
          ElevatedButton.icon(
            onPressed: action2,
            label: Text(text2),
            icon: const Icon(Icons.check_circle_sharp),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    ),
  );
}

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 1),
      ),
    );
}

Widget createButton({
  VoidCallback? onTap,
  required String text,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    ),
    child: Text(text),
  );
}
