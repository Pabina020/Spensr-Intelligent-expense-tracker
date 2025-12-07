import 'package:flutter/material.dart';

class MonthlyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Monthly View",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text("This is where you can show monthly summary of your transactions."),
          // Add additional content for the Monthly tab if necessary
        ],
      ),
    );
  }
}
