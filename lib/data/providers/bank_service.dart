import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/data/models/account_model.dart';
import 'package:rjc_codelab_5/data/models/expense_model.dart';
import 'package:rjc_codelab_5/data/providers/deposit_service.dart';
import 'package:rjc_codelab_5/data/providers/login_service.dart';
import 'package:rjc_codelab_5/data/providers/withdrawal_service.dart';

class FlutterBankService extends ChangeNotifier {
  Account? selectedAccount;
  List<Expense> expenses = [];

  //* getAccounts method
  Account? get getSelectedAccount => selectedAccount;

  void setSelectedAccount(Account? account) {
    selectedAccount = account;
    notifyListeners();
  }

  void resetSelections() => setSelectedAccount(null);

  Future<List<Account>> getAccounts(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId;

    List<Account> accounts = [];

    Completer<List<Account>> accountsCompleter = Completer();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .get()
        .then(
      (snapshot) {
        for (var doc in snapshot.docs) {
          Account account = Account.fromJson(doc.data(), doc.id);
          accounts.add(account);
        }

        Future.delayed(const Duration(seconds: 1), () {
          accountsCompleter.complete(accounts);
        });
      },
      onError: (error) {
        accountsCompleter.completeError({'error': error});
      },
    );

    return accountsCompleter.future;
  }

  //* Expenses method
  void addExpense(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId;

    CollectionReference expensesCollection = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_expenses');

    expensesCollection
        .add({
          'amount': 100,
          'timestamp': DateTime.now().toIso8601String(),
          'name': 'Sample Expense',
        })
        .then((value) => debugPrint('document added'))
        .onError((error, stackTrace) => debugPrint('error during adding'));
  }

  void deleteExpense(BuildContext context, String expenseId) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId;

    DocumentReference expensesToDelete = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_expenses')
        .doc(expenseId);

    expensesToDelete
        .delete()
        .then((value) => debugPrint('document deleted'))
        .onError(
            (error, stackTrace) => debugPrint('error while deleting document'));
  }

  Stream<List<Expense>> getExpenses(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId;

    var controller = StreamController<List<Expense>>();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_expenses')
        .snapshots()
        .listen(
      (QuerySnapshot collection) {
        expenses.clear();
        for (var doc in collection.docs) {
          var expenseJson = doc.data() as Map<String, dynamic>;
          expenses.add(Expense.fromJson(expenseJson, doc.id));
        }

        controller.add(expenses);
      },
    );

    return controller.stream;
  }

  //* Deposit method
  Future<bool> performDeposit(BuildContext context) {
    Completer<bool> depositComplete = Completer();

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId;

    DepositService depositService =
        Provider.of<DepositService>(context, listen: false);
    int amountToDeposit = depositService.amountToDeposit.toInt();

    DocumentReference doc = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .doc(selectedAccount!.id!);

    doc.update(
      {
        'balance': selectedAccount!.balance! + amountToDeposit,
      },
    ).then(
      (value) {
        depositService.resetDepositService();
        depositComplete.complete(true);
      },
      onError: (error) {
        depositComplete.completeError({'error': error});
      },
    );

    return depositComplete.future;
  }

  //* Withdrawal method
  Future<bool> performWithdrawal(BuildContext context) {
    Completer<bool> withdrawComplete = Completer();

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId;

    WithdrawalService withdrawService =
        Provider.of<WithdrawalService>(context, listen: false);
    int amountToWithdraw = withdrawService.amountToWithdraw.toInt();

    DocumentReference doc = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .doc(selectedAccount!.id!);

    doc.update({'balance': selectedAccount!.balance! - amountToWithdraw}).then(
      (value) {
        withdrawService.resetWithdrawalService();
        withdrawComplete.complete(true);
      },
      onError: (error) {
        withdrawComplete.completeError({'error': error});
      },
    );

    return withdrawComplete.future;
  }
}
