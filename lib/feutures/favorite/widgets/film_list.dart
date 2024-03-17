import 'package:cinema_review/feutures/favorite/widgets/components/film_tile_widget.dart';
import 'package:cinema_review/feutures/film/data/model/film_review_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilmListWidget extends StatefulWidget {
  final List<FilmReviewModel> films;
  const FilmListWidget({super.key, required this.films});

  @override
  State<FilmListWidget> createState() => _FilmListWidgetState();
}

class _FilmListWidgetState extends State<FilmListWidget> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
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
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        separatorBuilder: (context, index) => const Gap(12),
        itemCount: widget.films.length,
        itemBuilder: (context, index) {
          return FilmTileWidget(
            film: widget.films[index],
          );
        },
      ),
    );
  }
}
