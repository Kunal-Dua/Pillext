import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageChanger(int page) {
      pageController.jumpToPage(page);
    }

    return Scaffold(
      body: PageView(
        children: [
          Text("feed"),
          Text("search"),
          Text("add post"),
          Text("fav"),
          Text("user"),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _page == 0 ? Colors.black : Colors.grey),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _page == 1 ? Colors.black : Colors.grey),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined,
                color: _page == 2 ? Colors.black : Colors.grey),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: _page == 3 ? Colors.black : Colors.grey),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _page == 4 ? Colors.black : Colors.grey),
            label: ""),
      ], onTap: pageChanger),
    );
  }
}
