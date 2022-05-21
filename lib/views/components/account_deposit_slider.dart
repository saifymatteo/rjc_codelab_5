import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/colors.dart';
import 'package:rjc_codelab_5/data/providers/deposit_service.dart';

class AccountDepositSlider extends StatelessWidget {
  const AccountDepositSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DepositService>(
      builder: (_, provider, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Amount To Deposit',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              '\$${provider.amountToDeposit.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 60,
              ),
            ),
            Slider(
              value: provider.amountToDeposit,
              max: 1000,
              activeColor: AppColor.mainThemeColor,
              inactiveColor: Colors.grey.withOpacity(0.5),
              thumbColor: AppColor.mainThemeColor,
              onChanged: (value) {
                provider.setAmountToDeposit(value);
              },
            ),
          ],
        );
      },
    );
  }
}
