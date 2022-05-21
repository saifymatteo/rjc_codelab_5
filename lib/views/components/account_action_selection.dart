import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/models/account_model.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/views/components/account_action_card.dart';
import 'package:rjc_codelab_5/views/components/error.dart';
import 'package:rjc_codelab_5/views/components/loading.dart';

class AccountActionSelection extends StatelessWidget {
  const AccountActionSelection({
    Key? key,
    this.actionTypeLabel,
    required this.amountChanger,
  }) : super(key: key);

  final String? actionTypeLabel;
  final Widget? amountChanger;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlutterBankService>(
      builder: (context, provider, __) {
        return FutureBuilder(
          // Pass in context to get Provider.of(context)
          future: provider.getAccounts(context),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const FlutterBankLoading();
            }

            if (snapshot.hasError) {
              return const FlutterBankError();
            }

            Account? selectedAccount = provider.getSelectedAccount;
            List<Account> accounts = snapshot.data as List<Account>;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actionTypeLabel!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                AccountActionCard(
                  selectedAccount: selectedAccount,
                  accounts: accounts,
                ),
                Expanded(
                  child: Visibility(
                    visible: selectedAccount != null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: const Text(
                            'Current Balance',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              AppIcon.coin,
                              color: AppColor.mainThemeColor,
                              size: 25,
                            ),
                            Text(
                              selectedAccount != null
                                  ? '\$${selectedAccount.balance!.toStringAsFixed(2)}'
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: amountChanger!),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
