import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillext/utils/gobal_variables.dart';

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
      appBar: AppBar(
        elevation: 0,
        shadowColor: null,
        title: const Text(
          "Pillext",
        ),
        centerTitle: false,
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenPages,
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
