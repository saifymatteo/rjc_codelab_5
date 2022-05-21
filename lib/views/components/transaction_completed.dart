import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/colors.dart';

class FlutterBankTransactionCompleted extends StatelessWidget {
  const FlutterBankTransactionCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.check_circle_outline_rounded,
            color: AppColor.mainThemeColor,
            size: 80,
          ),
          SizedBox(height: 20),
          Text(
            'Transaction Completed',
            style: TextStyle(
              color: AppColor.mainThemeColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
