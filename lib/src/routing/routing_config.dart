import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_flutter/src/core/constants/routing_constants.dart';
import 'package:kanban_flutter/src/features/kanban_board/kanban_screen.dart';
import 'package:kanban_flutter/src/features/splash/splash_screen.dart';

///RoutingConfig - Handle Routing of application
class RoutingConfig {
  static GoRouter router = GoRouter(
    initialLocation: RoutingConstants.initial,
    routes: <GoRoute>[
      GoRoute(
        path: RoutingConstants.initial,
        name: RoutingConstants.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.kanban,
        name: RoutingConstants.kanban,
        builder: (context, state) {
          return const KanbanScreen();
        },
      ),
    ],
    observers: <NavigatorObserver>[
      BotToastNavigatorObserver(),
    ],
  );
}
