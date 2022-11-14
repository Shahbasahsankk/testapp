import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../widgets/custom_textformfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Image(
                    image: AssetImage(
                      'assets/download-removebg-preview (1).png',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    controller: loginProvider.userNameController,
                    obscure: false,
                    icon: Icons.person,
                    hint: 'Enter Username or Email',
                    validator: (value) =>
                        loginProvider.userNameValidation(value),
                    textCapitalization: TextCapitalization.none,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    action: TextInputAction.done,
                    controller: loginProvider.passwordController,
                    obscure: true,
                    icon: Icons.lock,
                    hint: 'Enter Password',
                    validator: (value) =>
                        loginProvider.passwordValidation(value),
                    textCapitalization: TextCapitalization.none,
                  ),
                  const SizedBox(height: 30),
                  Consumer<LoginProvider>(builder: (context, values, _) {
                    return values.signingIn == true
                        ? const CircularProgressIndicator()
                        : Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue,
                            ),
                            child: TextButton(
                              onPressed: () =>
                                  values.login(context, formKey.currentState!),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
