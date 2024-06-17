import 'package:animated_digit/animated_digit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  late ConfettiController confettiController;
  late AnimatedDigitController animatedDigitController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: const Duration(seconds: 2));
    animatedDigitController = AnimatedDigitController(0);
  }

  @override
  void dispose() {
    confettiController.dispose();
    animatedDigitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments);
    int points = 50;

    confettiController.play();

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PageHeadline(title: 'Your results'),
          const SizedBox(height: AppPaddings.padding_16),
          Text(
            'After 10 answered questions',
            style: AppTextStyles.resultScreenHeadline(brightness: MediaQuery.of(context).platformBrightness),
          ),
          const SizedBox(height: AppPaddings.padding_8),
          buildScoreCard(points),
          const Spacer(),
          CtaButton.primary(
              onPressed: () => Navigator.of(context).pushNamed(routes.tabSelector), label: 'Return to home'),
          const SizedBox(height: AppPaddings.padding_12),
          CtaButton.secondary(onPressed: () => {}, label: 'Play again'),
        ],
      ),
    );
  }

  Widget buildScoreCard(int score) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        gradient: MediaQuery.of(context).platformBrightness == Brightness.light
            ? const LinearGradient(
                colors: [Colors.blue, AppColors.primaryColorLight],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : const LinearGradient(
                colors: [Colors.yellowAccent, AppColors.primaryColorDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Earned points',
            style: AppTextStyles.resultScreenPointsIntro(brightness: MediaQuery.of(context).platformBrightness),
          ),
          const Spacer(),
          _buildConfettiPlayer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? Colors.white
                    : AppColors.accentColorDark,
                shape: BoxShape.circle),
            child: Center(
              child: _buildScoreText(score),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildScoreText(int score) {
    animatedDigitController.addValue(score);
    return AnimatedDigitWidget(
      textStyle: AppTextStyles.resultScreenPointsScore,
      controller: animatedDigitController,
      duration: const Duration(milliseconds: 1500),
    );
  }

  Widget _buildConfettiPlayer() {
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      numberOfParticles: 10,
      maxBlastForce: 25,
    );
  }
}
