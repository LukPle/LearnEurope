import 'package:animated_digit/animated_digit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/result_content_model.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/firebase_constants.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.resultContentModel});

  final ResultContentModel resultContentModel;

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  late ConfettiController confettiController;
  late AnimatedDigitController animatedDigitController;
  late double performance;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: const Duration(seconds: 2));
    animatedDigitController = AnimatedDigitController(0);
    performance = widget.resultContentModel.earnedScore / widget.resultContentModel.availableScore;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchAndUpdateTotalPoints();
    });
  }

  @override
  void dispose() {
    confettiController.dispose();
    animatedDigitController.dispose();
    super.dispose();
  }

  Future<void> _fetchAndUpdateTotalPoints() async {
    var data = {
      'totalPoints': FieldValue.increment(widget.resultContentModel.earnedScore),
    };

    final DatabaseServices dbServices = DatabaseServices();
    await dbServices.updateDocument(
        collection: FirebaseConstants.usersCollection, docId: getIt<UserStore>().userId.toString(), data: data);
  }

  @override
  Widget build(BuildContext context) {
    confettiController.play();

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PageHeadline(title: AppStrings.resultTitle),
          const SizedBox(height: AppPaddings.padding_16),
          Text(
            AppStrings.answeredQuestion(widget.resultContentModel.numbQuestions),
            style: AppTextStyles.resultScreenHeadline(brightness: MediaQuery.of(context).platformBrightness),
          ),
          const SizedBox(height: AppPaddings.padding_8),
          buildScoreCard(widget.resultContentModel.earnedScore, widget.resultContentModel.availableScore),
          const Spacer(),
          CtaButton.primary(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              routes.tabSelector,
              (Route<dynamic> route) => false,
            ),
            label: AppStrings.returnToHomeButton,
          ),
          const SizedBox(height: AppPaddings.padding_12),
          CtaButton.secondary(onPressed: () => {}, label: AppStrings.playAgainButton),
        ],
      ),
    );
  }

  Widget buildScoreCard(int earnedCore, int availableScore) {
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
            AppStrings.pointsIntroduction,
            style: AppTextStyles.resultScreenPointsIntro(brightness: MediaQuery.of(context).platformBrightness),
          ),
          const Spacer(),
          if (performance != 0) _buildConfettiPlayer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? Colors.white
                    : AppColors.accentColorDark,
                shape: BoxShape.circle),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScoreText(earnedCore),
                const SizedBox(height: AppPaddings.padding_4),
                Text(
                  'Out of ${availableScore.toString()}',
                  style: AppTextStyles.questionTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            )),
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
      numberOfParticles: performance > 0.5 ? 10 : 5,
      maxBlastForce: performance > 0.5 ? 20 : 15,
    );
  }
}
