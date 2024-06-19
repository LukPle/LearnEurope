import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future<void> createUser(String email, String password, String name) async {
    try {
      // Create a new user account with e-mail and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore
      await _firestore.collection("users").doc(userCredential.user?.uid).set({
        "name": name,
        "email": email,
      });

    } catch (e) {
      log('Error adding user: $e' as num);
      throw e;
    }
  }


}