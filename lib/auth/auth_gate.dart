/*

AUTH GATE - This will continously listen for auth state changes.

-------------------------------------------------------------------------

unauthenticated -> Login Page
authenticated -> Home Page

*/

import 'dart:developer';

import 'package:expense_tracker_pranav/main.dart';
import 'package:expense_tracker_pranav/modules/onboarding/onboarding_screen.dart';
import 'package:expense_tracker_pranav/modules/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listen to auth state changes
      stream: supabase.auth.onAuthStateChange,

      // Build appropriate page based on auth state
      builder: (context, snapshot) {
        // loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // check if there is a valid session currently
        final session = snapshot.hasData ? snapshot.data!.session : null;

        log("session = $session");

        if (session != null) {
          return const ProfileScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
