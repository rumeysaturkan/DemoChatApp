import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String content;
  final Timestamp time;
  final String uid;

  MessageModel({
    required this.content,
    required this.time,
    required this.uid,
  });

  factory MessageModel.fromMap(Map data) {
    return MessageModel(
        content: data['content'], time: data['time'] ?? '', uid: data['uid']);
  }

  Map<String, dynamic> toJson() =>
      {"content": content, "time": time, "uid": uid};
}
