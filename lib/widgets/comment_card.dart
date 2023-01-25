// ignore_for_file:  unnecessary_string_interpolations
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
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    getLikeData() {
      List likes = widget.snap['likes'];
      if (likes.contains(user.uid)) {
        setState(() {
          isLiked = true;
        });
      } else {
        setState(() {
          isLiked = false;
        });
      }
    }

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
                            text: '${widget.snap["comment"]}',
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
              padding: EdgeInsets.all(8),
              child: IconButton(
                icon: isLiked
                    ? Icon(
                        Icons.favorite_border,
                        size: 18,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                onPressed: () async {
                  getLikeData();
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
