import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants/app_sizedboxes.dart';

import '../../providers/add_user_provider.dart';
import '../widgets/custom_textformfield.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addUserProvider =
        Provider.of<AddUserProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addUserProvider.clearControllers();
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images-removebg-preview (1).png'),
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.name,
                    action: TextInputAction.next,
                    controller: addUserProvider.firstNameController,
                    validator: (value) =>
                        addUserProvider.nameValidation(value, 'first name'),
                    obscure: false,
                    icon: Icons.person_pin_rounded,
                    hint: 'Enter first name',
                    textCapitalization: TextCapitalization.words,
                  ),
                  AppsizedBoxes.sizedboxH10,
                  CustomTextFormField(
                    keyboardType: TextInputType.name,
                    action: TextInputAction.next,
                    controller: addUserProvider.lastNameController,
                    validator: (value) =>
                        addUserProvider.nameValidation(value, 'last name'),
                    obscure: false,
                    icon: Icons.person_pin_rounded,
                    hint: 'Enter last name',
                    textCapitalization: TextCapitalization.words,
                  ),
                  AppsizedBoxes.sizedboxH10,
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.done,
                    controller: addUserProvider.emailController,
                    validator: (value) =>
                        addUserProvider.emailValidation(value),
                    obscure: false,
                    icon: Icons.mail,
                    hint: 'Enter email address',
                    textCapitalization: TextCapitalization.none,
                  ),
                  AppsizedBoxes.sizedboxH10,
                  Consumer<AddUserProvider>(builder: (context, values, _) {
                    return values.saving == true
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: const Size(73, 30),
                                ),
                                onPressed: () => values.save(
                                  context,
                                  formKey.currentState!,
                                ),
                                child: const Text('Save'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: const Size(40, 30),
                                ),
                                onPressed: () => values.cancel(context),
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
