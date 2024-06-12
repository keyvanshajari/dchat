import 'package:dchat/presentation/rooms/rooms_page.dart';
import 'package:dchat/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        currentPageIndex: currentPageIndex,
        onTap: (value) {
          // setState(() {
          //   currentPageIndex = value;
          // });
        },
      ),
      body: <Widget>[
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const RoomsPage(),
      ][currentPageIndex],
    );
  }
}
