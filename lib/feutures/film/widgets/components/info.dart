import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class FilmInfo extends StatelessWidget {
  final FilmReviewModel reviewData;
  const FilmInfo({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Премьера: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(reviewData.premierDate).toLocal())}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(12),
              Text(
                'Возрастной рейтинг: ${reviewData.ageRating}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(12),
              Text(
                'Кассовый сбор: ${reviewData.cash.isEmpty ? reviewData.cash : 'н.д.'}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(12),
              Text(
                'Количество голосов: ${reviewData.votesCount}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(12),
              Wrap(
                children: List.generate(reviewData.genres.length + 1, (index) {
                  if (index == 0) {
                    return const Text(
                      'Жанры: ',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    return Text(
                      reviewData.genres[index - 1] +
                          (index == reviewData.genres.length ? '' : ', '),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }
                }),
              ),
              const Gap(12),
            ],
          ),
        ),
      ],
    );
  }
}
