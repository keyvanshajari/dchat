import 'package:dchat/config/constants/icon_addresses.dart';
import 'package:dchat/config/theme/fonts.dart';
import 'package:dchat/widgets/image_viewer/svg_viewer.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentPageIndex,
  });

  final int currentPageIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1112220a),
            spreadRadius: 0,
            blurRadius: 24,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          onTap: onTap,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 15,
          currentIndex: currentPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: CustomButtomNavigationBarItem(
                isSelected: currentPageIndex == 0,
                label: 'تنظیمات',
                icon: DIcons.setting,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CustomButtomNavigationBarItem(
                isSelected: currentPageIndex == 1,
                label: 'تماس ها',
                icon: DIcons.call,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CustomButtomNavigationBarItem(
                isSelected: currentPageIndex == 2,
                label: 'پروفایل',
                icon: DIcons.user,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CustomButtomNavigationBarItem(
                isSelected: currentPageIndex == 3,
                label: 'گفتگوها',
                icon: DIcons.message,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtomNavigationBarItem extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final String label;

  const CustomButtomNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: regular_12.copyWith(color: const Color(0xFF003A79)),
                ),
                const SizedBox(width: 8),
                SvgViewer.asset(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          )
        : SvgViewer.asset(
            icon,
            color: Colors.grey,
          );
  }
}
