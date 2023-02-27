import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/env/env.dart';

class User {
  final int id;
  final String? profileImg;
  final String nickname;
  final String email;
  final int general;
  final int plastic;
  final int paper;
  final int can;
  final int glass;
  final String? accessToken;
  final String? refreshToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
    this.id,
    this.profileImg,
    this.nickname,
    this.email,
    this.general,
    this.plastic,
    this.paper,
    this.can,
    this.glass,
    this.accessToken,
    this.refreshToken,
    this.createdAt,
    this.updatedAt,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['profileImg'] as String?,
      json['nickname'] as String,
      json['email'] as String,
      json['general'] as int,
      json['plastic'] as int,
      json['paper'] as int,
      json['can'] as int,
      json['glass'] as int,
      json['accessToken'] as String?,
      json['refreshToken'] as String?,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
    );
  }

  static Future<User> googleLogin(String nickname, String email,
      String accessToken, String profileUrl) async {
    String api = "${ENV.apiEndpoint}/user/login";

    // final response = await http
    //     .get(Uri.parse(api), headers: {"Authorization": "Bearer $token"});
    final response = await http.post(
      Uri.parse(api),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({
        'nickname': nickname,
        'email': email,
        'accessToken': accessToken,
        'profileUrl': profileUrl,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }
}
