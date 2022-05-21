import 'package:flutter/cupertino.dart';

class WithdrawalService extends ChangeNotifier {
  double amountToWithdraw = 0;

  void setAmountToWithdraw(double amount) {
    amountToWithdraw = amount;
    notifyListeners();
  }

  void resetWithdrawalService() {
    amountToWithdraw = 0;
    notifyListeners();
  }

  bool get checkAmountToWithdraw => amountToWithdraw > 0;
}
