import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_alarm/constants/app_constants.dart';

class CustomBtnWidget extends StatelessWidget {
  final String btnName;
  final String btnImg;
  final VoidCallback? onPressed;

  const CustomBtnWidget({
    super.key,
    required this.btnName,
    required this.btnImg,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(100, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: 10),
          btnImg.isNotEmpty
              ? Image.asset(btnImg, width: 30)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
