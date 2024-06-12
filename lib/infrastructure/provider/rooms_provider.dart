import 'dart:async';
import 'package:graphql/client.dart';

abstract class ChatProvider {
  Stream<QueryResult<Object?>> getLatestMessage();
  Future<Map<String, dynamic>?> getChatHistorybyId({
    required String id,
    required int offset,
  });
  Future<void> sendMessage({
    required String content,
    required String receiverId,
  });
}
