import 'package:ai_dietician_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(
    String name,
    int age,
    double current_weight,
    double current_height,
    Goal goal,
    double goal_weight,
    DateTime date_of_birth,
    Gender gender
    ) async {
      return await userCollection.doc(uid).set({
        'name' : name,
        'age' : age,
        'current_weight' : current_weight,
        'current_height' : current_height,
        'goal' : goal,
        'goal_weight' : goal_weight,
        'date_of_birth' : date_of_birth,
        'gender' : gender,
      });
    }



  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid : uid,
      name : snapshot.get('name'),
      age : snapshot.get('age'),
      current_weight : snapshot.get('current_weight'),
      current_height : snapshot.get('current_height'),
      goal : snapshot.get('goal'),
      goal_weight: snapshot.get('goal_weight'),
      date_of_birth: snapshot.get('date_of_birth'),
      gender :  snapshot.get('gender'),
      
      );
  }


  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}

