import 'dart:convert';

UserChatModel userChatModelFromJson(String str) =>
    UserChatModel.fromJson(json.decode(str));

String userChatModelToJson(UserChatModel data) => json.encode(data.toJson());

class UserChatModel {
  UserChatModel({
    required this.id,
    required this.name,
    this.thumb,
    required this.isOnline,
    required this.isLogged,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
  });

  String id;
  String name;
  dynamic thumb;
  bool isOnline;
  bool isLogged;
  DateTime createdAt;
  DateTime updatedAt;
  bool active;

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        id: json["id"],
        name: json["name"],
        thumb: json["thumb"],
        isOnline: json["isOnline"].toString() == 'true' ? true : false,
        isLogged: json["isLogged"].toString() == 'true' ? true : false,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        active: json["active"].toString() == 'true' ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumb": thumb,
        "isOnline": isOnline,
        "isLogged": isLogged,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "active": active,
      };
}
