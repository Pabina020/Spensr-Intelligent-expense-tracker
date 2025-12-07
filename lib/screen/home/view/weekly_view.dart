import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs: Daily, Weekly, Monthly
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Home dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting text
            Text(
              "Good Morning, Pabs!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Have a good day!", style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            // TabBar with Daily, Weekly, and Monthly tabs
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Daily"),
                Tab(text: "Weekly"),
                Tab(text: "Monthly"),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
            ),

            SizedBox(height: 20),

            // Expense and Income
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Expense", style: TextStyle(fontSize: 16)),
                    Text("\$729.00", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Income", style: TextStyle(fontSize: 16)),
                    Text("\$239.00", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Weekly View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Daily View (Placeholder for now)
                  Center(child: Text("Daily View")),
                  // Weekly View
                  WeeklyView(),
                  // Monthly View (Placeholder for now)
                  Center(child: Text("Monthly View")),
                ],
              ),
            ),

            // Bottom Bar with Icons
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Chart'),
                BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Voice'),
                BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date range
        Text("Jun 22 - Jun 30, 2025", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),

        // Weekly total
        Text("Total for this week", style: TextStyle(fontSize: 18)),
        Text("\$2344.12", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),

        // Bar chart
        BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            maxY: 500,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            // barGroups: [
            //   BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 250, colors: [Colors.blue])]),
            //   BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 300, colors: [Colors.blue])]),
            //   BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 350, colors: [Colors.blue])]),
            //   BarChartGroupData(x: 3, barRods: [BarChartRodData(y: 450, colors: [Colors.blue])]),
            //   BarChartGroupData(x: 4, barRods: [BarChartRodData(y: 400, colors: [Colors.blue])]),
            //   BarChartGroupData(x: 5, barRods: [BarChartRodData(y: 200, colors: [Colors.blue])]),
            //   BarChartGroupData(x: 6, barRods: [BarChartRodData(y: 100, colors: [Colors.blue])]),
            // ],
          ),
        ),

        SizedBox(height: 20),

        // Transaction list
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
