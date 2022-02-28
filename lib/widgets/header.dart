import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextHeader extends StatelessWidget {
  final String text;

  const CustomTextHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.aBeeZee(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ));
  }
}
