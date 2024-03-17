import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_review/feutures/film/film_screen.dart';
import 'package:cinema_review/feutures/search/data/model/film_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilmCardWidget extends StatefulWidget {
  final FilmCardModel cardModel;
  const FilmCardWidget({
    super.key,
    required this.cardModel,
  });

  @override
  State<FilmCardWidget> createState() => _FilmCardWidgetState();
}

class _FilmCardWidgetState extends State<FilmCardWidget> {
  bool isInfoActive = false;
  bool isPosterView = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => FilmScreen(
                  id: widget.cardModel.id, name: widget.cardModel.name),
            ));
      },
      child: Stack(
        children: [
          widget.cardModel.posterUrl.isEmpty
              ? Container(
                  color: Colors.black.withOpacity(0.8),
                  child: const Center(
                    child: Icon(
                      Icons.local_movies,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: widget.cardModel.posterUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Container(
                      color: Colors.black.withOpacity(0.8),
                      child: const Center(
                        child: Icon(
                          Icons.local_movies,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
          AnimatedOpacity(
            opacity: isInfoActive || isPosterView ? 0 : 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment(-1, 0),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isInfoActive || isPosterView ? 0 : 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment(1, 0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: Text(
                      widget.cardModel.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Кинопоиск: ${widget.cardModel.rating} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 14,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isInfoActive ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
              ),
              child: Column(
                children: [
                  Text(
                    widget.cardModel.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.cardModel.shortDescription == null
                            ? 'Нет кратного описания'
                            : widget.cardModel.shortDescription!.isEmpty
                                ? 'Нет краткого описания'
                                : widget.cardModel.shortDescription!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPosterView = !isPosterView;
                        isInfoActive = false;
                      });
                    },
                    child: Icon(
                      Icons.visibility,
                      color: isInfoActive ? Colors.black : Colors.white,
                      size: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isInfoActive = !isInfoActive;
                        isPosterView = false;
                      });
                    },
                    child: Icon(
                      isInfoActive ? Icons.close : Icons.info_outline,
                      color: isInfoActive ? Colors.black : Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
