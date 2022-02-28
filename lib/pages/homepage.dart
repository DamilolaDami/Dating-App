// ignore_for_file: avoid_print

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlng/latlng.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiki/constatns/colors.dart';
import 'package:tiki/profile.dart';
import 'package:tiki/pages/tabs/userscreen.dart';
import 'package:tiki/providers/userdata.dart';
import 'package:tiki/respositories/bloc/swipebloc_bloc.dart';
import 'package:tiki/widgets/usercard.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final bool isLike = false;
  final bool isHeart = false;
  TapDownDetails? detailes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    _getUserLocation();
  }

  void saveUser(String imgeUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', imgeUrl);
  }

  UserData? userData;
  LatLng? currentPostion;
  Position? _currentLocation;

  void getCureentUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.high))
        .then((value) => {
              setState(() {
                _currentLocation = value;
              }),
            });
  }

  var userCrendentail = auth.FirebaseAuth.instance.currentUser;
  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.high))
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userCrendentail!.email)
                  .update({
                'currentPostion': GeoPoint(value.latitude, value.longitude),
              })
            });
  }

  String? offlineUrl;
  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      offlineUrl = prefs.getString('user');
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User? user;
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: DrawerWidget(),

      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocBuilder<SwipeBloc, SwipeState>(
          bloc: BlocProvider.of<SwipeBloc>(context),
          builder: (context, state) {
            if (state is SwipeLoading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                ],
              );
            } else if (state is SwipeLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Column(
                  children: [
                    InkWell(
                      onTapDown: (details) {
                        var position = details.globalPosition;
                        if (position.dx <
                            MediaQuery.of(context).size.width / 2) {
                          print('left');
                          // tap left side

                        } else {
                          // tap rigth size

                          print('right');
                        }
                      },
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(user: state.users[0])));
                      },
                      child: FutureBuilder(
                          future: userData.getData(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Draggable<User>(
                              data: state.users[0],
                              child: UserCard(user: state.users[0]),
                              feedback: UserCard(user: state.users[0]),
                              childWhenDragging: UserCard(user: state.users[1]),
                              onDragEnd: (drag) {
                                if (drag.velocity.pixelsPerSecond.dx < 0) {
                                  context.read<SwipeBloc>().add(
                                      SwipeLeftEvent(user: state.users[0]));
                                  print('Swiped Left');
                                } else {
                                  context.read<SwipeBloc>().add(
                                      SwipeRightEvent(user: state.users[0]));
                                  userData.saveLikedUser(
                                    currentUserAddress:
                                        snapshot.data!['location'],
                                    currentUserAge: snapshot.data!['age'],
                                    currentUsername: snapshot.data!['username'],
                                    currentUserImageurls:
                                        snapshot.data!['imageUrl'],
                                    currentUserInterest:
                                        snapshot.data!['interest'],
                                    currentoccupation: snapshot.data!['bio'],
                                    imageurls: state.users[0].imageUrls ?? [],
                                    likedUsername: state.users[0].name ?? '',
                                    likedUserAddress:
                                        state.users[0].location ?? '',
                                    likedUserage: state.users[0].age ?? '',
                                    likedUserInterest:
                                        state.users[0].interests ?? [],
                                    likedUseremail: state.users[0].email ?? '',
                                    occupation: state.users[0].bio ?? '',
                                    job: snapshot.data!['bio'],
                                  );
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    Lottie.asset('assets/animations/love.json');
                                  });
                                  print('Swiped Right');
                                }
                              },
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            } else if (state is SwipeError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (state is SwipeEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            }
            return const Text('Something went wrong');
          },
        )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
