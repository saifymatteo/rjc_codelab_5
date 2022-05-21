import 'package:flutter/material.dart';
import 'package:rjc_codelab_5/views/pages/deposit_page.dart';
import 'package:rjc_codelab_5/views/pages/expenses_page.dart';
import 'package:rjc_codelab_5/views/pages/login_page.dart';
import 'package:rjc_codelab_5/views/pages/main_page.dart';
import 'package:rjc_codelab_5/views/pages/register_page.dart';
import 'package:rjc_codelab_5/views/pages/splash_page.dart';
import 'package:rjc_codelab_5/views/pages/withdraw_page.dart';

abstract class AppRouteName {
  static const String index = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String deposit = '/deposit';
  static const String withdraw = '/withdraw';
  static const String expenses = '/expenses';
}

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    AppRouteName.index: (context) => const FlutterBankSplashPage(),
    AppRouteName.login: (context) => const FlutterBankLoginPage(),
    AppRouteName.register: (context) => const FlutterBankRegisterPage(),
    AppRouteName.main: (context) => const FlutterBankMainPage(),
    AppRouteName.deposit: (context) => const FlutterBankDepositPage(),
    AppRouteName.withdraw: (context) => const FlutterBankWithdrawalPage(),
    AppRouteName.expenses: (context) => const FlutterBankExpensesPage(),
  };
}