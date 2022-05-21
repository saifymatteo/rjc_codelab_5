import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class FlutterBankNoExpenses extends StatelessWidget {
  const FlutterBankNoExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.payment_rounded,
            color: AppColor.mainThemeColor,
            size: 50,
          ),
          SizedBox(height: 20),
          Text(
            'There are no expenses\nat the moment.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.mainThemeColor),
          ),
        ],
      ),
    );
  }
}
