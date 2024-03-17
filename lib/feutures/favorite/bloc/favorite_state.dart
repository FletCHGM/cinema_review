part of 'favorite_bloc.dart';

sealed class FavoriteState {}

class FavoriteInitial implements FavoriteState {}

class SuccessState implements FavoriteState {
  final List<FilmReviewModel> films;

  SuccessState({required this.films});
}

class EmptyState implements FavoriteState {}
