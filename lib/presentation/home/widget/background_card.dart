import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/core/colors/colors.dart';
import '../../../core/constants.dart';
import 'custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(KMainImage))),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget(
                  icon: Icons.add,
                  title: 'My List',
                ),
                _PlayButton(),
                CustomButtonWidget(icon: Icons.info, title: 'Info')
              ],
            ),
          ),
        )
      ],
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(KWhiteColor)),
        icon: Icon(
          Icons.play_arrow,
          color: KBlackColor,
          size: 25,
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Play',
            style: TextStyle(color: KBlackColor, fontSize: 20),
          ),
        ));
  }
}
