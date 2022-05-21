import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/providers/login_service.dart';
import 'package:rjc_codelab_5/views/routes/routes.dart';

abstract class AppDialog extends State {
  static void signOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'Flutter Savings Bank Logout',
            style: TextStyle(
              color: AppColor.mainThemeColor,
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Are you sure you want to log out of your account?',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final navigator = Navigator.of(ctx);

                navigator.pop();

                LoginService loginService =
                    Provider.of<LoginService>(ctx, listen: false);
                await loginService.signOut();

                navigator.pushReplacementNamed(AppRouteName.login);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColor.mainThemeColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
