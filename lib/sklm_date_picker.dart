import 'package:flutter/material.dart';

class SklmDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const SklmDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<SklmDatePicker> createState() => _SklmDatePickerState();
}

class _SklmDatePickerState extends State<SklmDatePicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text("${widget.selectedDate}")
        ],
      ),
    );
  }
}
