import 'package:dchat/infrastructure/model/message_model.dart';
import 'package:dchat/infrastructure/provider/rooms_provider.dart';
import 'package:graphql/client.dart';

class ChatRepository {
  final ChatProvider chatProvider;
  ChatRepository({
    required this.chatProvider,
  });
  void getLatestMessage({
    required Function(MessageModel messsage) onReceiveMessage,
    required Function(OperationException? e) onError,
  }) {
    final subscription = chatProvider.getLatestMessage();

    subscription.listen((event) {
      if (event.hasException) {
        onError(event.exception);
      }
      if (event.data != null) {
        try {
          if (event.data!['messages'] != null &&
              (event.data!['messages'] as List).isNotEmpty) {
            onReceiveMessage(
              MessageModel.fromMap((event.data!['messages'] as List).first),
            );
          }
        } catch (e) {
          rethrow;
        }
      }
    });
  }

  Future<List<MessageModel>> getChatHistorybyId({
    required String id,
    required int offset,
  }) async {
    final res = await chatProvider.getChatHistorybyId(id: id, offset: offset);
    try {
      if (res?['messages'] != null && (res?['messages'] as List).isNotEmpty) {
        return List<MessageModel>.from(
          (res!['messages'] as Iterable).fold(
            [],
            (initialList, e) {
              final map = Map<String, dynamic>.from(e);
              final enitity = MessageModel.fromMap(map);
              return [
                ...initialList,
                enitity,
              ];
            },
          ),
        );
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendMessage({
    required String content,
    required String receiverId,
  }) async {
    return chatProvider.sendMessage(content: content, receiverId: receiverId);
  }
}
