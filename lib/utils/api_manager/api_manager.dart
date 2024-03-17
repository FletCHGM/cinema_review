import 'package:dio/dio.dart';

var apiManager = Dio(
  BaseOptions(
    baseUrl: 'https://api.kinopoisk.dev',
    headers: {
      'X-API-KEY': 'JHJXSQ2-99XMZB5-MXFCCPZ-AZADDG3',
    },
  ),
);
