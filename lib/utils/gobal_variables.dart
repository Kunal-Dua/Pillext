import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillext/Screens/add_post_screen.dart';
import 'package:pillext/Screens/feed_screen.dart';
import 'package:pillext/Screens/notification_screen.dart';
import 'package:pillext/Screens/profile_screen.dart';
import 'package:pillext/Screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenPages = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const NotificationScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
