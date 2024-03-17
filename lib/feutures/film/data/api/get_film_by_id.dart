import 'package:cinema_review/utils/api_manager/api_manager.dart';

Future<Map<String, dynamic>?> getFilmsByID(final int id) async {
  try {
    var response = await apiManager.get(
      '/v1.4/movie/$id',
    );
    return response.data as Map<String, dynamic>;
  } on Exception catch (_) {
    return null;
  }
}
