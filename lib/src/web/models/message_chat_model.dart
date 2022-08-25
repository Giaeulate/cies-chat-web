import 'dart:convert';

MessageChatModel messageChatModelFromJson(String str) =>
    MessageChatModel.fromJson(json.decode(str));

String messageChatModelToJson(MessageChatModel data) =>
    json.encode(data.toJson());

class MessageChatModel {
  MessageChatModel({
    required this.id,
    required this.message,
    this.thumb,
    this.url,
    required this.isSent,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
    this.attachmentId,
    required this.channelId,
    required this.typeMessageId,
    required this.userSocketId,
    // this.messageModelIsReads = const [],
  });

  String id;
  String message;
  dynamic thumb;
  dynamic url;
  bool isSent;
  DateTime createdAt;
  DateTime updatedAt;
  bool active;
  dynamic attachmentId;
  String channelId;
  String typeMessageId;
  String userSocketId;
  // List<dynamic> messageModelIsReads;

  factory MessageChatModel.fromJson(Map<String, dynamic> json) =>
      MessageChatModel(
        id: json["id"],
        message: json["message"],
        thumb: json["thumb"],
        url: json["url"],
        isSent: json["isSent"].toString() == 'true' ? true : false,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        active: json["active"].toString() == 'true' ? true : false,
        attachmentId: json["attachmentId"],
        channelId: json["channelId"],
        typeMessageId: json["typeMessageId"],
        userSocketId: json["userSocketId"],
        // messageModelIsReads:
        //     List<dynamic>.from(json["messageModelIsReads"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "thumb": thumb,
        "url": url,
        "isSent": isSent,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "active": active,
        "attachmentId": attachmentId,
        "channelId": channelId,
        "typeMessageId": typeMessageId,
        "userSocketId": userSocketId,
        // "messageModelIsReads":
        //     List<dynamic>.from(messageModelIsReads.map((x) => x)),
      };
}
