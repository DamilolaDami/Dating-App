import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:provider/provider.dart';
import 'package:tiki/custompaints/circular_progress.dart';
import 'package:tiki/models/user.dart';
import 'package:tiki/providers/userdata.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  List items = [
    {
      'name': 'Level up every action you take on Discover',
      'title': 'Discover Platinum',
      'icon': 'assets/images/ad.png',
      'selected': true,
    },
    {
      'name': 'Get Unlimited Likes & More.',
      'title': 'Discover Gold',
      'icon': 'assets/images/ad.png',
      'selected': false,
    },
    {
      'name': 'See Them now with Discover Plus',
      'title': '10 People Likey You',
      'icon': 'assets/images/ad.png',
      'selected': false,
    },
  ];
  int _currentPage = 0;
  int _dotPosition = 0;
  Timer? _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  AnimationController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    controller!
        .reverse(from: controller!.value == 0.0 ? 1.0 : controller!.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.aBeeZee(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: userData.getData(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(snapshot
                                              .data!['imageUrl'][1] ??
                                          'https://i.imgur.com/sKcEg5J.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: GestureDetector(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller!,
                                    backgroundColor: Colors.white,
                                    color: Colors.red,
                                  )),
                                  onTap: () {},
                                ),
                              ),
                              Positioned(
                                  bottom: -5,
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    child: Center(
                                        child: Text(
                                      '100% Complete',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: const [
                                            0.1,
                                            0.9
                                          ],
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ]),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${toBeginningOfSentenceCase(snapshot.data!['username']) ?? ''}, ${snapshot.data!['age'] ?? ''}",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.verified,
                                color: CupertinoColors.activeGreen,
                                size: 18,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width - 20,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 14 / 5,
                                        crossAxisCount: 4),
                                itemCount: snapshot.data!['interest']!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 20,
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!['interest']![index] ??
                                            'null',
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        )),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                ListTile(
                                    title: Text(
                                      'Profile',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 17,
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    )),
                                ListTile(
                                    title: Text(
                                      'Settings',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 17,
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    )),
                                // ListTile(
                                //     title: Text(
                                //       'Safety Guides',
                                //       style: GoogleFonts.aBeeZee(
                                //         fontSize: 17,
                                //       ),
                                //     ),
                                //     trailing: const Icon(
                                //       Icons.arrow_forward_ios,
                                //       size: 14,
                                //     )),
                                ListTile(
                                    onTap: () {
                                      userData.logout();
                                    },
                                    title: Text(
                                      'Logout',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 17,
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width - 20,
                            child: PageView.builder(
                                controller: _pageController,
                                itemCount: items.length,
                                onPageChanged: (value) {},
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              items[index]['title'],
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              items[index]['name'],
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 15,
                                              ),
                                            )
                                          ]));
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ]);
          }),
      bottomSheet: BottomSheet(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onClosing: () {},
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          items.length, (index) => buildDots(index, context)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 40,
                        width: 90,
                        child: Center(
                          child: Text(
                            'Get Discover Plus+',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).accentColor,
                                Theme.of(context).primaryColorLight
                              ]),
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _dotPosition == index ? Colors.red.shade500 : Colors.grey),
    );
  }
}
