import 'package:cinema_review/feutures/film/data/api/get_film_by_id.dart';
import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'film_review_event.dart';
part 'film_review_state.dart';

class FilmReviewBloc extends Bloc<FilmReviewEvent, FilmReviewState> {
  FilmReviewBloc() : super(FilmReviewInitial()) {
    on<SearchFilmByIDEvent>((event, emit) async {
      if (event.film == null) {
        var response = await getFilmsByID(event.id);
        if (response != null) {
          var review = FilmReviewModel.fromJSON(response);
          emit(SearchSuccess(review: review));
        } else {
          emit(SearchFailed());
        }
      } else {
        emit(SearchSuccess(review: event.film!));
      }
    });
  }
}
