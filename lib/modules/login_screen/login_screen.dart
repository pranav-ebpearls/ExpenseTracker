import 'package:adaptive_sizer/adaptive_sizer.dart';
import 'package:expense_tracker_pranav/auth/auth_service.dart';
import 'package:expense_tracker_pranav/main.dart';
import 'package:expense_tracker_pranav/modules/profile_screen/profile_screen.dart';
import 'package:expense_tracker_pranav/ui_components/custom_button.dart';
import 'package:expense_tracker_pranav/ui_components/custom_password_textfield.dart';
import 'package:expense_tracker_pranav/ui_components/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // get auth service
  final authService = AuthService();

  // text controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  //login button pressed
  void login() async {
    // prepare data
    final email = _loginEmailController.text;
    final password = _loginPasswordController.text;

    // attempt login
    try {
      await authService.signInWithEmailAndPassword(email, password);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ProfileScreen(),
        ),
      );
    } catch (error) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(
              'Login Failed',
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              '$error',
              style: GoogleFonts.aBeeZee(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Okay',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: GoogleFonts.aBeeZee(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            56.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextfield(
                placeholderText: 'Email',
                controller: _loginEmailController,
                onValidation: (email) {
                  const emailRegex =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  if (RegExp(emailRegex).hasMatch(email)) {
                    return true;
                  } else {
                    return false;
                  }
                },
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomPasswordTextfield(
                controller: _loginPasswordController,
                onValidatePassword: (password) {
                  const passwordRegex =
                      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$';
                  if (RegExp(passwordRegex).hasMatch(password)) {
                    return true;
                  } else {
                    return false;
                  }
                },
              ),
            ),
            40.verticalSpace,
            CustomButton(
              buttonTitle: 'Login',
              onPressed: login,
              buttonBackgroudColor: const Color.fromARGB(255, 127, 61, 255),
              buttonTextColor: Colors.white,
            ),
            33.verticalSpace,
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 127, 61, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            38.verticalSpace,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account yet? ",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        // TODO: Implement Tap
                        // Use recognizer to make the text a button
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        text: 'Sign Up',
                        style: GoogleFonts.aBeeZee(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(255, 127, 61, 255),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
