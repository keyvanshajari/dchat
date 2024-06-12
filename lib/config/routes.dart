import 'package:dchat/infrastructure/model/room_model.dart';
import 'package:dchat/presentation/chat/chat_page.dart';
import 'package:dchat/presentation/home/home_page.dart';
import 'package:dchat/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouterMap {
  static String baseRoute = '/';
  static String splashRoute = '/splash';
  static String homeRoute = '/home';
  static String chatRoute = '/chat';

  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: baseRoute,
        redirect: (context, state) => splashRoute,
      ),
      GoRoute(
        path: splashRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: chatRoute,
        builder: (BuildContext context, GoRouterState state) {
          return ChatPage(
            room: state.extra as RoomModel,
          );
        },
      ),
    ],
  );
}
