import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widget/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterpath;
  final String movieName;
  final String description;

  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterpath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    month,
                    style: const TextStyle(fontSize: 16, color: KGreyColor),
                  ),
                  Text(
                    day,
                    style: const TextStyle(
                        letterSpacing: 4,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              width: size.width - 50,
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoWidget(
                    url: posterpath,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movieName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const CustomButtonWidget(
                        icon: Icons.notifications_outlined,
                        title: 'Remind me',
                        iconsize: 20,
                        textsize: 10,
                      ),
                      KWidth,
                      const CustomButtonWidget(
                        icon: Icons.info,
                        title: 'info',
                        iconsize: 20,
                        textsize: 10,
                      ),
                      KWidth,
                    ],
                  ),
                  // KHeight,
                  Text('Coming on $day $month'),
                  KHeight,
                  Text(
                    movieName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  KHeight,
                  Text(
                    description,
                    maxLines: 4,
                    style: const TextStyle(color: KGreyColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
