import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/data/providers/withdrawal_service.dart';

import '../../constants/constants.dart';

class AccountWithdrawalSlider extends StatelessWidget {
  const AccountWithdrawalSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FlutterBankService>(
      builder: (_, bankService, __) {
        return Consumer<WithdrawalService>(
          builder: (_, withdrawService, __) {
            double amountToWithdraw = withdrawService.amountToWithdraw;
            double currentBalance = bankService.selectedAccount!.balance!;
            double actualAmount = amountToWithdraw > currentBalance
                ? currentBalance
                : amountToWithdraw;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Amount To Withdraw',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '\$${actualAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                  ),
                ),
                Slider(
                  value: actualAmount,
                  max: bankService.selectedAccount!.balance!,
                  activeColor: AppColor.mainThemeColor,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                  thumbColor: AppColor.mainThemeColor,
                  onChanged: (value) {
                    withdrawService.setAmountToWithdraw(value);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
