import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/data/providers/withdrawal_service.dart';
import 'package:rjc_codelab_5/views/components/account_action_header.dart';
import 'package:rjc_codelab_5/views/components/account_action_selection.dart';
import 'package:rjc_codelab_5/views/components/account_withdrawal_slider.dart';
import 'package:rjc_codelab_5/views/components/main_button.dart';
import 'package:rjc_codelab_5/views/components/transaction_completion_page.dart';

class FlutterBankWithdrawalPage extends StatelessWidget {
  const FlutterBankWithdrawalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FlutterBankService bankService =
            Provider.of<FlutterBankService>(context, listen: false);
        bankService.resetSelections();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColor.mainThemeColor),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Icon(AppIcon.mainIcon, size: 40),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AccountActionHeader(
                title: 'Withdraw',
                icon: Icons.logout_rounded,
              ),
              const Expanded(
                child: AccountActionSelection(
                  actionTypeLabel: 'From',
                  amountChanger: AccountWithdrawalSlider(),
                ),
              ),
              Consumer<WithdrawalService>(
                builder: (_, provider, __) {
                  return FlutterBankMainButton(
                    enabled: provider.checkAmountToWithdraw,
                    label: 'Make Withdrawal',
                    onTap: provider.checkAmountToWithdraw
                        ? () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const TransactionCompletionPage(
                                  isDeposit: false,
                                ),
                              ),
                            );
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
