import 'package:allevents_pro/core/presentation/screens/main_auth_wrapper.dart';
import 'package:allevents_pro/features/auth/presentation/screens/login_screen.dart';
import 'package:allevents_pro/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MainWrapperWidget(),
    ),
    GoRoute(
      name: 'login_screen',
      path: '/login_screen',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ScreenLogin(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      name: 'home_screen',
      path: '/home_screen',
      builder: (context, state) => ScreenHome(),
    ),
  ],
);
