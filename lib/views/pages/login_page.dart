import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/helpers/validation.dart';
import 'package:rjc_codelab_5/views/components/input_field.dart';
import 'package:rjc_codelab_5/views/components/loading.dart';
import 'package:rjc_codelab_5/views/components/main_button.dart';
import 'package:rjc_codelab_5/views/routes/routes.dart';

import '../../data/providers/login_service.dart';

class FlutterBankLoginPage extends StatefulWidget {
  const FlutterBankLoginPage({Key? key}) : super(key: key);

  @override
  State<FlutterBankLoginPage> createState() => _FlutterBankLoginPageState();
}

class _FlutterBankLoginPageState extends State<FlutterBankLoginPage> {
  TextEditingController usernameController =
      TextEditingController(text: 'client@mail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  bool validateEmailAndPassword() =>
      usernameController.value.text.isNotEmpty &&
      passwordController.value.text.isNotEmpty &&
      AppValidation.validateEmail(usernameController.value.text);

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      //* Important: To allow keyboard overflow the screen
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 7,
                  color: AppColor.mainThemeColor,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                AppIcon.mainIcon,
                color: AppColor.mainThemeColor,
                size: 45,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome to',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const Text(
              'Flutter\nSavings Bank',
              style: TextStyle(
                color: AppColor.mainThemeColor,
                fontSize: 30,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sign Into Your Bank Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    generateInputField(
                      hintText: 'Email',
                      iconData: AppIcon.email,
                      controller: usernameController,
                      isPasswordField: false,
                      onChanged: (value) => setState(() {}),
                    ),
                    generateInputField(
                      hintText: 'Password',
                      iconData: AppIcon.lock,
                      controller: passwordController,
                      isPasswordField: true,
                      onChanged: (value) => setState(() {}),
                    ),
                    Consumer<LoginService>(
                      builder: (_, provider, __) {
                        String errorMsg = provider.getErrorMessage;

                        if (errorMsg.isEmpty) {
                          return const SizedBox(height: 40);
                        }

                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.warning_rounded,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  errorMsg,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            FlutterBankMainButton(
              label: 'Sign In',
              enabled: validateEmailAndPassword(),
              onTap: () async {
                final navigator = Navigator.of(context);
                var username = usernameController.value.text;
                var password = passwordController.value.text;

                showDialog(
                  context: context,
                  builder: (context) {
                    return const FlutterBankLoading();
                    // return const Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  },
                );
                bool isLoggedIn = await loginService.signInWithEmailAndPassword(
                    username, password);

                navigator.pop();

                if (isLoggedIn) {
                  usernameController.clear();
                  passwordController.clear();

                  navigator.pushReplacementNamed(AppRouteName.main);
                }
              },
            ),
            const SizedBox(height: 10),
            FlutterBankMainButton(
              label: 'Register',
              icon: AppIcon.profile,
              enabled: true,
              onTap: () {
                Navigator.of(context).pushNamed(AppRouteName.register);
              },
              backgroundColor: AppColor.mainThemeColor.withOpacity(0.05),
              iconColor: AppColor.mainThemeColor,
              labelColor: AppColor.mainThemeColor,
            ),
          ],
        ),
      ),
    );
  }
}
