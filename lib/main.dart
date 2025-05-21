import 'package:flutter/material.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';
import 'package:rhythm_alarm/features/onboarding/onboarding_screen1.dart';
import 'package:rhythm_alarm/features/onboarding/onboarding_screen2.dart';
import 'package:rhythm_alarm/features/onboarding/onboarding_screen3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter rhythm Alarm App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = PageController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: PageView(
        controller: controller,
        children: [
          OnboardingScreen1(controller: controller,),
          OnboardingScreen2(controller: controller),
          OnboardingScreen3(controller: controller),
        ],
      ),
    );
  }
}
