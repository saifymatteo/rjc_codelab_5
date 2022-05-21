import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/constants.dart';

class FlutterBankLoading extends StatelessWidget {
  const FlutterBankLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: const [
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation(AppColor.mainThemeColor),
                ),
              ),
            ),
            Center(
              child: Icon(
                AppIcon.mainIcon,
                color: AppColor.mainThemeColor,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
