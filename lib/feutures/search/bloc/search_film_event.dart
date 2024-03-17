part of 'search_film_bloc.dart';

class SearchFilmEvent {}

class SearchByNameEvent extends SearchFilmEvent {
  final String name;

  SearchByNameEvent({required this.name});
}

class SearchByNamePagginationEvent extends SearchFilmEvent {}
