import 'package:flutter/cupertino.dart';

import '../../../core/constants.dart';
import '../../widgets/main_title.dart';
import 'number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    super.key,
    required this.postersList,
  });
  final List<String> postersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(
          title: 'Top 10 TV Shows',
        ),
        KHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10,
                (index) => NumberCard(
                  index: index,
                  imageUrl: postersList[index],
                ),
              )),
        )
      ],
    );
  }
}
