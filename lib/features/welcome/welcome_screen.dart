import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_alarm/common_widgets/custom_button.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';
import 'package:rhythm_alarm/features/alarm/alarm_screen.dart';
import 'package:rhythm_alarm/helpers/location_helper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _handleLocationPermission(BuildContext context) async {
    try {
      final location = await LocationHelper.getCurrentLocationAddress();
      
      if (location == null || 
          location.contains('disabled') ||
          location.contains('denied') ||
          location.contains('Error')) {
        if (context.mounted) {
          _showErrorSnackBar(context, location ?? 'Unknown location error');
        }
        return;
      }

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmScreen(location: location),
          ),
        );
      }
    } catch (e) {
      debugPrint('Location error: $e');
      if (context.mounted) {
        _showErrorSnackBar(context, 'Failed to get location. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 80),
                Text(
                  AppStrings.welcomeHead,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  AppStrings.welcomeDes,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(AppImages.morning2),
                const SizedBox(height: 10),
                CustomBtnWidget(
                  btnName: AppStrings.locationBtn,
                  btnImg: AppImages.location,
                  onPressed: () => _handleLocationPermission(context),
                ),
                const SizedBox(height: 10),
                CustomBtnWidget(
                  btnName: AppStrings.homeBtn, 
                  btnImg: '',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AlarmScreen(location: AppStrings.selectedLocValue,)));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}