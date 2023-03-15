import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/env/env.dart';

class User {
  final int id;
  final String? profileImg;
  final String? nickname;
  final String email;
  final int general;
  final int plastic;
  final int can;
  final int glass;
  final int paper;
  final String? accessToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
    this.id,
    this.profileImg,
    this.nickname,
    this.email,
    this.general,
    this.plastic,
    this.can,
    this.glass,
    this.paper,
    this.accessToken,
    this.createdAt,
    this.updatedAt,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['profileImg'] as String?,
      json['nickname'] as String?,
      json['email'] as String,
      json['general'] as int,
      json['plastic'] as int,
      json['can'] as int,
      json['glass'] as int,
      json['paper'] as int,
      json['accessToken'] as String?,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
    );
  }

  static Future<User> googleLogin(String nickname, String email,
      String accessToken, String profileImg) async {
    String api = "${ENV.apiEndpoint}/user/login";

    final response = await http.post(
      Uri.parse(api),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({
        'nickname': nickname,
        'email': email,
        'accessToken': accessToken,
        'profileImg': profileImg,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body)['result']);
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }

  static Future<User> auth(String token) async {
    String api = "${ENV.apiEndpoint}/user/auth";

    final response = await http.get(
      Uri.parse(api),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body)['result']);
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }

  static Future<List<User>> totalRank(String token) async {
    String api = "${ENV.apiEndpoint}/rank/total";

    final response = await http.get(
      Uri.parse(api),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> users = json.decode(response.body)['result'];
      return users
          .map((user) => User.fromJson(user as Map<String, dynamic>))
          .toList();
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }
}
