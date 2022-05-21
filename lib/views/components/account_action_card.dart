import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/colors.dart';
import 'package:rjc_codelab_5/data/models/account_model.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';

class AccountActionCard extends StatelessWidget {
  const AccountActionCard({
    Key? key,
    this.accounts,
    this.selectedAccount,
  }) : super(key: key);

  final List<Account>? accounts;
  final Account? selectedAccount;

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService =
        Provider.of<FlutterBankService>(context, listen: false);

    return Row(
      children: List.generate(accounts!.length, (index) {
        Account currentAccount = accounts![index];

        return Expanded(
          child: GestureDetector(
            onTap: () {
              bankService.setSelectedAccount(currentAccount);
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0.0, 5.0),
                  ),
                ],
                border: Border.all(
                  width: 5,
                  color: selectedAccount != null &&
                          selectedAccount!.id == currentAccount.id
                      ? AppColor.mainThemeColor
                      : Colors.transparent,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentAccount.type!.toUpperCase()} ACCT',
                    style: const TextStyle(color: AppColor.mainThemeColor),
                  ),
                  Text(currentAccount.accountNumber!),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
