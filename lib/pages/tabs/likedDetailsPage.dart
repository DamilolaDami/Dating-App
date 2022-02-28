import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiki/animations/fadeinanimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiki/models/user.dart';
import 'package:tiki/widgets/choicebtn.dart';
import 'package:tiki/widgets/image_container.dart';

class LikedDetailsPage extends StatefulWidget {
  final List? liedUserImageUrls;
  final List? likedUserinterests;
  final String? docid;
  final String? likedUserName;
  final String? likedJob;
  final String? likedUserage;
  final bool? matched;

  const LikedDetailsPage({
    Key? key,
    this.liedUserImageUrls,
    this.likedUserinterests,
    this.likedUserName,
    this.docid,
    this.likedJob,
    this.matched,
    this.likedUserage,
  }) : super(key: key);

  @override
  _LikedDetailsPageState createState() => _LikedDetailsPageState();
}

class _LikedDetailsPageState extends State<LikedDetailsPage> {
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
                            widget.liedUserImageUrls![1],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // context.read<SwipeBloc>().add(
                                //     SwipeLeftEvent(user: state.users[0]));
                                // Navigator.pop(context);
                              },
                              child: ChoiceButton(
                                height: 60,
                                hasGradient: false,
                                width: 60,
                                color: Theme.of(context).colorScheme.secondary,
                                icon: Icons.clear_rounded,
                                size: 25,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('likeduser')
                                    .doc(widget.docid)
                                    .update({
                                  'matched': true,
                                }).then((value) => {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('Matched'),
                                          ))
                                        });
                                // context.read<SwipeBloc>().add(
                                //     SwipeRightEvent(user: state.users[0]));
                                // Navigator.pop(context);
                              },
                              child: ChoiceButton(
                                height: 80,
                                width: 80,
                                hasGradient: true,
                                color: Colors.white,
                                linear1:
                                    Theme.of(context).colorScheme.secondary,
                                linear2: Theme.of(context).colorScheme.primary,
                                icon: Icons.favorite,
                                size: 35,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.matched == false) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        'You haven\'t matched with this user yet'),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ));
                                } else {}
                              },
                              child: ChoiceButton(
                                height: 60,
                                width: 60,
                                hasGradient: false,
                                color: widget.matched == false
                                    ? Colors.grey
                                    : Theme.of(context).colorScheme.secondary,
                                icon: CupertinoIcons.chat_bubble_2_fill,
                                size: 25,
                              ),
                            ),
                          ],
                        )),
                  )
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
                      Text('${widget.likedUserName}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(widget.likedUserage ?? '',
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
                        'Lives in ${widget.likedJob ?? ''}',
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
                        widget.likedJob ?? '',
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
                      // Text(
                      //   '${meters!.toStringAsFixed(0)} miles away',
                      //   style: GoogleFonts.aBeeZee(
                      //     color: const Color.fromARGB(136, 0, 0, 0),
                      //   ),
                      // // ),
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
                        (widget.liedUserImageUrls!.length > 2)
                            ? CustomImageContainer(
                                imageUrl: widget.liedUserImageUrls![2],
                              )
                            : Container(),
                        (widget.liedUserImageUrls!.length > 3)
                            ? CustomImageContainer(
                                imageUrl: widget.liedUserImageUrls![3],
                              )
                            : Container(),
                        (widget.liedUserImageUrls!.length > 4)
                            ? CustomImageContainer(
                                imageUrl: widget.liedUserImageUrls![4],
                              )
                            : Container(),
                        (widget.liedUserImageUrls!.length > 5)
                            ? CustomImageContainer(
                                imageUrl: widget.liedUserImageUrls![5],
                              )
                            : Container(),
                        (widget.liedUserImageUrls!.length > 6)
                            ? CustomImageContainer(
                                imageUrl: widget.liedUserImageUrls![6],
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
                    children: widget.likedUserinterests!
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
                    'Share ${widget.likedUserName}\'s Profile',
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
                                      'We wont tell ${widget.likedUserName}',
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
                      'Report ${widget.likedUserName}',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            ).fadeInList(7, true),
          ],
        ),
      ),
    );
  }
}
