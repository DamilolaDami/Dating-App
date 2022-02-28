import 'package:flutter/material.dart';
import 'package:tiki/constatns/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroungColor,
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
