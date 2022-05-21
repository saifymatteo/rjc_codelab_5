import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/views/routes/routes.dart';

class FlutterBankSplashPage extends StatelessWidget {
  const FlutterBankSplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(AppRouteName.login);
    });

    return Scaffold(
      backgroundColor: AppColor.mainThemeColor,
      body: Stack(
        children: const [
          Center(
            child: Icon(
              AppIcon.mainIcon,
              color: Colors.white,
              size: 60,
            ),
          ),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
