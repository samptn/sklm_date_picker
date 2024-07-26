import 'package:flutter/material.dart';

class SklmDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const SklmDatePicker(
      {super.key, required this.selectedDate, required this.onDateSelected});

  @override
  State<SklmDatePicker> createState() => _SklmDatePickerState();
}

class _SklmDatePickerState extends State<SklmDatePicker> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _onDateTap(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  void _changeMonth(int monthOffset) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + monthOffset,
      );
    });
  }

  List<Widget> _buildHeader() {
    final List<String> weekDays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ];
    return weekDays
        .map((day) => Expanded(
              child: Center(child: Text(day)),
            ))
        .toList();
  }

  List<Widget> _buildDays() {
    final List<Widget> days = [];
    final int firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month).weekday % 7;
    final int totalDaysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    for (int i = 0; i < firstDayOfMonth; i++) {
      days.add(const Expanded(child: SizedBox()));
    }

    for (int i = 1; i <= totalDaysInMonth; i++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, i);
      days.add(Expanded(
        child: GestureDetector(
          onTap: () => _onDateTap(date),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _selectedDate.year == date.year &&
                      _selectedDate.month == date.month &&
                      _selectedDate.day == date.day
                  ? Colors.blue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$i',
                style: TextStyle(
                  color: _selectedDate.year == date.year &&
                          _selectedDate.month == date.month &&
                          _selectedDate.day == date.day
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Date'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _changeMonth(-1),
              ),
              Text(
                '${_currentMonth.month}/${_currentMonth.year}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            children: _buildHeader() + _buildDays(),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
