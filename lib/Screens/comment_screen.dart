import 'package:flutter/material.dart';
import 'package:pillext/widgets/comment_card.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:pillext/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

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
                )),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text("Post",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
            )
          ],
        ),
      )),
      body: CommentCard(),
    );
  }
}
