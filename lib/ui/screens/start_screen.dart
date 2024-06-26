import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const PageHeadline(title: 'Welcome to Learn Europe'),
          const Spacer(),
          SvgPicture.asset(
            'assets/europe_illustration.svg',
            width: MediaQuery.of(context).size.width,
          ),
          const Spacer(),
          CtaButton.primary(onPressed: () => _navigateToLogin(context), label: AppStrings.loginButton),
          const SizedBox(height: AppPaddings.padding_12),
          CtaButton.secondary(onPressed: () => _navigateToSignup(context), label: AppStrings.signupButtonStart),
        ],
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(routes.login);
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.of(context).pushNamed(routes.signup);
  }
}
