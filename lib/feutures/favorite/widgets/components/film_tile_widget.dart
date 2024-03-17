import 'package:cinema_review/feutures/favorite/bloc/favorite_bloc.dart';
import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:cinema_review/feutures/film/film_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmTileWidget extends StatelessWidget {
  final FilmReviewModel film;
  const FilmTileWidget({
    super.key,
    required this.film,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FilmScreen(
              id: film.id,
              name: film.name,
              film: film,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.transparent,
              Colors.orange,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                film.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<FavoriteBloc>(context)
                    .add(DeleteFilmEvent(film: film));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
