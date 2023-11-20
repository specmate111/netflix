import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/bloc/search_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widget/title.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitile(title: 'Movies & TV'),
        KHeight,
        Expanded(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1 / 1.4,
                children: List.generate(
                  20,
                  (index) {
                    //final movie = state.searchResultList[index];
                    return Maincard(
                        imageUrl:
                            '$imageAppendUrl${state.searchResultList[index].posterPath}');
                  },
                ));
          },
        ))
      ],
    );
  }
}

class Maincard extends StatelessWidget {
  final String imageUrl;
  const Maincard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(7)),
    );
  }
}
