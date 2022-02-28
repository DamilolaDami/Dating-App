import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckbox extends StatelessWidget {
  final String text;

  const CustomCheckbox({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (bool? newValue) {},
        ),
        Text(
          text,
          style: GoogleFonts.aBeeZee(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
