import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/models/account_model.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/views/components/account_card.dart';
import 'package:rjc_codelab_5/views/components/bottom_bar.dart';
import 'package:rjc_codelab_5/views/components/drawer.dart';
import 'package:rjc_codelab_5/views/components/loading.dart';

import '../components/account_action_header.dart';

class FlutterBankMainPage extends StatelessWidget {
  const FlutterBankMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.mainThemeColor),
        backgroundColor: Colors.transparent,
        title: const Icon(
          AppIcon.mainIcon,
          size: 40,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const FlutterBankBottomBar(),
      drawer: const Drawer(child: FlutterBankDrawer()),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const AccountActionHeader(
              title: 'My Accounts',
              icon: AppIcon.wallet,
            ),
            Expanded(
              child: Consumer<FlutterBankService>(
                builder: (context, provider, __) {
                  return FutureBuilder(
                    future: provider.getAccounts(context),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const FlutterBankLoading();
                      }

                      if (snapshot.hasError) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Try check your Internet\nor restart the app',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      List<Account> accounts = snapshot.data as List<Account>;

                      if (accounts.isEmpty) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                AppIcon.wallet,
                                color: AppColor.mainThemeColor,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'You don\'t have any accounts\nassociated with your profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.mainThemeColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (_, index) {
                          Account account = accounts[index];
                          return AccountCard(account: account);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
