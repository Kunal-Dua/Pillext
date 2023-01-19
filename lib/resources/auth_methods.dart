import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillext/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String username,
    required String bio,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      UserCredential currentUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String photoUrl = await StorageMethods()
          .uplaodImageToStorage("profilePics", file, false);

      firestore.collection("users").doc(currentUser.user!.uid).set({
        "uid": currentUser.user!.uid,
        "email": email,
        "username": username,
        "bio": bio,
        "followers": [],
        "following": [],
        "photoUrl": photoUrl,
      });
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> logInUser({required email, required password}) async {
    String res = "";
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Successfully signed in";
    } catch (err) {
      res = "Error Occured";
    }
    return res;
  }
}
