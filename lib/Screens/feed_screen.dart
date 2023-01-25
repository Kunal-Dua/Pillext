import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillext/utils/gobal_variables.dart';
import 'package:pillext/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: Colors.indigo,
              centerTitle: false,
              title: const Text("Pillext"),
              // actions: [
              //   IconButton(
              //     icon: const Icon(
              //       Icons.messenger_outline,
              //       color: Colors.white,
              //     ),
              //     onPressed: () {},
              //   ),
              // ],
            ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .orderBy("datePublished", descending: true)
              .snapshots(),
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
