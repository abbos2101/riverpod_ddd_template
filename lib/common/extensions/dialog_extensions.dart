import 'package:flutter/cupertino.dart';
import 'package:riverpod_ddd_template/common/localization/localization.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmTitle,
  String? cancelTitle,
}) async {
  final result = await showCupertinoDialog<bool?>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text(cancelTitle ?? Words.no.str),
          onPressed: () => Navigator.pop(context, false),
        ),
        CupertinoDialogAction(
          isDestructiveAction: false,
          child: Text(confirmTitle ?? Words.yes.str),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<bool> showRequiredDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? buttonTitle,
}) async {
  final result = await showCupertinoDialog<bool?>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: false,
          child: Text(buttonTitle ?? Words.yes.str),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  );
  return result ?? false;
}
