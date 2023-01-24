import 'package:cloud_firestore/cloud_firestore.dart';
class Post {
  final String uid;
  final String description;
  final String username;
  final String postUrl;
  final String postId;
  final datePublished;
  final String profileImage;
  final List likes;

  const Post(
      {required this.uid,
      required this.description,
      required this.username,
      required this.postUrl,
      required this.postId,
      required this.datePublished,
      required this.profileImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "description": description,
        "username": username,
        "postUrl": postUrl,
        "postId": postId,
        "datePublished": datePublished,
        "profileImage": profileImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      description: snapshot['description'],
      postUrl: snapshot['postUrl'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
    );
  }
}
