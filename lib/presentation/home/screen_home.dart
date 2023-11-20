import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/bloc/home_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widget/background_card.dart';
import 'package:netflix/presentation/home/widget/number_title_card.dart';

import '../widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (BuildContext context, index, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        } else if (state.hasError) {
                          return const Center(
                            child: Text(
                              'Error while getting Data',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        //released past year posters calling
                        final _releasedPastYear =
                            state.pastYearMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        _releasedPastYear.shuffle();

                        //trending posters calling

                        final _trending = state.trendingMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        _trending.shuffle();

                        //tense drama poster calling

                        final _tenseDramas =
                            state.tenseDramasMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        _tenseDramas.shuffle();

                        // southIndian Movies poster calling

                        final _southIndianMovies =
                            state.southIndianMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        _southIndianMovies.shuffle();

                        //top 10 tv shows
                        final _top10TvShows = state.trendingTvList.map((t) {
                          return '$imageAppendUrl${t.posterPath}';
                        }).toList();
                        //_top10TvShows.shuffle();

                        return ListView(
                          children: [
                            BackgroundCard(),
                            MainTitleCard(
                              title: 'Released in the past year',
                              posterList: _releasedPastYear,
                            ),
                            KHeight,
                            MainTitleCard(
                              title: 'Tending Now',
                              posterList: _trending,
                            ),
                            KHeight,
                            NumberTitleCard(
                              postersList: _top10TvShows,
                            ),
                            KHeight,
                            MainTitleCard(
                              title: 'Tense Dramas',
                              posterList: _tenseDramas,
                            ),
                            KHeight,
                            MainTitleCard(
                              title: 'South Indian Cinema',
                              posterList: _southIndianMovies,
                            ),
                            KHeight,
                          ],
                        );
                      },
                    ),
                    scrollNotifier.value == true
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            width: double.infinity,
                            height: 70,
                            color: Colors.black.withOpacity(0.3),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      'https://pbs.twimg.com/profile_images/1671510098169180161/xdQUtnOJ_400x400.jpg',
                                      width: 50,
                                      height: 50,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    KWidth,
                                    Container(
                                      height: 30,
                                      width: 30,
                                      color: Colors.blue,
                                    ),
                                    KWidth,
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('TV Shows', style: KHomeTitleText),
                                    Text(
                                      'Movies',
                                      style: KHomeTitleText,
                                    ),
                                    Text(
                                      'Categories',
                                      style: KHomeTitleText,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : KHeight
                  ],
                ),
              );
            }));
  }
}
