part of 'film_review_bloc.dart';

sealed class FilmReviewEvent {}

class SearchFilmByIDEvent extends FilmReviewEvent {
  final int id;
  final FilmReviewModel? film;

  SearchFilmByIDEvent({
    required this.id,
    this.film,
  });
}
