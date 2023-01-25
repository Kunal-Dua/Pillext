// ignore_for_file:  unnecessary_string_interpolations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillext/providers/user_provider.dart';
import 'package:pillext/resources/firestore_methods.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  var commentData;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    getCommentData();
  }

  getCommentData() async {
    var comment = await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.snap['postId'])
        .collection("comments")
        .doc(widget.snap['commentId'])
        .get();

    commentData = comment.data();

    List likes = commentData['likes'];
    print(likes);
    if (likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
      setState(() {
        isLiked = true;
      });
    } else {
      setState(() {
        isLiked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.snap["photoUrl"]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: widget.snap["username"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' ${widget.snap["comment"]}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Text(
                              DateFormat.yMMMd().format(
                                  widget.snap["datePublished"].toDate()),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${widget.snap['likes'].length} like',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: isLiked
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        size: 20,
                      ),
                onPressed: () async {
                  getCommentData();
                  FireStoreMethods().likeComment(
                    user.uid,
                    widget.snap['likes'],
                    widget.snap['postId'],
                    widget.snap['commentId'],
                  );
                },
              ),
            )
          ],
        ));
  }
}
