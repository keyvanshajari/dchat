import 'dart:async';

import 'package:dchat/app.dart';
import 'package:dchat/common/services/environment_service.dart';
import 'package:dchat/dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () async {
      final GlobalKey<NavigatorState> navigatorKey =
          GlobalKey<NavigatorState>();
      WidgetsFlutterBinding.ensureInitialized();
      registerDependencies();

      EnvironmentService().setEnvironment();

      runApp(
        App(
          navigatorKey: navigatorKey,
        ),
      );
    },
    (error, stack) {
      //errorHandler
    },
  );
}
