import 'package:flutter/material.dart';

class DailyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Today's transactions
        Text("Today", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          leading: Icon(Icons.book),
          title: Text("Educational Fees"),
          subtitle: Text("Studies"),
          trailing: Text("-\$298.89", style: TextStyle(color: Colors.red)),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.fastfood),
          title: Text("Food"),
          subtitle: Text("Pizzas, momos, chowmein"),
          trailing: Text("-\$28.89", style: TextStyle(color: Colors.red)),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.work),
          title: Text("Work"),
          subtitle: Text("Office"),
          trailing: Text("+\$1220.00", style: TextStyle(color: Colors.green)),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.restaurant),
          title: Text("Restaurants"),
          subtitle: Text("Office"),
          trailing: Text("+\$10.00", style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
