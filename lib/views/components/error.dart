import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/colors.dart';

class FlutterBankError extends StatelessWidget {
  const FlutterBankError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.warning_outlined,
            color: AppColor.mainThemeColor,
            size: 80,
          ),
          SizedBox(height: 20),
          Text(
            'Error fetching data',
            style: TextStyle(
              color: AppColor.mainThemeColor,
              fontSize: 20,
            ),
          ),
          Text(
            'Please try again',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
