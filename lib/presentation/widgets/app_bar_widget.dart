import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
        ),
        KWidth,
        Container(
          height: 30,
          width: 30,
          color: Colors.blue,
        ),
        KWidth,
      ],
    );
  }
}
