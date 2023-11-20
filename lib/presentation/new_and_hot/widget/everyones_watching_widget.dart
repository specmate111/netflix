import 'package:flutter/material.dart';

import '../../../domain/core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widget/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterpath;
  final String movieName;
  final String description;

  const EveryonesWatchingWidget({
    super.key,
    required this.posterpath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KHeight,
        Text(
          movieName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        KHeight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: KGreyColor),
        ),
        KHeight50,
        VideoWidget(
          url: posterpath,
        ),
        KHeight,
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWidget(
              icon: Icons.share,
              title: 'Share',
              iconsize: 25,
              textsize: 16,
            ),
            KWidth,
            CustomButtonWidget(
              icon: Icons.add,
              title: 'My List',
              iconsize: 25,
              textsize: 16,
            ),
            KWidth,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              title: 'Play',
              iconsize: 25,
              textsize: 16,
            ),
            KWidth
          ],
        )
      ],
    );
  }
}
