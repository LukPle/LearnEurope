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
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/stores/map_store.dart';
import 'package:learn_europe/stores/question_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.mapContentModel});

  final List<MapContentModel> mapContentModel;

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  final QuestionStore questionStore = QuestionStore();
  final MapStore mapStore = MapStore();
  final HintDialogStore hintDialogStore = HintDialogStore();

  void _onTap(TapPosition tapPosition, LatLng location) {
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
                  onTap: _onTap,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png',
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
                  Positioned(
                    top: AppPaddings.padding_16,
                    left: AppPaddings.padding_16,
                    right: AppPaddings.padding_16,
                    child: Container(
                      padding: const EdgeInsets.all(AppPaddings.padding_12),
                      decoration: BoxDecoration(
                        color: MediaQuery.of(context).platformBrightness == Brightness.light
                            ? AppColors.lightBackground
                            : AppColors.darkBackground,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
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
                                widget.mapContentModel[questionStore.numbQuestion].allowedKmDifference),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppPaddings.padding_16,
                    right: AppPaddings.padding_16,
                    bottom: AppPaddings.padding_48,
                    child: CtaButton.primary(
                      onPressed: mapStore.selectedLocation != null ? () => _calculateDistance() : null,
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

  void _calculateDistance() {
    LatLng targetLocation = widget.mapContentModel[questionStore.numbQuestion].latLng;
    final distance = Geolocator.distanceBetween(
      mapStore.selectedLocation!.latitude,
      mapStore.selectedLocation!.longitude,
      targetLocation.latitude,
      targetLocation.longitude,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            AppStrings.geoPositionResult(distance / 1000),
          ),
        );
      },
    );
  }
}
