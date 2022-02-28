import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiki/animations/fadeinanimation.dart';
import 'package:tiki/constatns/colors.dart';
import 'package:tiki/models/user.dart';
import 'package:tiki/pages/homepage.dart';
import 'package:tiki/respositories/bloc/swipebloc_bloc.dart';
import 'package:tiki/widgets/choicebtn.dart';
import 'package:tiki/widgets/image_container.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double? lat;
  double? meters;
  double? long;
  double distance = 0;
  TapDownDetails? tapDownDetails;
  void getMilesAway() {
    final double distanceinmeters = Geolocator.distanceBetween(
      widget.user.geopoint!.latitude,
      widget.user.geopoint!.longitude,
      lat ?? 0,
      long ?? 0,
    );
    setState(() {
      meters = distanceinmeters / 1609.344;
    });
    print(widget.user.geopoint!.latitude);
  }

  void getCurrentUserLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation();
    getMilesAway();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Container(
                      decoration: BoxDecoration(
                        //  borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.user.imageUrls![1],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocBuilder<SwipeBloc, SwipeState>(
                      builder: (context, state) {
                        if (state is SwipeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SwipeLoaded) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<SwipeBloc>().add(
                                        SwipeLeftEvent(user: state.users[0]));
                                    Navigator.pop(context);
                                  },
                                  child: ChoiceButton(
                                    height: 60,
                                    hasGradient: false,
                                    width: 60,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    icon: Icons.clear_rounded,
                                    size: 25,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<SwipeBloc>().add(
                                        SwipeRightEvent(user: state.users[0]));
                                    Navigator.pop(context);
                                  },
                                  child: ChoiceButton(
                                    height: 80,
                                    width: 80,
                                    hasGradient: true,
                                    color: Colors.white,
                                    linear1:
                                        Theme.of(context).colorScheme.secondary,
                                    linear2:
                                        Theme.of(context).colorScheme.primary,
                                    icon: Icons.favorite,
                                    size: 35,
                                  ),
                                ),
                                ChoiceButton(
                                  height: 60,
                                  width: 60,
                                  hasGradient: false,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  icon: CupertinoIcons.bolt,
                                  size: 25,
                                ),
                              ],
                            ).fadeInList(7, true),
                          );
                        } else {
                          return const Text('Something went wrong.');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${widget.user.name}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(widget.user.age ?? '',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        AntIcons.homeOutlined,
                        size: 18,
                        color: Color.fromARGB(136, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Lives in ${widget.user.location ?? ''}',
                        style: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(136, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/briefcase.png',
                        height: 20,
                        color: const Color.fromARGB(136, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        widget.user.bio ?? '',
                        style: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(136, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Color.fromARGB(136, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        '${meters!.toStringAsFixed(0)} miles away',
                        style: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(136, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 15),
                  // Text('About',
                  //     style: GoogleFonts.aBeeZee(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     )),
                  // Text(
                  //   widget.user.bio ?? '',
                  // ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Wrap(
                      children: [
                        (widget.user.imageUrls!.length > 2)
                            ? CustomImageContainer(
                                imageUrl: widget.user.imageUrls![2],
                              )
                            : Container(),
                        (widget.user.imageUrls!.length > 3)
                            ? CustomImageContainer(
                                imageUrl: widget.user.imageUrls![3],
                              )
                            : Container(),
                        (widget.user.imageUrls!.length > 4)
                            ? CustomImageContainer(
                                imageUrl: widget.user.imageUrls![4],
                              )
                            : Container(),
                        (widget.user.imageUrls!.length > 5)
                            ? CustomImageContainer(
                                imageUrl: widget.user.imageUrls![5],
                              )
                            : Container(),
                        (widget.user.imageUrls!.length > 6)
                            ? CustomImageContainer(
                                imageUrl: widget.user.imageUrls![6],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  // Visibility(
                  //   visible: widget.user.imageUrls!.length > 3,
                  //   child: CustomImageContainer(
                  //     imageUrl: widget.user.imageUrls![],
                  //   ),
                  // ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Text(
                    'About Me',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Introverted, Extroverted, and Open-minded, I Love watching movies & reading books.',
                    style: GoogleFonts.aBeeZee(
                      color: const Color.fromARGB(136, 0, 0, 0),
                      fontSize: 15,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Text(
                    'My interests',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    children: widget.user.interests!
                        .map(
                          (interest) => Padding(
                            padding:
                                const EdgeInsets.only(right: 11.0, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(30)),
                              height: 30,
                              width: 90,
                              child: Center(
                                  child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  interest,
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const Divider(),
                  Text(
                    'Share ${widget.user.name}\'s Profile',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Text(
                                      'Report',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'We wont tell ${widget.user.name}',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Report ${widget.user.name}',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
