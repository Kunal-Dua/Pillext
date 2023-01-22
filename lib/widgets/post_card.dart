import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillext/Screens/comment_screen.dart';
import 'package:pillext/providers/user_provider.dart';
import 'package:pillext/resources/firestore_methods.dart';
import 'package:pillext/widgets/like_animation.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentsLen = 0;
  int commentLen = 0;

  void getComments() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.snap["postId"])
        .collection("comments")
        .get();
    commentsLen = snap.docs.length;
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.snap['profileImage']),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ]),
              )),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            FireStoreMethods().likePost(
              widget.snap['uid'],
              widget.snap['postId'],
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            LikeAnimation(
              isAnimating: widget.snap['likes'].contains(user.uid),
              smallLike: true,
              child: IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () {
                    FireStoreMethods().likePost(
                      widget.snap['uid'],
                      widget.snap['postId'],
                      widget.snap['likes'],
                    );
                  }),
            ),
            IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
                  ));
                }),
            IconButton(icon: const Icon(Icons.send), onPressed: () {}),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ))
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.snap["likes"].length} likes'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 4),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: widget.snap["description"])
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'View all $commentsLen comments',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  DateFormat.yMMMd()
                      .format(widget.snap["datePublished"].toDate()),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
