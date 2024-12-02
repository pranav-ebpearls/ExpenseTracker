import 'package:carousel_slider/carousel_slider.dart';
import 'package:expense_tracker_pranav/modules/login_screen/login_screen.dart';
import 'package:expense_tracker_pranav/modules/signup_screen/signup_screen.dart';
// import 'package:expense_tracker_pranav/main.dart';
import 'package:expense_tracker_pranav/modules/onboarding/onboarding_data.dart';
import 'package:expense_tracker_pranav/ui_components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_sizer/adaptive_sizer.dart';

int _currentPage = 0;

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;

    // final aspectRatio = mediaQuery.height

    navigateToSignupScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const SignupScreen(),
        ),
      );
    }

    navigateToLoginScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 32,
              ),
              CarouselSlider(
                items: onboardingItems
                    .map(
                      (item) => Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 32),
                            Image.asset(
                              item.image,
                              height: 290.h,
                              // width: 290.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 41.h),
                            Text(
                              item.title,
                              style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              // maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: Text(
                                item.body,
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  // height: 486.h,
                  autoPlay: false,
                  aspectRatio: 450.w / 630.h,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (value, _) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              buildCarouselIndicator(),
              const SizedBox(height: 33),
              CustomButton(
                buttonTitle: 'Sign up',
                onPressed: navigateToSignupScreen,
                buttonBackgroudColor: const Color.fromARGB(255, 127, 61, 255),
                buttonTextColor: Colors.white,
              ),
              const SizedBox(height: 16),
              CustomButton(
                buttonTitle: 'Login',
                onPressed: navigateToLoginScreen,
                buttonBackgroudColor: const Color.fromARGB(255, 238, 229, 255),
                buttonTextColor: const Color.fromARGB(255, 127, 61, 255),
              )
            ],
          ),
        ),
      ),
    );
  }
}

buildCarouselIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (int i = 0; i < onboardingItems.length; i++)
        Container(
          margin: const EdgeInsets.all(5),
          height: i == _currentPage ? 15 : 8,
          width: i == _currentPage ? 15 : 8,
          decoration: BoxDecoration(
            color: i == _currentPage
                ? const Color.fromARGB(255, 127, 61, 255)
                : const Color.fromARGB(255, 238, 229, 255),
            shape: BoxShape.circle,
          ),
        )
    ],
  );
}
