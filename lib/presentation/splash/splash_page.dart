import 'dart:async';

import 'package:dchat/config/constants/image_addresses.dart';
import 'package:dchat/config/routes.dart';
import 'package:dchat/widgets/image_viewer/image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    navigateToHomePage();
    super.initState();
  }

  Future navigateToHomePage() async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      context.go(MyRouterMap.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageViewer(
              source: ImageAddresses.background,
              placeholder: Container(color: Theme.of(context).primaryColor),
            ),
          ),
          const Center(
            child: ImageViewer(
              source: ImageAddresses.logo,
              height: 215,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
