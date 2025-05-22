import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onToggle;

  const ToggleButton({
    super.key,
    required this.initialValue,
    required this.onToggle,
  });

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: AnimatedToggleSwitch<bool>.dual(
        current: value,
        first: false,
        second: true,
        spacing: 1.0,
        height: 25,
        indicatorSize: const Size.fromRadius(10),
        style: ToggleStyle(
          backgroundColor: value ? Colors.deepPurple : Colors.grey,
          indicatorColor: Colors.white,
          borderRadius: BorderRadius.circular(30),
          indicatorBorder: Border.all(color: Colors.deepPurple),
        ),
        onChanged: (val) {
          setState(() {
            value = val;
          });
          widget.onToggle(val);
        },
      ),
    );
  }
}