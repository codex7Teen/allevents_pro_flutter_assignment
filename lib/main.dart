import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/features/auth/providers/auth_service_provider.dart';
import 'package:allevents_pro/features/events/providers/event_provider.dart';
import 'package:allevents_pro/features/home/providers/category_provider.dart';
import 'package:allevents_pro/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//!  R O O T
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //!  I N I T I A L I Z E  W I D G E T S
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //!  S T A R T  A P P
  runApp(
    //! P R O V I D E R S
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServiceProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AllEvents Pro',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.whiteColor,
        ), //!  W H I T E   T H E M E
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
    );
  }
}
