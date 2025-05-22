import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_alarm/common_widgets/toggle_btn.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';

class AlarmCardWidget extends StatelessWidget {
  final String timeString;
  final String dateString;
  final bool initialToggleValue;
  final ValueChanged<bool> onToggle;

  const AlarmCardWidget({
    super.key,
    required this.timeString,
    required this.dateString,
    required this.initialToggleValue,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.nightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            timeString,
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.white),
          ),
          Row(
            children: [
              Text(
                dateString,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              ToggleButton(
                initialValue: initialToggleValue,
                onToggle: onToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}