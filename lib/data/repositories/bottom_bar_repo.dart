import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/data/models/bottom_bar_model.dart';
import 'package:rjc_codelab_5/views/routes/routes.dart';

abstract class FlutterBankBottomBarRepo {
  static List<FlutterBankBottomBarModel> getBottomBarItems(
      BuildContext context) {
    return [
      FlutterBankBottomBarModel(
        label: 'Withdraw',
        icon: Icons.logout_rounded,
        action: () {
          Navigator.of(context).pushNamed(AppRouteName.withdraw);
        },
      ),
      FlutterBankBottomBarModel(
        label: 'Deposit',
        icon: Icons.login_rounded,
        action: () {
          Navigator.of(context).pushNamed(AppRouteName.deposit);
        },
      ),
      FlutterBankBottomBarModel(
        label: 'Expenses',
        icon: Icons.payment_rounded,
        action: () {
          Navigator.of(context).pushNamed(AppRouteName.expenses);
        },
      ),
    ];
  }
}
