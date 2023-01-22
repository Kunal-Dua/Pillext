import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pillext/resources/firestore_methods.dart';
import 'package:pillext/widgets/comment_card.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:pillext/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Comment as ${user.username}',
                    border: InputBorder.none,
                  ),
                  controller: _commentcontroller,
                  autofocus: true,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                FireStoreMethods().postComment(
                  user.uid,
                  widget.snap["postId"],
                  _commentcontroller.text,
                  user.username,
                  user.photoUrl,
                );
                setState(() {
                  _commentcontroller.text = "";
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text("Post",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
            )
          ],
        ),
      )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.snap["postId"])
            .collection("comments")
            .orderBy("datePublished", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) =>
                  CommentCard(snap: snapshot.data!.docs[index].data())));
        },
      ),
    );
  }
}
