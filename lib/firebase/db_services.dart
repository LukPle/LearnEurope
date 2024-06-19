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
      // Create new User Methode
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

  //Login Methode
  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e;
    }
  }

  //Logout Methode
  Future<void> logout()async{
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      } else {
        throw Exception("No user is currently logged in.");
      }
    } catch (e) {
      throw e;
    }
  }


}