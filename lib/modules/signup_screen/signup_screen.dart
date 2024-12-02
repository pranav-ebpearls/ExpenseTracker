import 'package:expense_tracker_pranav/auth/auth_service.dart';
import 'package:expense_tracker_pranav/main.dart';
import 'package:expense_tracker_pranav/ui_components/custom_button.dart';
import 'package:expense_tracker_pranav/ui_components/custom_password_textfield.dart';
import 'package:expense_tracker_pranav/ui_components/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_sizer/adaptive_sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase/supabase.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // auth service
  final authService = AuthService();

  // text controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isUsernameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool? checkboxValue = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUp() async {
    // preparation
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // attempt sign up
    try {
      await authService.signUpWithEmailAndPassword(email, password);

      // Navigator.pop(context);
    } catch (error) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(
              'Sign up Failed',
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

  Future<AuthResponse> _googleSignIn() async {
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '799483331228-nhnpq40ca60el8jb2k81gp3vrvba8vii.apps.googleusercontent.com';

    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '799483331228-c6ekhcru9sk90litlqiesrtqmbm7behn.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign up',
          style: GoogleFonts.aBeeZee(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 56,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextfield(
                placeholderText: 'Name',
                controller: _usernameController,
                onValidation: (username) {
                  const usernameRegex = r'^[A-Za-z]+(?: [A-Za-z]+)*$';
                  if (RegExp(usernameRegex).hasMatch(username)) {
                    return true;
                  } else {
                    return false;
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextfield(
                placeholderText: 'Email',
                controller: _emailController,
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
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomPasswordTextfield(
                controller: _passwordController,
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
            const SizedBox(height: 17),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 127, 61, 255),
                        ),
                      ),
                      value: checkboxValue,
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkboxValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By signing up, you agree to the ',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              // TODO: Implement Tap
                              // Use recognizer to make the text a button
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: 'Terms of Service and Privacy Policy',
                              style: GoogleFonts.aBeeZee(
                                height: 1.5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 127, 61, 255),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            27.verticalSpace,
            CustomButton(
              buttonTitle: 'Sign up',
              onPressed: signUp,
              buttonBackgroudColor: const Color.fromARGB(255, 127, 61, 255),
              buttonTextColor: Colors.white,
            ),
            12.verticalSpace,
            Text(
              'Or with',
              style: GoogleFonts.aBeeZee(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.verticalSpace,
            SizedBox(
              width: 343,
              height: 56,
              child: OutlinedButton.icon(
                icon: Image.asset(
                  'assets/google_icon/google.png',
                  height: 32,
                  width: 32,
                ),
                onPressed: _googleSignIn,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                label: Text(
                  'Sign up with Google',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            19.verticalSpace,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account? ',
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
                        text: 'Login',
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
