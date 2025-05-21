import 'package:flutter/material.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';
import 'package:rhythm_alarm/features/onboarding/onboarding.dart';

class OnboardingScreen3 extends StatelessWidget {
  final PageController controller;
  const OnboardingScreen3({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      controller: controller,
      image: Image.asset(AppImages.onBoarding3, fit: BoxFit.fill,),
      title: AppStrings.travelTitle,
      description: AppStrings.travelDescription,
    );
  }
}
