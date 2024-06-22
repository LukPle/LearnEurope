import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/util/uuid_generator.dart';

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

        await createDocument(
          collection: FirebaseConstants.usersCollection,
          docId: userId,
          data: {
            'name': name,
            'email': email,
            'totalPoints': 0,
            'registrationDate': FieldValue.serverTimestamp(),
          },
        );

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

        DocumentSnapshot userDoc = await getDocument(collection: FirebaseConstants.usersCollection, docId: userId);
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

      DocumentSnapshot userDoc = await getDocument(collection: FirebaseConstants.usersCollection, docId: userId);
      String userName = userDoc['name'];

      getIt<UserStore>().saveUserProfile(userId, userName);

      return true;
    } else {
      return false;
    }
  }

  Future<void> createDocument({required String collection, required Map<String, dynamic> data, String? docId}) async {
    try {
      String documentId = docId ?? generateUUID();
      await _firestore.collection(collection).doc(documentId).set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getDocument({required String collection, required String docId}) async {
    try {
      DocumentSnapshot document = await _firestore.collection(collection).doc(docId).get();
      return document;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> getDocumentsByAttribute(
      {required String collection, required String field, required dynamic value}) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collection).where(field, isEqualTo: value).get();
      return querySnapshot.docs;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> getAllDocuments({required String collection}) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collection).get();
      return querySnapshot.docs;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDocument(
      {required String collection, required String docId, required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      rethrow;
    }
  }
}
