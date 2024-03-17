import 'package:cinema_review/feutures/favorite/favorite_screen.dart';
import 'package:cinema_review/feutures/search/bloc/search_film_bloc.dart';
import 'package:cinema_review/feutures/search/widgets/films_cards_grid/film_cards_grid.dart';
import 'package:cinema_review/feutures/search/widgets/search_feild/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchFilmBloc bloc;
  @override
  void initState() {
    bloc = SearchFilmBloc();

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  Widget widgetSwitch(SearchFilmState state) {
    switch (state) {
      case SearchFilmInitial():
        return const Expanded(
          child: Center(
            child: Text(
              'Начните вводить название фильма',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      case SearchFailed():
        return const Expanded(
          child: Center(
            child: Text(
              'Что-о пошло не так!\nПроверьте ваше соединение с интернетом.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      case SearchSucces():
        return FilmCardsGrid(
          cards: state.cards,
          isLastCards: state.isLastCards,
        );
      case LoadingState():
        return const Expanded(
          child: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const FavoriteSreen(),
                    ));
              },
              icon: const Icon(
                Icons.star_rounded,
                size: 35,
                color: Colors.black,
              ))
        ],
        surfaceTintColor: Colors.orange,
        backgroundColor: Colors.orange,
        title: const Text(
          'Найти на кинопоиске',
        ),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<SearchFilmBloc, SearchFilmState>(
          bloc: bloc,
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Color.fromARGB(255, 175, 105, 0),
                  ],
                  stops: [0.15, 1],
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: FilmSearchField(),
                  ),
                  widgetSwitch(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
