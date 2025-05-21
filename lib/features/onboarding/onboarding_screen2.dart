import 'package:flutter/material.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';
import 'package:rhythm_alarm/features/onboarding/onboarding.dart';

class OnboardingScreen2 extends StatelessWidget {
  final PageController controller;
  const OnboardingScreen2({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      controller: controller,
      image: Image.asset(AppImages.onBoarding2, fit: BoxFit.fill,),
      title: AppStrings.morningWalkTitle,
      description: AppStrings.morningWalkDescription,
    );
  }
}
