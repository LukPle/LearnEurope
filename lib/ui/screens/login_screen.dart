import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/stores/password_field_store.dart';
import 'package:learn_europe/ui/components/altert_snackbar.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/input_field.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late PasswordFieldStore passwordFieldStore;
  final DatabaseServices _dbServices = DatabaseServices();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFieldStore = PasswordFieldStore();
  }

  @override
  void dispose() {
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
              const Text(AppStrings.loginTitle, style: AppTextStyles.standardTitleTextStyle),
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
              const SizedBox(height: AppPaddings.padding_8),
              Center(
                child: TextButton(
                  onPressed: () => {},
                  child: Text(
                    AppStrings.forgotPassword,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: MediaQuery.of(context).platformBrightness == Brightness.light
                            ? AppColors.primaryColorLight
                            : AppColors.primaryColorDark,
                        decorationThickness: 0.75),
                  ),
                ),
              ),
              const Spacer(),
              CtaButton.primary(
                onPressed: () async => _login(),
                label: AppStrings.loginButton,
                loading: isLoading,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await _dbServices.loginUser(emailController.text.trim(), passwordController.text.trim());
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            routes.tabSelector,
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        showAlertSnackBar(context, AppStrings.loginFail, isError: true);
      }
    } else {
      showAlertSnackBar(context, AppStrings.emptyFields);
    }
  }
}
