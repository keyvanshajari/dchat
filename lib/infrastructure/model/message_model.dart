// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dchat/infrastructure/model/user_model.dart';

class MessageModel {
  final UserModel receiver;
  final UserModel sender;
  final String receiverId;
  final String senderId;
  final String content;
  final String createdAt;

  MessageModel({
    required this.receiver,
    required this.sender,
    required this.receiverId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  MessageModel copyWith({
    UserModel? receiver,
    UserModel? sender,
    String? receiverId,
    String? senderId,
    String? content,
    String? createdAt,
  }) {
    return MessageModel(
      receiver: receiver ?? this.receiver,
      sender: sender ?? this.sender,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      receiver: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      sender: UserModel.fromMap(map['userBySenderId'] as Map<String, dynamic>),
      receiverId: map['receiver_id'] as String,
      senderId: map['sender_id'] as String,
      content: map['content'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiver': receiver.toMap(),
      'sender': sender.toMap(),
      'receiverId': receiverId,
      'senderId': senderId,
      'content': content,
      'createdAt': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'MessageModel(user: $receiver, receiverId: $receiverId, senderId: $senderId, content: $content)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.receiver == receiver &&
        other.sender == sender &&
        other.receiverId == receiverId &&
        other.senderId == senderId &&
        other.content == content;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^
        receiverId.hashCode ^
        sender.hashCode ^
        senderId.hashCode ^
        content.hashCode;
  }
}
