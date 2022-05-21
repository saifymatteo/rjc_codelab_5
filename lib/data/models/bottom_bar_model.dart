import 'package:flutter/material.dart';

class FlutterBankBottomBarModel {
  String? label;
  IconData? icon;
  void Function()? action;

  FlutterBankBottomBarModel({this.action, this.icon, this.label});
}
