import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pillext/utils/gobal_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
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

  pageChanger(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: false,
        elevation: 0,
        shadowColor: null,
        title: const Text(
          "Pillext",
        ),
        actions: [
          IconButton(
            onPressed: () => pageChanger(0),
            icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => pageChanger(1),
            icon: Icon(
              Icons.search,
              color: _page == 1 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => pageChanger(2),
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => pageChanger(3),
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => pageChanger(4),
            icon: Icon(
              Icons.person,
              color: _page == 4 ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenPages,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
