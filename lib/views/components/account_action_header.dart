import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AccountActionHeader extends StatelessWidget {
  const AccountActionHeader({
    Key? key,
    this.icon,
    this.title,
  }) : super(key: key);

  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: AppColor.mainThemeColor, size: 30),
          const SizedBox(width: 10),
          Text(
            title!,
            style: const TextStyle(
              color: AppColor.mainThemeColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
