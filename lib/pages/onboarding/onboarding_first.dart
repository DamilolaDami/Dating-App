import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tiki/widgets/custombtn.dart';

import '../signin.dart';

class Start extends StatefulWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(
                  'assets/animations/onboaring_love.json',
                ),
              ),
              const SizedBox(height: 50),
              Text('Welcome to DISCOVER'.toUpperCase(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              Text(
                'Discover is a platform that helps you find new friends and connect with people who share your interests and passions with you.',
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()));
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Already have an account? ',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign in',
                    style: GoogleFonts.aBeeZee(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
                  ),
                ])),
              ),
              const SizedBox(height: 10),
              CustomButton(
                  tabController: widget.tabController, text: 'GET STARTED'),
            ],
          ),
        ],
      ),
    );
  }
}
