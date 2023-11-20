import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hotAndnew/bloc/hotandnew_bloc.dart';
import 'package:netflix/domain/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/new_and_hot/widget/coming_soon_widget.dart';
import 'package:netflix/presentation/new_and_hot/widget/everyones_watching_widget.dart';

import '../widgets/app_bar_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBarWidget(
                title: 'New & Hot',
              )),
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: KWhiteColor,
              labelColor: KBlackColor,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              indicator: BoxDecoration(
                color: KWhiteColor,
                borderRadius: KRadius30,
              ),
              tabs: const [
                Tab(
                  text: '🍿 Coming Soon',
                ),
                Tab(
                  text: "👀 Everyone's watching",
                )
              ]),
        ),
        body: const TabBarView(children: [
          ComingSoonList(
            key: Key('coming_soon'),
          ),
          EveryoneIsWatchingList(
            key: Key('everyone_is_watching'),
          ),
        ]),
        //   body: Text('New and Hot'),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotandnewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading coming soon list'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('Coming soon list is empty'),
            );
          } else {
            return ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formatedDate = DateFormat.yMMMd('en_US').format(_date);
                  return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: formatedDate
                        .split('  ')
                        .first
                        .substring(0, 3)
                        .toUpperCase(),
                    day: movie.releaseDate!.split('-')[1],
                    posterpath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? "No title",
                    description: movie.overview ?? 'no discription',
                  );
                });
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotandnewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading coming soon list'),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('Coming soon list is empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.everyOneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.everyOneIsWatchingList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }

                  final tv = state.everyOneIsWatchingList[index];
                  return EveryonesWatchingWidget(
                    posterpath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No name',
                    description: tv.overview ?? 'No description',
                  );
                });
          }
        },
      ),
    );
  }
}
