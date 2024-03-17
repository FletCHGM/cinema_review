import 'package:cinema_review/feutures/favorite/bloc/favorite_bloc.dart';
import 'package:cinema_review/feutures/favorite/widgets/film_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteSreen extends StatefulWidget {
  const FavoriteSreen({super.key});

  @override
  State<FavoriteSreen> createState() => _FavoriteSreenState();
}

class _FavoriteSreenState extends State<FavoriteSreen> {
  late final FavoriteBloc bloc;
  @override
  void initState() {
    bloc = FavoriteBloc();
    bloc.add(GetFavoriteEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget widgetSwitch(FavoriteState state) {
    switch (state) {
      case FavoriteInitial():
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      case SuccessState():
        return FilmListWidget(films: state.films);
      case EmptyState():
        return const Center(
          child: Text(
            'Вы пока не сохранили ни одной ленты',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.orange,
              backgroundColor: Colors.orange,
              title: const Text(
                'Избранные ленты',
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
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
              child: widgetSwitch(state),
            ),
          );
        },
      ),
    );
  }
}
