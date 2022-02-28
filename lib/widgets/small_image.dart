import 'package:flutter/material.dart';
import 'package:tiki/constatns/colors.dart';
import 'package:flutter/cupertino.dart';

class UserImageSmall extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  const UserImageSmall({
    Key? key,
    required this.url,
    this.height = 60,
    this.width = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, right: 8),
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url),
            ),
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Positioned(
          bottom: 8,
          right: 10,
          child: Container(
            height: 12,
            width: 12,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 5, 238, 64),
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }
}
