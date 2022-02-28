import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tiki/providers/userdata.dart';
import 'package:tiki/widgets/likes.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin<ListPage> {
  bool _fromTop = true;
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    //   var currentTab = DefaultTabController.of(context)?.index;
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(children: [
                  TabBar(
                    controller: tabController,
                    indicatorColor: Colors.grey[500],
                    labelColor: Colors.black,
                    labelStyle: GoogleFonts.aBeeZee(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(
                        text: '10 Likes',
                      ),
                      Tab(text: '10 Picks'),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(
                      children: [
                        const Likes(),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('likeduser')
                                .where('email',
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser!.email)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              //  String id = snapshot.data.docs.id;
                              return GridView.builder(
                                itemCount: snapshot.data!.docs.length,
                                addAutomaticKeepAlives: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 7 / 10,
                                ),
                                itemBuilder: (context, index) {
                                  String id = snapshot.data!.docs[index].id;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        userData.deleteUser(id);
                                      },
                                      child: Container(
                                          height: 180,
                                          width: 100,
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['likedUsername'],
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['likedUserage'],
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Expires in: ' '1 day',
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot
                                                        .data!.docs[index]
                                                    ['likedUserImageUrls'][1])),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          )),
                                    ),
                                  );
                                },
                              );
                            })
                      ],
                    ),
                  ))
                ]),
                Positioned(
                  bottom: 10,
                  left: 35,
                  right: 35,
                  child: GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: const Duration(milliseconds: 700),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position: Tween(
                                      begin: const Offset(0, -1),
                                      end: const Offset(0, 0))
                                  .animate(anim1),
                              child: child,
                            );
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const PremiumDialog();
                          });
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                            DefaultTabController.of(context)!.index == 0
                                ? 'See full list'.toUpperCase()
                                : 'See who picked you'.toUpperCase(),
                            style: GoogleFonts.aBeeZee(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9,
                          ],
                          colors: [
                            Colors.redAccent,
                            Colors.redAccent,
                          ],
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(50),
                      ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class PremiumDialog extends StatelessWidget {
  const PremiumDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Material(
            child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Column(children: [
                        Text('Get Discover Premium',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                            )),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
