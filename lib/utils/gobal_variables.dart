import 'package:flutter/material.dart';
import 'package:pillext/Screens/add_post_screen.dart';
import 'package:pillext/Screens/feed_screen.dart';
import 'package:pillext/Screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenPages = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("fav"),
  Text("user"),
];
