import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiki/models/usersmatch.dart';
import 'package:tiki/pages/tabs/chatscreen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tiki/widgets/small_image.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              AntIcons.searchOutlined,
                              size: 17,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Search ${inactiveMatches.length.toString()} Matches',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withAlpha(40),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Recently Matched',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    Container(
                      height: 100,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('likeduser')
                              .where('email',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.email)
                              .where('matched', isEqualTo: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            return SizedBox(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder:
                                                          (context) =>
                                                              Messaging(
                                                                cureentUserphtoUrl: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'imageUrl'][1],
                                                                photoUrl: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'likedUserImageUrls'][1],
                                                                username: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'likedUsername'],
                                                              )));
                                            },
                                            child: UserImageSmall(
                                                height: 70,
                                                width: 70,
                                                url: snapshot.data!.docs[index]
                                                    ['likedUserImageUrls'][1]),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['likedUsername'],
                                            style: GoogleFonts.aBeeZee(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                    TabBar(
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        indicatorColor: Theme.of(context).colorScheme.secondary,
                        labelColor: Theme.of(context).colorScheme.secondary,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(
                            text: "Messages",
                          ),
                          Tab(
                            text: "Matches",
                          )
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: activeMatches.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/chat',
                                      arguments: activeMatches[index]);
                                },
                                child: Row(
                                  children: [
                                    UserImageSmall(
                                      height: 65,
                                      width: 65,
                                      url: activeMatches[index]
                                          .matchedUser
                                          .imageUrls![0],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            activeMatches[index]
                                                    .matchedUser
                                                    .name ??
                                                '',
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(height: 2),
                                        Text(
                                            activeMatches[index]
                                                .chat![0]
                                                .messages[0]
                                                .message,
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            )),
                                        const SizedBox(height: 5),
                                        Text(
                                            timeago
                                                .format(activeMatches[index]
                                                    .chat![0]
                                                    .messages[0]
                                                    .timeString)
                                                .toString(),
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                        const Center(child: const Text('Matches'))
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: TabBar(
                controller: tabController,
                labelColor: Colors.redAccent,
                isScrollable: true,
                tabs: const [
                  Tab(
                    child: Text(
                      "Tab 1",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Tab 1",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Container(
          child: TabBarView(
            controller: tabController,
            children: [
              /// Each content from each tab will have a dynamic height
              Container(),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
