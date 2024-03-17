import 'package:cinema_review/feutures/film/bloc/film_review_bloc.dart';
import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:cinema_review/feutures/film/widgets/film_review_widget.dart';
import 'package:cinema_review/utils/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmScreen extends StatefulWidget {
  final int id;
  final String name;
  final FilmReviewModel? film;
  const FilmScreen({
    super.key,
    required this.id,
    required this.name,
    this.film,
  });

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  late final FilmReviewBloc bloc;
  bool isSaving = false;
  bool isSaved = false;
  @override
  void initState() {
    bloc = FilmReviewBloc();
    bloc.add(SearchFilmByIDEvent(
      id: widget.id,
      film: widget.film,
    ));
    if (widget.film != null) {
      setState(() {
        isSaved = true;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget widgetSwitch(FilmReviewState state) {
    switch (state) {
      case FilmReviewInitial():
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      case SearchSuccess():
        return FilmReviewWidget(
          reviewData: state.review,
        );
      case SearchFailed():
        return const Center(
          child: Text(
            'Что-о пошло не так!\nПроверьте ваше соединение с интернетом.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
    }
  }

  Future<void> _saveFilm(final FilmReviewModel film) async {
    await insertNewFilmToLocalDatabase(film);
    await insertNewFilmToRemoteDatabase(film);
  }

  Future<void> _deleteFilm(final FilmReviewModel film) async {
    await deleteFilmFromLocalDatabase(film);
    await deleteFilmFromRemoteDatabase(film);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<FilmReviewBloc, FilmReviewState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      if (!isSaving && state is SearchSuccess && !isSaved) {
                        setState(() {
                          isSaving = true;
                          isSaved = true;
                        });
                        _saveFilm(state.review).then((value) {
                          setState(() {
                            isSaving = false;
                          });
                        });
                      }
                      if (!isSaving && state is SearchSuccess && isSaved) {
                        setState(() {
                          isSaving = true;
                          isSaved = false;
                        });
                        _deleteFilm(state.review).then((value) {
                          setState(() {
                            isSaving = false;
                          });
                        });
                      }
                    },
                    icon: Icon(
                      isSaved ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: 35,
                      color: Colors.black,
                    ))
              ],
              surfaceTintColor: Colors.orange,
              backgroundColor: Colors.orange,
              title: Text(
                widget.name,
              ),
            ),
            body: widget.film != null
                ? FilmReviewWidget(reviewData: widget.film!)
                : widgetSwitch(state),
          );
        },
      ),
    );
  }
}
