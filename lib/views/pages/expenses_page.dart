import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/models/expense_model.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/views/components/account_action_header.dart';
import 'package:rjc_codelab_5/views/components/error.dart';
import 'package:rjc_codelab_5/views/components/expense_card.dart';
import 'package:rjc_codelab_5/views/components/loading.dart';
import 'package:rjc_codelab_5/views/components/main_button.dart';

import '../components/no_expense.dart';

class FlutterBankExpensesPage extends StatelessWidget {
  const FlutterBankExpensesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService = Provider.of(context, listen: false);

    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AccountActionHeader(
              icon: Icons.payment_rounded,
              title: 'My Expenses',
            ),
            Expanded(
              child: StreamBuilder<List<Expense>>(
                stream: bankService.getExpenses(context),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return const FlutterBankLoading();
                  if (snapshot.hasError) return const FlutterBankError();

                  var expenses = snapshot.data as List<Expense>;
                  if (expenses.isEmpty) return const FlutterBankNoExpenses();

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: expenses.length,
                    itemBuilder: (_, index) {
                      var expense = expenses[index];
                      return ExpenseCard(
                        expense: expense,
                        onDeleteExpense: () {
                          bankService.deleteExpense(context, expense.id!);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            FlutterBankMainButton(
              enabled: true,
              label: 'Add Expense',
              onTap: () {
                bankService.addExpense(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
