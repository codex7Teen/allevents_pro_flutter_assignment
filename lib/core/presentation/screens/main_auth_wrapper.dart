import 'package:allevents_pro/core/presentation/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainWrapperWidget extends StatelessWidget {
  const MainWrapperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // show circular progress indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // show error
            return const Center(child: Text("Error"));
          } else {
            if (snapshot.data == null) {
              // Show splash and navigate to intro screen
              return const ScreenSplash1(screenName: '/login_screen');
            } else {
              return const ScreenSplash1(screenName: '/home_screen');
            }
          }
        },
      ),
    );
  }
}
