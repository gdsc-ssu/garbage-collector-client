import 'dart:convert';

class Basket {
  final int id;
  final String nickname;
  final double lat;
  final double lng;
  final DateTime updatedAt;

  Basket(this.id, this.nickname, this.lat, this.lng, this.updatedAt);

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      json['id'] as int,
      json['nickname'] as String,
      json['lat'] as double,
      json['lng'] as double,
      DateTime.parse(json['updatedAt'] as String),
    );
  }
}
