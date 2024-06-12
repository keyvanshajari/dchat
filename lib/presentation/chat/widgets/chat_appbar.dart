import 'package:dchat/config/constants/icon_addresses.dart';
import 'package:dchat/config/theme/fonts.dart';
import 'package:dchat/infrastructure/model/room_model.dart';
import 'package:dchat/widgets/image_viewer/circle_avatar.dart';
import 'package:dchat/widgets/image_viewer/svg_viewer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({
    super.key,
    required this.room,
  });

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      child: AppBar(
        surfaceTintColor: Colors.white,
        toolbarHeight: 80,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const SvgViewer.asset(
                DIcons.call2,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              child: const SvgViewer.asset(
                DIcons.videos,
                size: 24,
              ),
            ),
            Flexible(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  room.user.fullName ?? '',
                  style: medium_15.copyWith(
                    color: const Color(0xFF000E08),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const CustomCirculeAvatar(),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => context.pop(),
              child: const SvgViewer.asset(
                DIcons.arrowright,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
