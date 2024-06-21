import 'package:flutter/material.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class LoadingScreen extends StatelessWidget {
  LoadingScreen({super.key});

  final DatabaseServices _dbServices = DatabaseServices();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await _dbServices.isUserLoggedIn()) {
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            routes.tabSelector,
            (Route<dynamic> route) => false,
          );
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            routes.start,
            (Route<dynamic> route) => false,
          );
        }
      }
    });

    return const AppScaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
