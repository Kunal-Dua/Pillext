import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:pillext/providers/user_provider.dart';
import 'package:pillext/widgets/notification_card.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notications"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final document = snapshot;

          final documentData = document.data!;

          if (documentData['notifications'] == null ||
              documentData['notifications'].isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          final List itemDetailList = (documentData['notifications'] as List)
              .map((itemDetail) => itemDetail as String)
              .toList();

          return ListView.builder(
            itemCount: itemDetailList.length,
            itemBuilder: ((context, index) => NotificationCard(
                  snap: snapshot.data!.data(),
                  user: itemDetailList[index],
                )),
          );
        },
      ),
    );
  }
}
