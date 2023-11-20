import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: KRadius10,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imageUrl,
            ),
          )),
    );
  }
}
