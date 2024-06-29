import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/config/route/paths.dart';
import 'package:shoesly_components/shoesly_componenets.dart';

class LogoutAlertDialogue {
  static Future<bool?> showAlert(
    BuildContext context,
  ) async {
    return showDialog<bool?>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: const Text('Logout ?'),
        content: const Text(''),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Confirm'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showLoginAlert(
    BuildContext context,
  ) async {
    return showDialog<bool?>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        content: Text(
          'You need to login first',
          style: textTheme(context).bodyLarge?.copyWith(
              color: colorScheme(context).secondary,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, true),
          ),
          TextButton(
            child: const Text('Login'),
            onPressed: () {
              Navigator.pop(context);
              context.push(Paths.loginScreenRoute.path);
            },
          ),
        ],
      ),
    );
  }
}
