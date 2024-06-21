import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';

import 'firebase_constants.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String userId = user.uid;

        await _firestore.collection(FirebaseConstants.usersCollection).doc(userId).set({
          'name': name,
          'email': email,
        });

        getIt<UserStore>().saveUserProfile(userId, name);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String userId = user.uid;

        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection).doc(userId).get();

        String userName = userDoc['name'];

        getIt<UserStore>().saveUserProfile(userId, userName);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      } else {
        throw Exception('No user is currently logged in');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection).doc(userId).get();

      String userName = userDoc['name'];

      getIt<UserStore>().saveUserProfile(userId, userName);

      return true;
    } else {
      return false;
    }
  }
}
