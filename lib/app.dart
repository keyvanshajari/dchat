import 'dart:io';

import 'package:dchat/config/routes.dart';
import 'package:dchat/config/theme/fonts.dart';
import 'package:dchat/presentation/rooms/rooms_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.navigatorKey,
  });
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatController>(
          create: (_) => ChatController(
            chatRepository: GetIt.instance(),
          )..init(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (BuildContext context) => 'D Chat',
        routerConfig: MyRouterMap.router,
        locale: const Locale('fa'),
        theme: ThemeData(
          fontFamily: yekan,
          primaryColor: const Color(0xff003A79),
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: kIsWeb || Platform.isAndroid
                    ? Brightness.dark
                    : Brightness.light,
                statusBarBrightness: kIsWeb || Platform.isAndroid
                    ? Brightness.dark
                    : Brightness.light,
              ),
              child: child!,
            ),
          );
        },
      ),
    );
  }
}
