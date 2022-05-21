import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/models/expense_model.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    Key? key,
    this.expense,
    this.onDeleteExpense,
  }) : super(key: key);

  final Expense? expense;
  final Function? onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense!.name!,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  const Icon(
                    AppIcon.coin,
                    color: AppColor.mainThemeColor,
                    size: 20,
                  ),
                  Text(
                    '\$${expense!.amount!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat.yMd()
                    .add_jm()
                    .format(DateTime.parse(expense!.timestamp!)),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  onDeleteExpense!();
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
