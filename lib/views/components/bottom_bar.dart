import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/repositories/bottom_bar_repo.dart';

import '../../data/models/bottom_bar_model.dart';

class FlutterBankBottomBar extends StatelessWidget {
  const FlutterBankBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlutterBankBottomBarModel> bottomItems =
        FlutterBankBottomBarRepo.getBottomBarItems(context);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.mainThemeColor.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(bottomItems.length, (index) {
          FlutterBankBottomBarModel currentItem = bottomItems[index];
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              highlightColor: AppColor.mainThemeColor.withOpacity(0.2),
              splashColor: AppColor.mainThemeColor.withOpacity(0.1),
              onTap: currentItem.action,
              child: Container(
                constraints: const BoxConstraints(minWidth: 80),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      currentItem.icon,
                      color: AppColor.mainThemeColor,
                      size: 20,
                    ),
                    Text(
                      currentItem.label!,
                      style: const TextStyle(
                        color: AppColor.mainThemeColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
