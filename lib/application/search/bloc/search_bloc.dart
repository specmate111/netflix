import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:netflix/domain/search/models/search_response/search_response.dart';
import 'package:netflix/domain/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadService;
  final SearchService _searchService;
  SearchBloc(this._downloadService, this._searchService)
      : super(SearchState.initial()) {
/*
   Idle State event
*/
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
            searchResultList: [],
            idleList: state.idleList,
            isLoading: false,
            isError: false));

        return;
      }
      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));
      //get trending
      final _result = await _downloadService.getDownloadsImages();
      final _state = _result.fold((MainFailure failure) {
        return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true);
      }, (List<Downloads> list) {
        return SearchState(
            searchResultList: [],
            idleList: list,
            isLoading: false,
            isError: false);
      });

      //show to UI
      emit(_state);
    });

/*
   Seach Result State event
*/

    on<SearchMovie>((event, emit) async {
      // call search movie Api
      log('searching for ${event.movieQuery}');
      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));
      final _results =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = _results.fold((MainFailure failure) {
        return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true);
      }, (SearchResponse response) {
        return SearchState(
            searchResultList: response.results,
            idleList: [],
            isLoading: false,
            isError: false);
      });
      //show to UI
      emit(_state);
    });
  }
}
