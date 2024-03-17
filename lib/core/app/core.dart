import 'package:cinema_review/feutures/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return const MaterialApp(
      home: SearchScreen(),
    );
  }
}
