import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pillext/models/post.dart';
import 'package:uuid/uuid.dart';
import 'package:pillext/resources/storage_methods.dart';

class FireStoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String photoImage) async {
    String res = "";
    try {
      String photoUrl =
          await StorageMethods().uplaodImageToStorage("posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: Timestamp.now(),
        postUrl: photoUrl,
        profileImage: photoImage,
        likes: [],
      );
      firestore.collection("posts").doc(postId).set(post.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
