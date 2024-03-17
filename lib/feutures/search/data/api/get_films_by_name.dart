import 'package:cinema_review/utils/api_manager/api_manager.dart';

Future<Map<String, dynamic>?> getFilmsByName(
    final String name, final int page) async {
  try {
    var response = await apiManager.get(
      '/v1.4/movie/search',
      queryParameters: {
        'query': name,
        'page': page.toString(),
      },
    );
    return response.data as Map<String, dynamic>;
  } on Exception catch (_) {
    return null;
  }
}
