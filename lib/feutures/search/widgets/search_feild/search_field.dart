import 'dart:async';

import 'package:cinema_review/feutures/search/bloc/search_film_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmSearchField extends StatefulWidget {
  const FilmSearchField({
    super.key,
  });

  @override
  State<FilmSearchField> createState() => _FilmSearchFieldState();
}

class _FilmSearchFieldState extends State<FilmSearchField> {
  Timer? _debounce;
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onEditingComplete: () {},
      onChanged: (value) {
        setState(() {});
        if (value.length >= 3) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 300), () {
            BlocProvider.of<SearchFilmBloc>(context)
                .add(SearchByNameEvent(name: controller.value.text));
          });
        }
      },
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        hintText: 'Введие название фильма для поиска',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        suffixIcon: controller.value.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    controller.clear();
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 20,
                ),
              )
            : const Icon(
                Icons.search,
                color: Colors.grey,
                size: 20,
              ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),
    );
  }
}
