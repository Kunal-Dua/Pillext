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

  Future<void> likePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        await firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> postComment(String uid, String postId, String text,
      String username, String photoUrl) async {
    try {
      String commentId = const Uuid().v1();
      if (text.isNotEmpty) {
        await firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "uid": uid,
          "username": username,
          "photoUrl": photoUrl,
          "comment": text,
          "postId": postId,
          "commentId": commentId,
          "datePublished": Timestamp.now(),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
