import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String username,
    required String bio,
    required String password,
    // required Uint8List image,
  }) async {
    String res = "Some error occured";
    try {
      UserCredential currentUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
          
      firestore.collection("users").doc(currentUser.user!.uid).set({
        "uid": currentUser.user!.uid,
        "email": email,
        "username": username,
        "bio": bio,
        "followers": [],
        "following": [],
      });
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
