import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/features/auth/providers/auth_service_provider.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
