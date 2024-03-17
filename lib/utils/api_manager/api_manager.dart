import 'dart:io';

import 'package:dio/dio.dart';

var apiManager = Dio(
  BaseOptions(
    baseUrl: 'https://api.kinopoisk.dev',
    headers: {
      'X-API-KEY': 'JHJXSQ2-99XMZB5-MXFCCPZ-AZADDG3',
    },
  ),
);

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (_) {
    return false;
  }
}
