import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/firebase/db_services.dart';
import 'package:learn_europe/stores/password_field_store.dart';
import 'package:learn_europe/ui/components/altert_snackbar.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/input_field.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final DatabaseServices _dbServices = DatabaseServices();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late PasswordFieldStore passwordFieldStore;

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
    bool isLoading = false;

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
                textInputType: TextInputType.emailAddress,
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
                textInputType: TextInputType.name,
                maxLength: 12,
              ),
              const Spacer(),
              CtaButton.primary(
                onPressed: () => _signup(),
                label: AppStrings.signupButton,
                loading: isLoading,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _signup() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      _dbServices
          .createUser(
          emailController.text.trim(), passwordController.text.trim(), nameController.text.trim())
          .then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          routes.tabSelector,
              (Route<dynamic> route) => false,
        );
      }).catchError((e) {
        showAlertSnackBar(context, AppStrings.signupFail, isError: true);
      });
    } else {
      showAlertSnackBar(context, AppStrings.emptyFields);
    }
  }
}
