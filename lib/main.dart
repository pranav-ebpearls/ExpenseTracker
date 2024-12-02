import 'package:expense_tracker_pranav/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:adaptive_sizer/adaptive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.delayed(const Duration(seconds: 3));

  // Supabase
  await Supabase.initialize(
    url: 'https://xpctktuktipyreypnrba.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwY3RrdHVrdGlweXJleXBucmJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1MDUyNTYsImV4cCI6MjA0ODA4MTI1Nn0.KjepNNyHOOG-j_DvyiKpPNPg1bsgdlkIA87R-KSQMsk',
  );

  FlutterNativeSplash.remove();

  runApp(
    AdaptiveSizer(
      designSize: const Size(375, 812),
      builder: (context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
      ),
    ),
  );
}

final supabase = Supabase.instance.client;
