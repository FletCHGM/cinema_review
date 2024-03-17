import 'package:cinema_review/feutures/film/data/api/get_film_by_id.dart';
import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:cinema_review/utils/database/database.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    List<FilmReviewModel> films = [];
    on<GetFavoriteEvent>((event, emit) async {
      try {
        var local = await dataBaseManager.localUnixtimeUpdate;
        var remote = await dataBaseManager.remoteUnixtimeUpdate;
        if (remote > local) {
          List<int> ids = await getRemoteFilms();
          await clearLocalDatabase();
          for (var id in ids) {
            var element = await getFilmsByID(id);
            if (element != null) {
              films.add(FilmReviewModel.fromJSON(element));
              insertNewFilmToLocalDatabase(FilmReviewModel.fromJSON(element));
            }
          }
          if (films.isNotEmpty) {
            emit(SuccessState(films: films));
          } else {
            emit(EmptyState());
          }
        } else if (local < remote) {
          var result = await getLocalFilms();
          await clearRemoteDatabase();
          for (var element in result) {
            await insertNewFilmToRemoteDatabase(element);
          }
          if (films.isNotEmpty) {
            emit(SuccessState(films: films));
          } else {
            emit(EmptyState());
          }
        } else {
          var result = await getLocalFilms();
          films = result;
          if (result.isNotEmpty) {
            emit(SuccessState(films: films));
          } else {
            emit(EmptyState());
          }
        }
      } on Exception catch (_) {
        var result = await getLocalFilms();
        films = result;
        if (result.isNotEmpty) {
          emit(SuccessState(films: films));
        } else {
          emit(EmptyState());
        }
      }
    });
    on<DeleteFilmEvent>((event, emit) async {
      films.remove(event.film);
      emit(SuccessState(films: films));
      await deleteFilmFromLocalDatabase(event.film);
      await deleteFilmFromRemoteDatabase(event.film);
    });
  }
}
