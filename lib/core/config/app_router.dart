import 'package:allevents_pro/core/presentation/screens/splash_screen.dart';
import 'package:allevents_pro/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => ScreenSplash1()),
    GoRoute(path: '/login_screen', builder: (context, state) => ScreenLogin()),
  ],
);
