import 'dart:async';

import 'package:cinema_review/feutures/search/bloc/search_film_bloc.dart';
import 'package:cinema_review/feutures/search/data/model/film_card_model.dart';
import 'package:cinema_review/feutures/search/widgets/films_cards_grid/components/film_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmCardsGrid extends StatefulWidget {
  final List<FilmCardModel> cards;
  final bool isLastCards;
  const FilmCardsGrid({
    super.key,
    required this.cards,
    required this.isLastCards,
  });

  @override
  State<FilmCardsGrid> createState() => _FilmCardsGridState();
}

class _FilmCardsGridState extends State<FilmCardsGrid> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black.withOpacity(0),
              Colors.black.withOpacity(0),
              Colors.black,
            ],
            stops: const [
              0.0,
              0.05,
              0.9,
              1.0,
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: widget.cards.isEmpty
            ? const Center(
                child: Text(
                  'По вашему запросу ничего не найдено.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent - 200 &&
                      !isLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    Timer(const Duration(milliseconds: 500), () {
                      setState(() {
                        isLoading = false;
                      });
                    });
                    BlocProvider.of<SearchFilmBloc>(context)
                        .add(SearchByNamePagginationEvent());
                  }
                  return true;
                },
                child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 26),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount:
                        widget.cards.length + (!widget.isLastCards ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (widget.cards.length == index && !widget.isLastCards) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return FilmCardWidget(
                          cardModel: widget.cards[index],
                        );
                      }
                    }),
              ),
      ),
    );
  }
}
