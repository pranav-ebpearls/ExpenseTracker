import 'package:expense_tracker_pranav/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Signup with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign Out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Get User Email
  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }
}
