import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/bloc/downloads_bloc.dart';
import 'package:netflix/domain/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final _widgetsList = [
    const _SmartDownloads(),
    Section2(),
    Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
            child: AppBarWidget(
              title: 'Downloads',
            ),
            preferredSize: Size.fromHeight(50)),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _widgetsList[index],
            separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
            itemCount: _widgetsList.length));
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<DownloadsBloc>(context)
            .add(const DownloadsEvent.getDownloadsImage());
      },
    );
    return Column(
      children: [
        const Text(
          'Introducing Downloads For You',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: KWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        KHeight,
        const Text(
          "We will download a personalised selection of\n movies and shows for you, so there's\nalways something to watch on your\ndevice",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        KHeight,
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isloading
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.38,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                        ),
                        DownloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads[0].posterPath}',
                          margin: EdgeInsets.only(left: 170, top: 50),
                          angle: 25,
                          size: Size(size.width * 0.35, size.width * 0.55),
                        ),
                        DownloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads[1].posterPath}',
                          margin: EdgeInsets.only(right: 170, top: 50),
                          angle: -25,
                          size: Size(size.width * 0.35, size.width * 0.55),
                        ),
                        DownloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads[2].posterPath}',
                          margin: EdgeInsets.only(bottom: 35, top: 50),
                          size: Size(size.width * 0.4, size.width * 0.6),
                          radius: 30,
                        )
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: Colors.indigo,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Set up',
                style: TextStyle(
                  color: KWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        KHeight,
        MaterialButton(
          color: KButtonColorWhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download',
              style: TextStyle(
                color: KBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KWidth,
        Icon(
          Icons.settings,
          color: KWhiteColor,
        ),
        KWidth,
        Text('Smart Downloads'),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    super.key,
    required this.imageList,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.radius = 10,
  });

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            // margin: margin,
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imageList,
                    ))),
          ),
        ),
      ),
    );
  }
}
