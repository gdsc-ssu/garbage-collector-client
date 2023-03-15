import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:garbage_collector/env/env.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/models/models.dart';

class Basket {
  final int id;
  final String basketName;
  final String detailAddress;
  final double lat;
  final double lng;

  Basket(
    this.id,
    this.basketName,
    this.detailAddress,
    this.lat,
    this.lng,
  );

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      json['id'] as int,
      json['basketName'] as String,
      json['detailAddress'] as String,
      json['lat'] as double,
      json['lng'] as double,
    );
  }

  static Future<List<Basket>> findBaskets(
      String token, double lat, double lng, String type) async {
    String api = "${ENV.apiEndpoint}/basket/recommend";

    final response = await http.post(Uri.parse(api),
        headers: {
          "authorization": 'Bearer $token',
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({"lat": lat, "lng": lng, "type": type}));

    if (response.statusCode == 200) {
      List<dynamic> baskets = json.decode(response.body)['result'];
      return baskets
          .map((basket) => Basket.fromJson(basket as Map<String, dynamic>))
          .toList();
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }

  static Future<List<Basket>> rangeBaskets(
      double lat1, double lng1, double lat2, double lng2) async {
    final response = await http.post(
      Uri.parse('${ENV.apiEndpoint}/baskets'),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body:
          jsonEncode({"lat1": lat1, "lng1": lng1, "lat2": lat2, "lng2": lng2}),
    );

    if (response.statusCode == 200) {
      List<dynamic> baskets = json.decode(response.body)['result'];
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

  Future<User> throwTrash(String token, String type1, String type2) async {
    String api = "${ENV.apiEndpoint}/trash";

    final response = await http.post(
      Uri.parse(api),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "authorization": 'Bearer $token',
      },
      body: jsonEncode(
          {"trashType1": type1, "trashType2": type2, "basketId": id}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['result']);
    } else {
      throw newHTTPException(response.statusCode, response.body);
    }
  }
}
