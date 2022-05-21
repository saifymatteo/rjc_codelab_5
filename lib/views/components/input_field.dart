import 'package:flutter/material.dart';

import '../../constants/constants.dart';

Widget generateInputField({
  required String hintText,
  required IconData iconData,
  required TextEditingController controller,
  required bool isPasswordField,
  required void Function(String) onChanged,
}) {
  return Container(
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(50),
    ),
    child: TextField(
      onChanged: (value) {
        onChanged(value);
      },
      obscureText: isPasswordField,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          iconData,
          color: AppColor.mainThemeColor,
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
        hintText: hintText,
      ),
      style: const TextStyle(fontSize: 16),
      controller: controller,
    ),
  );
}
