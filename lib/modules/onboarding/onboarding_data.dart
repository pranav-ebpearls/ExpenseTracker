class OnboardingData {
  final String image;
  final String title;
  final String body;

  OnboardingData(
      {required this.image, required this.title, required this.body});
}

final onboardingItems = [
  OnboardingData(
    image: 'assets/onboarding_screen/Illustration1.png',
    title: 'Gain total control \n of your money',
    body: 'Become your own money manager \n and make every cent count',
  ),
  OnboardingData(
    image: 'assets/onboarding_screen/Illustration2.png',
    title: 'Know where your \n money goes',
    body:
        'Track your transaction easily, \n with categories and financial report',
  ),
  OnboardingData(
    image: 'assets/onboarding_screen/Illustration3.png',
    title: 'Planning ahead',
    body: 'Setup your budget for each category \n so you are in control',
  ),
];
