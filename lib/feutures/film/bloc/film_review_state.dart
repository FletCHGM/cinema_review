part of 'film_review_bloc.dart';

sealed class FilmReviewState {}

final class FilmReviewInitial implements FilmReviewState {}

class SearchSuccess implements FilmReviewState {
  final FilmReviewModel review;
  SearchSuccess({
    required this.review,
  });
}

class SearchFailed implements FilmReviewState {}
