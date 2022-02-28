import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tiki/animations/liked.dart';
import 'package:tiki/constatns/colors.dart';
import 'package:tiki/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiki/respositories/bloc/swipebloc_bloc.dart';
import 'package:tiki/widgets/choicebtn.dart';
import 'package:tiki/widgets/custom_text_container.dart';

class UserCard extends StatefulWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isAnimating = false;
  bool isLiked = false;
  double meters = 0;
  bool isDisliked = false;
  double? lat;
  double? long;
  double distance = 0;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getCurrentUserLocation();
    //  getMilesAway();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Stack(
              children: [
                SizedBox(
                  height: size.height / 1.4,
                  width: size.width,
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 4,
                              blurRadius: 10),
                        ],
                        image: DecorationImage(
                            image: NetworkImage(widget.user.imageUrls![1]),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                        child: Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(
                          widget.user.imageUrls!.length - 1,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 4,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              )),
                    )),
                    Container(
                        decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    )),
                    Positioned(
                      bottom: 10,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.user.name ?? '',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.info_outline_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.user.age.toString()}, ',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.user.location ?? '',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 68,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.count(
                              padding: const EdgeInsets.only(right: 90),
                              shrinkWrap: true,
                              childAspectRatio: 18 / 6,
                              crossAxisCount: 3,
                              children: widget.user.interests!.map((interest) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        interest,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 12,
                                        ),
                                      ))),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     UserImagesSmall(
                          //       index: 1,
                          //       user: widget.user,
                          //     ),
                          //     const SizedBox(
                          //       width: 4,
                          //     ),
                          //     UserImagesSmall(
                          //       index: 2,
                          //       user: widget.user,
                          //     ),
                          //     const SizedBox(
                          //       width: 4,
                          //     ),
                          //     UserImagesSmall(
                          //       index: 3,
                          //       user: widget.user,
                          //     ),
                          //     const SizedBox(
                          //       width: 4,
                          //     ),
                          //     UserImagesSmall(
                          //       index: 0,
                          //       user: widget.user,
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const ChoiceButton(
                                  height: 60,
                                  width: 60,
                                  hasGradient: false,
                                  isSvg: true,
                                  path: 'assets/svgs/refresh_icon.svg',
                                  color: AppColors.primary,
                                  icon: CupertinoIcons.arrow_clockwise,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDisliked = true;
                                    });
                                    context.read<SwipeBloc>().add(
                                        SwipeLeftEvent(user: state.users[0]));
                                  },
                                  child: ChoiceButton(
                                    height: 60,
                                    isSvg: true,
                                    hasGradient: false,
                                    linear1: Colors.red.withOpacity(.8),
                                    linear2: Colors.redAccent,
                                    path: 'assets/svgs/close_icon.svg',
                                    width: 60,
                                    color: Colors.white,
                                    icon: Icons.clear_rounded,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const ChoiceButton(
                                  height: 60,
                                  width: 60,
                                  hasGradient: false,
                                  isSvg: true,
                                  path: 'assets/svgs/star_icon.svg',
                                  color: AppColors.primary,
                                  icon: Icons.star,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAnimating = true;
                                      isLiked = true;
                                    });
                                    context.read<SwipeBloc>().add(
                                        SwipeRightEvent(user: state.users[0]));
                                  },
                                  child: const ChoiceButton(
                                    hasGradient: false,
                                    isSvg: true,
                                    height: 60,
                                    width: 60,
                                    path: 'assets/svgs/like_icon.svg',
                                    color: Colors.white,
                                    icon: Icons.favorite,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                // const ChoiceButton(
                                //   height: 60,
                                //   isSvg: true,
                                //   path: 'assets/svgs/thunder_icon.svg',
                                //   width: 60,
                                //   hasGradient: false,
                                //   color: AppColors.primary,
                                //   icon: CupertinoIcons.bolt_fill,
                                //   size: 25,
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                Positioned(
                  left: 50,
                  right: 50,
                  top: 50,
                  bottom: 50,
                  child: Opacity(
                    opacity: isAnimating ? 1 : 0,
                    child: HeartAnimationWidget(
                      onEnd: () {
                        setState(() {
                          isAnimating = false;
                        });
                      },
                      duration: const Duration(milliseconds: 700),
                      child: Container(
                        height: 20,
                        width: 20,
                        color: Colors.transparent,
                        child: Lottie.asset(
                          'assets/animations/love.json',
                        ),
                      ),
                      isAnimation: isAnimating,
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  right: 50,
                  top: 50,
                  bottom: 50,
                  child: Opacity(
                    opacity: isDisliked ? 1 : 0,
                    child: HeartAnimationWidget(
                      onEnd: () {
                        setState(() {
                          isDisliked = false;
                        });
                      },
                      duration: const Duration(milliseconds: 700),
                      child: SvgPicture.asset(
                        'assets/svgs/close_icon.svg',
                        height: 55,
                        width: 55,
                        fit: BoxFit.scaleDown,
                      ),
                      isAnimation: isDisliked,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class UserImagesSmall extends StatelessWidget {
  final User user;
  final int index;
  const UserImagesSmall({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(user.imageUrls![index]),
            )));
  }
}
