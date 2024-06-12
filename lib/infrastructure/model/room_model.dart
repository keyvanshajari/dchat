// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dchat/infrastructure/model/message_model.dart';
import 'package:dchat/infrastructure/model/user_model.dart';

class RoomModel {
  final UserModel user;
  final List<MessageModel> messages;

  RoomModel({
    required this.user,
    this.messages = const [],
  });

  String get roomId => user.id;

  RoomModel copyWith({
    UserModel? user,
    List<MessageModel>? messages,
  }) {
    return RoomModel(
      user: user ?? this.user,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      messages: List<MessageModel>.from(
        (map['messages'] as List<int>).map<MessageModel>(
          (x) => MessageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoomModel(user: $user, messages: $messages)';

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;

    return other.user == user && listEquals(other.messages, messages);
  }

  @override
  int get hashCode => user.hashCode ^ messages.hashCode;
}
