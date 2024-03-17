import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:flutter/material.dart';

class FilmActors extends StatelessWidget {
  final FilmReviewModel reviewData;
  const FilmActors({
    super.key,
    required this.reviewData,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: reviewData.actors.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: reviewData.actors[index].photo,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 8 + MediaQuery.of(context).padding.bottom,
                        horizontal: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      reviewData.actors[index].name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Text(
                      reviewData.actors[index].profession.replaceFirst(
                          reviewData.actors[index].profession.characters.first
                              .toString(),
                          reviewData.actors[index].profession.characters.first
                              .toString()
                              .toUpperCase()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
