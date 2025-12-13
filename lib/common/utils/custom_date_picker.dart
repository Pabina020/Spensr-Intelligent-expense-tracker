import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String weekLabel;
  final Function(DateTime pickedDate) onDatePicked;

  const CustomDatePicker({
    super.key,
    required this.weekLabel,
    required this.onDatePicked,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      onDatePicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Text(
        weekLabel,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}

Future<DateTime?> showCustomMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final today = DateTime.now();

  final picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(today.year - 5),
    lastDate: DateTime(today.year, today.month),
    initialDatePickerMode: DatePickerMode.year,
    helpText: 'Select month',
    fieldHintText: 'MM/YYYY',
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    return DateTime(picked.year, picked.month, 1);
  }

  return null;
}
