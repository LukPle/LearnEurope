import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/stores/password_field_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/input_field.dart';

import '../../firebase/db_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late PasswordFieldStore passwordFieldStore;
  final DatabaseServices _dbServices = DatabaseServices();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFieldStore = PasswordFieldStore();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppAppBar(),
      body: Observer(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.signupTitle, style: AppTextStyles.standardTitleTextStyle),
              const SizedBox(height: AppPaddings.padding_24),
              InputField(
                controller: emailController,
                title: AppStrings.emailTitle,
                hint: AppStrings.emailHint,
                prefixIcon: Icons.alternate_email,
              ),
              const SizedBox(height: AppPaddings.padding_16),
              InputField(
                controller: passwordController,
                title: AppStrings.passwordTitle,
                hint: AppStrings.passwordHint,
                prefixIcon: Icons.lock,
                suffixIcon: passwordFieldStore.isVisible ? Icons.visibility : Icons.visibility_off,
                suffixAction: () => passwordFieldStore.toggleVisibility(),
                hideInput: passwordFieldStore.isVisible ? false : true,
              ),
              const SizedBox(height: AppPaddings.padding_16),
              InputField(
                controller: nameController,
                title: AppStrings.nameTitle,
                hint: AppStrings.nameHint,
                prefixIcon: Icons.person,
                maxLength: 12,
              ),
              const Spacer(),
              CtaButton.primary(
                onPressed: () {
                  if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && nameController.text.isNotEmpty) {
                    _dbServices.createUser(emailController.text, passwordController.text, nameController.text)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User successfully created'))
                      );
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create user: $e'))
                      );
                    });
                  }
                },
                label: AppStrings.signupButton,
              ),
            ],
          );
        },
      ),
    );
  }
}
