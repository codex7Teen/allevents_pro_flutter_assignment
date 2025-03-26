import 'package:allevents_pro/core/presentation/screens/main_auth_wrapper.dart';
import 'package:allevents_pro/features/auth/presentation/screens/login_screen.dart';
import 'package:allevents_pro/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => MainWrapperWidget()),
    GoRoute(path: '/login_screen', builder: (context, state) => ScreenLogin()),
    GoRoute(path: '/home_screen', builder: (context, state) => ScreenHome()),
  ],
);
