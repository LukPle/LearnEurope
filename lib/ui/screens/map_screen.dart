import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  final HintDialogStore hintDialogStore = HintDialogStore();
  LatLng? selectedLocation;

  void _onTap(TapPosition tapPosition, LatLng location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      scoreReduction: -10,
                      hint: 'THE HINT',
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
              initialCenter: LatLng(48.8566, 2.3522), // Initial position (Paris)
              initialZoom: 5.0,
              onTap: _onTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          ),
          Positioned(
            top: AppPaddings.padding_16,
            left: AppPaddings.padding_16,
            child: Container(
              padding: const EdgeInsets.all(AppPaddings.padding_12),
              decoration: BoxDecoration(
                color: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? AppColors.lightCard
                    : AppColors.darkCard,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              child: Text('Mark the location of the capital of France.'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedLocation != null) {
            _calculateDistance();
          }
        },
        backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.primaryColorLight
            : AppColors.primaryColorDark,
        child: Icon(
          Icons.check,
          color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void _calculateDistance() {
    const parisLocation = LatLng(48.8566, 2.3522);
    final distance = Geolocator.distanceBetween(
      selectedLocation!.latitude,
      selectedLocation!.longitude,
      parisLocation.latitude,
      parisLocation.longitude,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Distance from Paris: ${distance.toStringAsFixed(2)} km'),
        );
      },
    );
  }
}
