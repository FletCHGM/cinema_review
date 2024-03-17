import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:cinema_review/feutures/film/widgets/components/actors.dart';
import 'package:cinema_review/feutures/film/widgets/components/info.dart';
import 'package:cinema_review/feutures/film/widgets/components/poster.dart';
import 'package:cinema_review/feutures/film/widgets/components/trailer.dart';
import 'package:flutter/material.dart';

class FilmReviewWidget extends StatelessWidget {
  final FilmReviewModel reviewData;
  const FilmReviewWidget({
    super.key,
    required this.reviewData,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        FilmPoster(reviewData: reviewData),
        FilmActors(reviewData: reviewData),
        reviewData.trailers.isEmpty
            ? const Center(
                child: Text(
                  'Не удалось найти трейлер',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            : VideoPlayer(url: reviewData.trailers.first.url),
        FilmInfo(
          reviewData: reviewData,
        ),
      ],
    );
  }
}
