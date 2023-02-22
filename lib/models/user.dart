import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/env/env.dart';

class User {
  final int id;
  final String? profileUrl;
  final String nickname;
  final String? email;
  final String token;
  final int general;
  final int plastic;
  final int paper;
  final int can;
  final int vinyl;
  final int glass;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
    this.id,
    this.profileUrl,
    this.nickname,
    this.email,
    this.token,
    this.general,
    this.plastic,
    this.paper,
    this.can,
    this.vinyl,
    this.glass,
    this.createdAt,
    this.updatedAt,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['profileUrl'] as String,
      json['nickname'] as String,
      json['email'] as String,
      json['token'] as String,
      json['general'] as int,
      json['plastic'] as int,
      json['paper'] as int,
      json['can'] as int,
      json['vinyl'] as int,
      json['glass'] as int,
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
