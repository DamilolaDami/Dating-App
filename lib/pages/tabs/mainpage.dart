import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiki/models/chat.dart';
import 'package:tiki/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiki/pages/tabs/categoryscreen.dart';
import 'package:tiki/pages/tabs/chatpage.dart';
import 'package:tiki/pages/tabs/likes_page.dart';
import 'package:tiki/profile.dart';
import 'package:tiki/providers/userdata.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    List page = [
      HomePage(),
      Container(),
      const MatchesScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const DrawerWidget()));
            },
            child: FutureBuilder(
                future: userData.getData(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          )),
                    );
                  }
                  //  saveUser(snapshot.data!['imageUrl'][1]);
                  return Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              snapshot.data!['imageUrl'][1] ?? ''),
                        ),
                      ));
                }),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                icon: Image.asset(
                  'assets/images/bell.png',
                  height: 25,
                  width: 25,
                  color: Colors.grey,
                ),
                onPressed: () {}),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/connect.png',
                  height: 25,
                  width: 25,
                  color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 5),
              Text(
                'Discover',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          ListPage(),
          Category(),
          MatchesScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onTappedBar,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 5,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/connect.png',
                height: 25,
                width: 25,
                color: _selectedIndex == 0
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/list.png',
                height: 25,
                width: 25,
                color: _selectedIndex == 1
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/categories.png',
                height: 25,
                width: 25,
                color: _selectedIndex == 2
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                overflow: Overflow.visible,
                children: [
                  Image.asset(
                    'assets/images/chat.png',
                    height: 30,
                    width: 30,
                    color: _selectedIndex == 3
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey,
                  ),
                  Positioned(
                    top: -1,
                    right: 0,
                    child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  )
                ],
              ),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
