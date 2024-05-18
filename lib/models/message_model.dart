import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String id;
  final DateTime time;

  MessageModel({
    required this.message,
    required this.id,
    required this.time,
  });
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      message: jsonData['message'],
      id: jsonData['id'],
      time: (jsonData['time'] as Timestamp).toDate(),
    );
  }
}
