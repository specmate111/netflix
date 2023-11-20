import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/bloc/search_bloc.dart';
import 'package:netflix/domain/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widget/title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitile(
          title: 'Top Searches',
        ),
        KHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return Center(
                  child: Text('Error Occured'),
                );
              } else if (state.idleList.isEmpty) {
                Center(
                  child: Text('List is Empty'),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = state.idleList[index];
                    return TopSearchItemTile(
                        title: movie.title ?? 'No title',
                        imageUrl: '$imageAppendUrl${movie.posterPath}');
                  },
                  separatorBuilder: (context, index) => KHeight20,
                  itemCount: state.idleList.length);
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
            color: KWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )),
        CircleAvatar(
            backgroundColor: KWhiteColor,
            radius: 25,
            child: CircleAvatar(
              backgroundColor: KBlackColor,
              radius: 23,
              child: Center(
                child: Icon(
                  CupertinoIcons.play_fill,
                  color: KWhiteColor,
                ),
              ),
            ))
      ],
    );
  }
}
