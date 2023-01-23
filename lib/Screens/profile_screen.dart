import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillext/Screens/login_screen.dart';
import 'package:pillext/resources/auth_methods.dart';
import 'package:pillext/resources/firestore_methods.dart';
import 'package:pillext/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int following = 0;
  int followers = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;

      var postSnap = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: widget.uid)
          .get();

      postLen = postSnap.docs.length;
      following = userData['following'].length;
      followers = userData['followers'].length;
      isFollowing = userSnap
          .data()!["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (err) {
      print(err.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(userData["username"]),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(userData['photoUrl']),
                          radius: 36,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildContainer(postLen, "Posts"),
                                  buildContainer(followers, "Followers"),
                                  buildContainer(following, "Following"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? FollowButton(
                                          text: "Sign Out",
                                          backgroundColor: Colors.blue,
                                          borderColor: Colors.grey,
                                          textColor: Colors.white,
                                          function: () async {
                                            AuthMethods().signOut();
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ));
                                          },
                                        )
                                      : isFollowing
                                          ? FollowButton(
                                              text: "Unfollow",
                                              backgroundColor: Colors.white,
                                              borderColor: Colors.blue,
                                              textColor: Colors.blue,
                                              function: () async {
                                                await FireStoreMethods()
                                                    .followUser(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        userData['uid']);
                                                setState(() {
                                                  isFollowing = false;
                                                  followers--;
                                                });
                                              },
                                            )
                                          : FollowButton(
                                              text: "Follow",
                                              backgroundColor: Colors.blue,
                                              borderColor: Colors.blue,
                                              textColor: Colors.white,
                                              function: () async {
                                                await FireStoreMethods()
                                                    .followUser(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        userData['uid']);
                                                setState(() {
                                                  isFollowing = true;
                                                  followers++;
                                                });
                                              },
                                            )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        userData["username"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(userData["bio"]),
                    )
                  ]),
                ),
                const Divider(thickness: 2.0),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("posts")
                      .where("uid", isEqualTo: widget.uid)
                      .get(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 1.5,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Container(
                          child: Image(
                            image: NetworkImage(
                                (snap.data()! as dynamic)['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ));
  }

  Column buildContainer(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            num.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
