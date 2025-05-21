import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedToggleSwitch<bool>.dual(
        current: value,
        first: false,
        second: true,
        height: 25,
        indicatorSize: Size.fromRadius(10),
        spacing: 1.0,
        onChanged: (val) => setState(() => value = val),
        style: ToggleStyle(
      backgroundColor: Colors.deepPurple,
      indicatorColor: Colors.white,
      borderRadius: BorderRadius.circular(30),
      indicatorBorder: Border.all(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
