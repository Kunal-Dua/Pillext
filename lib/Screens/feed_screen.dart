import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pillext/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: null,
        title: const Text(
          "Pillext",
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) => PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    )),
              );
            }
          }),
    );
  }
}
