import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:garbage_collector/env/env.dart';
import 'package:garbage_collector/utils/utils.dart';

class Basket {
  final int id;
  final String basketName;
  final String detailAddress;
  final double lat;
  final double lng;
  final int? userTrash;
  final DateTime updatedAt;

  Basket(
    this.id,
    this.basketName,
    this.detailAddress,
    this.lat,
    this.lng,
    this.userTrash,
    this.updatedAt,
  );

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      json['id'] as int,
      json['basketName'] as String,
      json['detailAddress'] as String,
      json['lat'] as double,
      json['lng'] as double,
      json['userTrash'] as int?,
      DateTime.parse(json['updatedAt'] as String),
    );
  }

  static Future<List<Basket>> findBaskets(
      String token, double lat, double lng, String type) async {
    String api = "${ENV.apiEndpoint}/basket/recommend";

    final response = await http.post(Uri.parse(api),
        headers: {
          "authorization": token,
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({"lat": lat, "lng": lng, "type": type}));

    if (response.statusCode == 200) {
      List<dynamic> baskets = json.decode(response.body)['result'];
      log(baskets.toString());
      return baskets
          .map((basket) => Basket.fromJson(basket as Map<String, dynamic>))
          .toList();
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }

  static Future<void> reportBaskets(String reportType, int id) async {
    String api = "${ENV.apiEndpoint}/basket/report";

    final response = await http.post(
      Uri.parse(api),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        {
          "reportType": reportType,
          "basketId": id,
        },
      ),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }
}
