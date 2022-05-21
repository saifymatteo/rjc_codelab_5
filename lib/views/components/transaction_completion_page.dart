import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/views/components/error.dart';
import 'package:rjc_codelab_5/views/components/loading.dart';
import 'package:rjc_codelab_5/views/components/transaction_completed.dart';

class TransactionCompletionPage extends StatelessWidget {
  const TransactionCompletionPage({Key? key, this.isDeposit}) : super(key: key);

  final bool? isDeposit;

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService = Provider.of(context, listen: false);

    Future.delayed(const Duration(seconds: 3), () {
      bankService.resetSelections();
      Navigator.of(context).pop();
    });

    return WillPopScope(
      onWillPop: () {
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
          title: const Icon(
            AppIcon.mainIcon,
            color: AppColor.mainThemeColor,
            size: 40,
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: isDeposit!
                ? bankService.performDeposit(context)
                : bankService.performWithdrawal(context),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const FlutterBankLoading();
              }

              if (snapshot.hasError) {
                return const FlutterBankError();
              }

              return const FlutterBankTransactionCompleted();
            },
          ),
        ),
      ),
    );
  }
}
