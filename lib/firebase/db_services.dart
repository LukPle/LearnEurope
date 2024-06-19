import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  final _fire=FirebaseFirestore.instance;
  createUser(){
    try{
      _fire.collection("users").add({"name":"Lukas","nickname":"BigD"});
    }catch(e){
      log(e.toString() as num);
    }
  }


}