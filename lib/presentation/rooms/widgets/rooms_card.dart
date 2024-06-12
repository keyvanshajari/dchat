import 'package:dchat/common/helper/formater_helper.dart';
import 'package:dchat/config/constants/image_addresses.dart';
import 'package:dchat/config/routes.dart';
import 'package:dchat/config/theme/fonts.dart';
import 'package:dchat/infrastructure/model/room_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomsCard extends StatelessWidget {
  const RoomsCard({
    super.key,
    required this.index,
    required this.roomInfo,
  });
  final int index;
  final RoomModel roomInfo;

  void onTapCard(BuildContext context) {
    context.push(MyRouterMap.chatRoute, extra: roomInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () => onTapCard(context),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage(ImageAddresses.avatar),
            radius: 28,
          ),
        ),
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      roomInfo.user.fullName ?? '',
                      style: medium_15.copyWith(
                        color: const Color(0xFF000E08),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Text(
                      replaceToFarsiNumber(
                        passedTimeLabel(
                          DateTime.parse(roomInfo.messages.first.createdAt),
                        ),
                      ),
                      style: regular_11.copyWith(
                        color: const Color(0x797c7b80),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      roomInfo.messages.firstOrNull?.content ?? '',
                      style: regular_12.copyWith(
                        color: const Color(0x797c7b80),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Badge(
                      backgroundColor: const Color(0xFFF04A4C),
                      label: Text(
                        replaceToFarsiNumber('3'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
