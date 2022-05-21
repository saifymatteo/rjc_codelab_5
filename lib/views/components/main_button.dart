import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/constants.dart';

class FlutterBankMainButton extends StatelessWidget {
  const FlutterBankMainButton({
    Key? key,
    this.onTap,
    this.label,
    this.enabled,
    this.icon,
    this.backgroundColor = AppColor.mainThemeColor,
    this.iconColor = Colors.white,
    this.labelColor = Colors.white,
  }) : super(key: key);

  final void Function()? onTap;
  final String? label;
  final bool? enabled;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            color:
                enabled! ? backgroundColor : backgroundColor!.withOpacity(0.5),
            child: InkWell(
              onTap: enabled! ? onTap! : null,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: icon != null,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Icon(icon, color: iconColor, size: 20),
                      ),
                    ),
                    Text(
                      label!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: labelColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
