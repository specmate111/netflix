import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/domain/core/colors/colors.dart';

import '../../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({
    super.key,
    required this.index,
    required this.imageUrl,
  });

  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: KRadius20,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  )),
            ),
          ],
        ),
        Positioned(
          left: 13,
          top: 50,
          //bottom: 0,
          child: BorderedText(
            strokeWidth: 10.0,
            strokeColor: KWhiteColor,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                  fontSize: 140,
                  color: KBlackColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
