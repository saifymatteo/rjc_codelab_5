import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/constants/constants.dart';
import 'package:rjc_codelab_5/data/providers/login_service.dart';
import 'package:rjc_codelab_5/helpers/validation.dart';
import 'package:rjc_codelab_5/views/components/input_field.dart';
import 'package:rjc_codelab_5/views/components/main_button.dart';

class FlutterBankRegisterPage extends StatefulWidget {
  const FlutterBankRegisterPage({Key? key}) : super(key: key);

  @override
  State<FlutterBankRegisterPage> createState() =>
      _FlutterBankRegisterPageState();
}

class _FlutterBankRegisterPageState extends State<FlutterBankRegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool validateFormFields() {
    return AppValidation.validateEmail(usernameController.value.text) &&
        usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        confirmPasswordController.value.text.isNotEmpty &&
        (passwordController.value.text == confirmPasswordController.value.text);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColor.mainThemeColor),
        centerTitle: true,
        title: const Icon(AppIcon.mainIcon, size: 40),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Consumer<LoginService>(
          builder: (_, provider, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: const Text(
                          'Create New Account',
                          style: TextStyle(
                            color: AppColor.mainThemeColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
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
                      generateInputField(
                        hintText: 'Confirm Password',
                        iconData: AppIcon.lock,
                        controller: confirmPasswordController,
                        isPasswordField: true,
                        onChanged: (value) => setState(() {}),
                      ),
                      provider.getErrorMessage.isEmpty
                          ? const SizedBox(height: 40)
                          : Container(
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
                                      provider.getErrorMessage,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                FlutterBankMainButton(
                  label: 'Register',
                  enabled: validateFormFields(),
                  onTap: () async {
                    String username = usernameController.value.text;
                    String password = passwordController.value.text;

                    bool accountCreated = await loginService
                        .createUserWithEmailAndPassword(username, password);

                    if (accountCreated) {
                      if (!mounted) return;
                      provider.setErrorMessage('');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
