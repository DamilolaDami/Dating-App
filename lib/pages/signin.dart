import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tiki/authentications_bloc/cubits/signup_cubit.dart';
import 'package:tiki/instances/login_status.dart';
import 'package:tiki/pages/homepage.dart';
import 'package:tiki/pages/tabs/mainpage.dart';
import 'package:tiki/respositories/mainauth.dart';
import 'package:tiki/widgets/custom_textfield.dart';
import 'package:tiki/widgets/header.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? error;
  AuthRepository? authRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.only(right: 60.0),
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
                  ),
                ])),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 11,
                ),

                // SizedBox(
                //   height: 200,
                //   width: 200,
                //   child: Lottie.asset(
                //     'assets/animations/onboaring_love.json',
                //   ),
                // ),
                RichText(
                  text: TextSpan(
                      text: 'Hey there,',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: '\nWelcome back!',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.mail),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.aBeeZee(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          suffixIcon: const Icon(AntIcons.lockFilled),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.aBeeZee(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 210.0),
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        if (value == null) {
                          print('error');
                        } else {
                          Instances.saveLoginStatus('loggedIn');
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const MainPage(),
                              ));
                        }
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        error = 'The password provided is too weak.';

                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        setState(() {
                          error = 'The account already exists for that email.';
                        });

                        print('The account already exists for that email.');
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          error = "Wrong password provided for that user.";
                        });
                      } else if (e.code == 'user-not-found') {
                        setState(() {
                          error = 'No user found for that email.';
                        });
                      } else {
                        error =
                            'you are currently offline, please reconnect to internet';
                      }
                    } catch (e) {
                      error = e.toString();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(error!),
                              actions: [
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });

                      print(e);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text('Sign In',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
