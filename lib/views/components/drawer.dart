import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/views/components/dialog.dart';

class FlutterBankDrawer extends StatelessWidget {
  const FlutterBankDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.mainThemeColor,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            AppIcon.mainIcon,
            color: Colors.white,
            size: 60,
          ),
          const SizedBox(height: 40),
          Material(
            color: Colors.transparent,
            child: TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                AppDialog.signOutDialog(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.white.withOpacity(0.1),
                ),
              ),
              child: const Text(
                'Sign Out',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
