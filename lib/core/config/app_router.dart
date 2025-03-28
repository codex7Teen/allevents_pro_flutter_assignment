// Router Configuration - Manages application navigation
import 'package:allevents_pro/core/presentation/screens/main_auth_wrapper.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/features/auth/presentation/screens/login_screen.dart';
import 'package:allevents_pro/features/events/presentation/screens/event_screen.dart';
import 'package:allevents_pro/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // Main authentication wrapper route
    GoRoute(path: '/', builder: (context, state) => MainWrapperWidget()),

    // Login screen route with fade transition
    GoRoute(
      name: 'login_screen',
      path: '/login_screen',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ScreenLogin(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),

    // Home screen route with fade transition
    GoRoute(
      name: 'home_screen',
      path: '/home_screen',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ScreenHome(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),

    // Event screen route with fade transition, passing category data
    GoRoute(
      name: 'event_screen',
      path: '/event_screen',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ScreenEvents(category: state.extra as CategoryModel),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
  ],
);
