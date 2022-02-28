import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final bool hasGradient;
  final bool isSvg;
  final double size;
  final IconData icon;
  final Color color;
  final String? path;
  final Color? linear1;
  final Color? linear2;
  const ChoiceButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      this.path,
      required this.size,
      this.isSvg = false,
      this.linear1,
      this.linear2,
      required this.hasGradient,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: isSvg
          ? SvgPicture.asset(
              path ?? '',
              height: 25,
              width: 25,
              fit: BoxFit.scaleDown,
            )
          : Icon(
              icon,
              size: size,
              color: color,
            ),
      decoration: BoxDecoration(
        gradient: hasGradient
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                    linear1!,
                    linear2!,
                  ])
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(0, 3),
          )
        ],
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}
