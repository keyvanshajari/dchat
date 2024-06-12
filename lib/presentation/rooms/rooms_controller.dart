import 'package:dchat/infrastructure/model/room_model.dart';
import 'package:dchat/infrastructure/model/user_model.dart';
import 'package:dchat/infrastructure/repository/chat_ropsitory.dart';
import 'package:flutter/material.dart';

const myUserId = "c9bb44da-83e3-f02f-f3d0-b99e99367195";

class ChatController extends ChangeNotifier {
  final ChatRepository chatRepository;
  ChatController({
    required this.chatRepository,
  });

  bool loading = true;
  bool paginationLoading = false;

  List<RoomModel> rooms = [];

  Future<void> init() async {
    try {
      chatRepository.getLatestMessage(
        onReceiveMessage: (message) {
          bool roomIsNotExist = true;

          late UserModel user;
          if (message.receiverId == myUserId) {
            user = message.sender;
          } else {
            user = message.receiver;
          }
          for (var i = 0; i < rooms.length; i++) {
            if (rooms[i].roomId == user.id) {
              roomIsNotExist = false;
              rooms[i] = rooms[i].copyWith(messages: [
                message,
                ...rooms[i].messages,
              ]);
            }
          }

          if (roomIsNotExist) {
            rooms.add(
              RoomModel(
                user: user,
                messages: [message],
              ),
            );
          }

          loading = false;
          notifyListeners();
        },
        onError: (e) {},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchChatHistoryById(String userId) async {
    if (paginationLoading) return;

    try {
      paginationLoading = true;
      notifyListeners();

      var index = rooms.indexWhere((element) => element.roomId == userId);
      final res = await chatRepository.getChatHistorybyId(
          id: userId, offset: rooms[index].messages.length);
      rooms[index] = rooms[index].copyWith(
        messages: [
          ...rooms[index].messages,
          ...res,
        ],
      );

      paginationLoading = false;
      notifyListeners();
    } catch (e) {
      paginationLoading = false;
      notifyListeners();
      print(e);
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    try {
      await chatRepository.sendMessage(
          content: content, receiverId: receiverId);
    } catch (e) {
      print(e);
    }
  }
}
