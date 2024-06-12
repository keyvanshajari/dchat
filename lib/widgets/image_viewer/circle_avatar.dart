import 'package:dchat/config/constants/image_addresses.dart';
import 'package:flutter/material.dart';

class CustomCirculeAvatar extends StatelessWidget {
  const CustomCirculeAvatar({
    super.key,
    this.radius = 22,
  });
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: const AssetImage(
        ImageAddresses.avatar,
      ),
      radius: radius,
    );
  }
}
