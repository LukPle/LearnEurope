import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      throw e;
    }
  }

// Method for the user login
  Future<void> loginUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If login is successful, redirection to the HomeScreen
      Navigator.pushReplacementNamed(context, 'ui/screens/home_screen');
    } catch (e) {
      log('Error signing in: $e' as num);
      // Error handling: e.g. display an error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}'))
      );
    }
  }
}