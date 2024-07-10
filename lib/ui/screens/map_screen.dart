import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/models/map_content_model.dart';
import 'package:learn_europe/models/result_content_model.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/stores/map_store.dart';
import 'package:learn_europe/stores/question_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/constants/routes.dart' as routes;
import 'package:learn_europe/ui/components/quiz_explanation.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.mapContentModel});

  final List<MapContentModel> mapContentModel;

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final QuestionStore questionStore = QuestionStore();
  final MapStore mapStore = MapStore();
  final HintDialogStore hintDialogStore = HintDialogStore();
  late final MapController mapController;

  int score = 0;
  bool isCorrectlyAnswered = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapStore.setMapReady();
      mapStore.setRotation(mapController.camera.rotation != 0);
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    mapStore.resetMapReady();
    super.dispose();
  }

  void _onMapTap(TapPosition tapPosition, LatLng location) {
    mapStore.setLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AppScaffold(
          hasVerticalPadding: false,
          hasHorizontalPadding: false,
          hasBottomSafeArea: false,
          appBar: AppAppBar(
            title: AppStrings.exitQuiz,
            centerTitle: false,
            leadingIcon: Icons.close,
            leadingIconAction: () => {
              Navigator.of(context).pop(routes.tabSelector),
            },
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppPaddings.padding_16),
                child: GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return HintDialog(
                          hintDialogStore: hintDialogStore,
                          scoreReduction: widget.mapContentModel[questionStore.numbQuestion].hintMinus,
                          hint: widget.mapContentModel[questionStore.numbQuestion].hint,
                        );
                      }),
                  child: const Icon(Icons.question_mark),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: const LatLng(51.255, 10.528),
                  initialZoom: 5.0,
                  maxZoom: 7.5,
                  onTap: _onMapTap,
                  onMapEvent: (MapEvent event) {
                    if (event is MapEventRotateEnd) {
                      mapStore.setRotation(mapController.camera.rotation != 0);
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: MediaQuery.of(context).platformBrightness == Brightness.light
                        ? 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png'
                        : 'https://{s}.basemaps.cartocdn.com/rastertiles/dark_nolabels/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  if (mapStore.selectedLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: mapStore.selectedLocation!,
                          child: Icon(
                            Icons.location_on,
                            color: MediaQuery.of(context).platformBrightness == Brightness.light
                                ? AppColors.primaryColorLight
                                : AppColors.primaryColorDark,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPaddings.padding_16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppPaddings.padding_12),
                            decoration: BoxDecoration(
                              color: MediaQuery.of(context).platformBrightness == Brightness.light
                                  ? AppColors.lightBackground
                                  : AppColors.darkCard,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Question ${questionStore.numbQuestion + 1} / ${widget.mapContentModel.length}'),
                                const SizedBox(height: AppPaddings.padding_8),
                                Text(
                                  widget.mapContentModel[questionStore.numbQuestion].question,
                                  style: AppTextStyles.questionTextStyle,
                                ),
                                const SizedBox(height: AppPaddings.padding_8),
                                Text(
                                  AppStrings.geoPositionAllowedRadius(
                                    widget.mapContentModel[questionStore.numbQuestion].allowedKmDifference,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (mapStore.isMapReady)
                          Padding(
                            padding: const EdgeInsets.only(right: AppPaddings.padding_16),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FloatingActionButton(
                                mini: true,
                                elevation: 1,
                                backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
                                    ? mapStore.isRotated
                                        ? AppColors.primaryColorLight
                                        : AppColors.accentColorLight
                                    : mapStore.isRotated
                                        ? AppColors.primaryColorDark
                                        : AppColors.accentColorDark,
                                onPressed: () => {
                                  mapController.rotate(0),
                                  mapStore.setRotation(false),
                                },
                                child: Icon(
                                  Icons.explore,
                                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: AppPaddings.padding_16,
                    right: AppPaddings.padding_16,
                    bottom: AppPaddings.padding_48,
                    child: CtaButton.primary(
                      onPressed: mapStore.selectedLocation != null ? () => _validateAnswerAndProceedQuiz() : null,
                      label: AppStrings.geoPositionCheckButton,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _validateAnswerAndProceedQuiz() {
    double distanceFromTarget = _calculateDistance();
    if (distanceFromTarget.ceil() <= widget.mapContentModel[questionStore.numbQuestion].allowedKmDifference) {
      isCorrectlyAnswered = true;
      _calculateScore();
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            elevation: 1,
            insetPadding: const EdgeInsets.symmetric(horizontal: AppPaddings.padding_16),
            child: Padding(
              padding: const EdgeInsets.all(AppPaddings.padding_16),
              child: ExplanationArea(
                isCorrect: isCorrectlyAnswered,
                explanationText: AppStrings.geoPositionResult(distanceFromTarget),
                action: () => _proceedQuiz(),
                isMinHeight: true,
              ),
            ),
          ),
        );
      },
    );
  }

  double _calculateDistance() {
    LatLng targetLocation = widget.mapContentModel[questionStore.numbQuestion].latLng;
    double distanceInMeter = Geolocator.distanceBetween(
      mapStore.selectedLocation!.latitude,
      mapStore.selectedLocation!.longitude,
      targetLocation.latitude,
      targetLocation.longitude,
    );

    return distanceInMeter / 1000;
  }

  void _calculateScore() {
    if (hintDialogStore.isHintRevealed) {
      score += (widget.mapContentModel[questionStore.numbQuestion].pointsPerQuestion +
          widget.mapContentModel[questionStore.numbQuestion].hintMinus);
    } else {
      score += widget.mapContentModel[questionStore.numbQuestion].pointsPerQuestion;
    }
  }

  void _proceedQuiz() {
    if (widget.mapContentModel.length > (questionStore.numbQuestion + 1)) {
      isCorrectlyAnswered = false;
      hintDialogStore.resetHint();
      questionStore.nextQuestion();
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        routes.result,
        (Route<dynamic> route) => false,
        arguments: ResultContentModel(
          quizCategory: widget.mapContentModel.first.quizCategory,
          quizId: widget.mapContentModel.first.quizId,
          numbQuestions: widget.mapContentModel.length,
          earnedScore: score,
          availableScore: (widget.mapContentModel.length * widget.mapContentModel.first.pointsPerQuestion),
        ),
      );
    }
  }
}
