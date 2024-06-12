import 'package:dchat/config/constants/icon_addresses.dart';
import 'package:dchat/presentation/rooms/widgets/story_list.dart';
import 'package:dchat/widgets/image_viewer/circle_avatar.dart';
import 'package:dchat/widgets/image_viewer/svg_viewer.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.backgroundColor,
    required this.searchBackgroundColor,
    required this.storyOpacity,
  });

  final Color backgroundColor;
  final Color searchBackgroundColor;
  final double storyOpacity;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      toolbarHeight: 76,
      pinned: true,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 16,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: const CustomCirculeAvatar(),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: searchBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const SvgViewer.asset(
                  DIcons.search,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
      flexibleSpace: StoryList(storyOpacity: storyOpacity),
    );
  }
}
