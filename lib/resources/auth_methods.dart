import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:pillext/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot snap =
        await firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  //signup user email
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
      List arr = await StorageMethods()
          .uplaodImageToStorage("profilePics", file, false);
      String photoUrl = arr[0];

      model.User user = model.User(
        uid: currentUser.user!.uid,
        email: email,
        photoUrl: photoUrl,
        username: username,
        bio: bio,
        followers: [],
        following: [],
      );
      firestore
          .collection("users")
          .doc(currentUser.user!.uid)
          .set(user.toJson());
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

  //login user using google sign in
  Future<String> signInWithGoogle() async {
    String res = "";
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential currentUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      firestore.collection("users").doc(currentUser.user!.uid).set({
        "uid": currentUser.user!.uid,
        "email": currentUser.user!.email,
        "photoUrl": currentUser.user!.photoURL,
        "username": currentUser.user!.displayName,
        "bio": "",
        "followers": [],
        "following": [],
      });
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
