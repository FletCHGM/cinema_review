part of 'search_film_bloc.dart';

sealed class SearchFilmState {}

final class SearchFilmInitial implements SearchFilmState {}

class SearchFailed implements SearchFilmState {}

class SearchSucces implements SearchFilmState {
  final List<FilmCardModel> cards;
  final bool isLastCards;

  SearchSucces({
    required this.cards,
    required this.isLastCards,
  });
}

class LoadingState implements SearchFilmState {}
