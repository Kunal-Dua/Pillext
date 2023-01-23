import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      List arr =
          await StorageMethods().uplaodImageToStorage("posts", file, true);

      String photoUrl = arr[0];
      String postId = arr[1];

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

  Future<void> deletePost(String postId) async {
    try {
      firestore.collection("posts").doc(postId).delete();
      StorageMethods().deletePostFromStroage(postId);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> followUser(String uid, String followUid) async {
    try {
      DocumentSnapshot snap =
          await firestore.collection("users").doc(uid).get();
      List following = (snap.data()! as dynamic)["following"];
      if (following.contains(followUid)) {
        await firestore.collection("users").doc(followUid).update({
          "followers": FieldValue.arrayRemove([uid]),
        });

        await firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayRemove([followUid]),
        });
      } else {
        await firestore.collection("users").doc(followUid).update({
          "followers": FieldValue.arrayUnion([uid]),
        });

        await firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayUnion([followUid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
