import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_europe/network/firebase_constants.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection).doc(userId).get();

        String userName = userDoc['name'];

        getIt<UserStore>().saveUserProfile(userId, userName);

        Navigator.of(context).pushNamedAndRemoveUntil(
          routes.tabSelector,
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          routes.start,
          (Route<dynamic> route) => false,
        );
      }
    });

    return const AppScaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
