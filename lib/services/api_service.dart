import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic details = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(details);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatesEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodeInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstances;
    }
    throw Error();
  }
}
