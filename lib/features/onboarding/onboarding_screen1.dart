import 'package:flutter/material.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';
import 'package:rhythm_alarm/features/onboarding/onboarding.dart';

class OnboardingScreen1 extends StatelessWidget {
  final PageController controller;
  const OnboardingScreen1({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      controller: controller,
      image: Image.asset(AppImages.onBoarding1, fit: BoxFit.fill,),
      title: AppStrings.morningTitle,
      description: AppStrings.morningDescription,
    );
  }
}
