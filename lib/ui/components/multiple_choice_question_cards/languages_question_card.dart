import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/ui/components/altert_snackbar.dart';

class LanguagesQuestionCard extends StatefulWidget {
  const LanguagesQuestionCard({super.key});

  @override
  LanguagesQuestionCardState createState() => LanguagesQuestionCardState();
}

class LanguagesQuestionCardState extends State<LanguagesQuestionCard> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
      ],
      IosTextToSpeechAudioMode.defaultMode,
    );
  }

  Future<void> _speak(String languageCode, String quote) async {
    if (await flutterTts.isLanguageAvailable(languageCode)) {
      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(quote);
    } else {
      if (mounted) {
        showAlertSnackBar(context, AppStrings.textToSpeechFail, isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppPaddings.padding_32),
        Text('What language is this?', style: AppTextStyles.questionTextStyle),
        const Spacer(),
        Text(
          '"Estar en las nubes"',
          style: AppTextStyles.questionTextStyle.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: AppPaddings.padding_12),
        IconButton(
          onPressed: () async => await _speak('es-ES', 'Estar en las nubes'),
          icon: const Icon(Icons.volume_up),
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
        ),
        const Spacer(),
      ],
    );
  }
}
