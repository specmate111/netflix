import 'package:netflix/core/strings.dart';
import 'package:netflix/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$KBaseUrl/trending/all/day?api_key=$apiKey";
  static const search = '$KBaseUrl/search/movie?api_key=$apiKey';

  static const hotAndNewMovie = '$KBaseUrl/discover/movie?api_key=$apiKey';
  static const hotAndNewTv = '$KBaseUrl/discover/tv?api_key=$apiKey';
}
