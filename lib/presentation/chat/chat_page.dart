import 'package:dchat/config/constants/icon_addresses.dart';
import 'package:dchat/config/constants/image_addresses.dart';
import 'package:dchat/infrastructure/model/room_model.dart';
import 'package:dchat/presentation/chat/widgets/chat_appbar.dart';
import 'package:dchat/presentation/chat/widgets/message_bubble.dart';
import 'package:dchat/presentation/rooms/rooms_controller.dart';
import 'package:dchat/widgets/image_viewer/svg_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final RoomModel room;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _textEditingController = TextEditingController();
    super.initState();
    _checkInitialExtent();
  }

  void _checkInitialExtent() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent == 0) {
        await getNextPage();
        _checkInitialExtent();
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      getNextPage();
    }
  }

  Future<void> getNextPage() async {
    final controller = context.read<ChatController>();
    await controller.fetchChatHistoryById(widget.room.roomId);
  }

  void sendMessage() {
    final controller = context.read<ChatController>();
    controller.sendMessage(
      receiverId: widget.room.roomId,
      content: _textEditingController.text,
    );
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ChatAppbar(room: widget.room),
      ),
      body: Stack(
        children: [
          _buildBackground(),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    if (controller.paginationLoading) ...[
                      const SizedBox(height: 24),
                      const Center(child: CupertinoActivityIndicator()),
                      const SizedBox(height: 48),
                    ],
                    ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      itemBuilder: (context, index) {
                        final m = controller.rooms.first.messages[index];
                        return MessageBubble(message: m);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemCount: controller.rooms.first.messages.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              constraints: const BoxConstraints(maxHeight: 85),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: sendMessage,
                    child: const SvgViewer.asset(DIcons.send),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7FC),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'پیام',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {},
                    child: const SvgViewer.asset(DIcons.add),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return const Positioned.fill(
      child: SvgViewer.asset(
        ImageAddresses.chatBackground,
      ),
    );
  }
}
