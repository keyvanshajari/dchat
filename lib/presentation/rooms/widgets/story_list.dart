import 'package:dchat/config/constants/image_addresses.dart';
import 'package:dchat/config/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoryList extends StatelessWidget {
  const StoryList({
    super.key,
    required this.storyOpacity,
  });

  final double storyOpacity;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedOpacity(
        opacity: storyOpacity,
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SizedBox(
            height: 87,
            child: ListView.separated(
              reverse: true,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(ImageAddresses.avatar),
                      radius: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نام ${index + 1}',
                    style: regular_11.copyWith(color: Colors.white),
                    maxLines: 1,
                  ),
                ],
              ),
              itemCount: 20,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}
