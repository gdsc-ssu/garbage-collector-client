import 'package:garbage_collector/env/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:garbage_collector/utils/utils.dart';

class Ranker {
  final int id;
  final String? nickname;
  final String profileImg;
  final int totalScore;

  Ranker(this.id, this.nickname, this.profileImg, this.totalScore);

  factory Ranker.fromJson(Map<String, dynamic> json) {
    return Ranker(
      json['id'] as int,
      (json['nickname'] == null) ? null : json['nickname'] as String,
      json['profileImg'] as String,
      json['totalScore'] as int,
    );
  }

  static Future<List<Ranker>> totalRank() async {
    String api = "${ENV.apiEndpoint}/rank/total";

    final response = await http.get(
      Uri.parse(api),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );

    if (response.statusCode == 200) {
      List<dynamic> rankers = json.decode(response.body)['result'];
      return rankers
          .map((ranker) => Ranker.fromJson(ranker as Map<String, dynamic>))
          .toList();
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }
}
