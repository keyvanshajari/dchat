import 'package:dchat/config/constants/image_addresses.dart';
import 'package:dchat/presentation/rooms/rooms_controller.dart';
import 'package:dchat/presentation/rooms/widgets/appbar.dart';
import 'package:dchat/presentation/rooms/widgets/rooms_card.dart';
import 'package:dchat/widgets/image_viewer/image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  late ScrollController _scrollController;
  Color _backgroundColor = Colors.transparent;
  Color _searchBackgroundColor = Colors.white.withOpacity(0.2);
  double storyOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    double offset = _scrollController.offset;
    setState(() {
      _backgroundColor = offset > 130 ? Colors.white : Colors.transparent;
      _searchBackgroundColor = offset > 130
          ? const Color(0xFFC5D4FF)
          : Colors.white.withOpacity(0.2);
      storyOpacity = offset > 28 ? 0.0 : 1.0;
    });
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
      body: Stack(
        children: [
          _buildBackground(),
          Positioned.fill(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                Appbar(
                  backgroundColor: _backgroundColor,
                  searchBackgroundColor: _searchBackgroundColor,
                  storyOpacity: storyOpacity,
                ),
                controller.loading
                    ? SliverFillRemaining(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      )
                    : SliverFillRemaining(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 30,
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                  child: const SizedBox(
                                    width: 30,
                                    height: 3,
                                  ),
                                ),
                              ),
                              CustomScrollView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        ChatController controller =
                                            context.watch();
                                        return RoomsCard(
                                          index: index,
                                          roomInfo: controller.rooms[index],
                                        );
                                      },
                                      childCount: controller.rooms.length,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return const Positioned.fill(
      child: ImageViewer(
        source: ImageAddresses.background,
      ),
    );
  }
}
