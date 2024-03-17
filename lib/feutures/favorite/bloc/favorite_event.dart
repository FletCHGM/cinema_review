part of 'favorite_bloc.dart';

class FavoriteEvent {}

class GetFavoriteEvent extends FavoriteEvent {}

class DeleteFilmEvent extends FavoriteEvent {
  final FilmReviewModel film;

  DeleteFilmEvent({required this.film});
}
