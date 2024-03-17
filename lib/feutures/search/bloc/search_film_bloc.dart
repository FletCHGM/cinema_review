import 'package:cinema_review/feutures/search/data/api/get_films_by_name.dart';
import 'package:cinema_review/feutures/search/data/model/film_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_film_event.dart';
part 'search_film_state.dart';

class SearchFilmBloc extends Bloc<SearchFilmEvent, SearchFilmState> {
  SearchFilmBloc() : super(SearchFilmInitial()) {
    var page = 1;
    int limit = 0;
    var name = '';
    List<FilmCardModel> cardsTotal = [];
    on<SearchByNameEvent>((event, emit) async {
      page = 1;
      name = event.name;
      cardsTotal.clear();
      emit(LoadingState());
      var response = await getFilmsByName(event.name, page);
      page++;
      if (response != null) {
        limit = response['pages'];
        var cards = List.generate(
          response['docs'].length,
          (index) => FilmCardModel.fromJSON(
            response['docs'][index],
          ),
        );
        cardsTotal = cards;
        emit(SearchSucces(
            cards: cards, isLastCards: limit == cardsTotal.length));
      } else {
        emit(SearchFailed());
      }
    });
    on<SearchByNamePagginationEvent>((event, emit) async {
      if (limit > cardsTotal.length) {
        var response = await getFilmsByName(name, page);
        page++;
        if (response != null) {
          for (var card in response['docs']) {
            cardsTotal.add(FilmCardModel.fromJSON(
              card,
            ));
          }
          emit(SearchSucces(cards: cardsTotal, isLastCards: false));
        } else {
          emit(SearchFailed());
        }
      } else {
        emit(SearchSucces(cards: cardsTotal, isLastCards: true));
      }
    });
  }
}
