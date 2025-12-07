import 'package:flutter/material.dart';
import 'package:spensr/screen/home/view/daily_view.dart';
import 'package:spensr/screen/home/view/monthly_view.dart';
import 'package:spensr/screen/home/view/weekly_view.dart';


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

            // TabBarView that controls content for Daily, Weekly, and Monthly views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Daily View
                  DailyView(),
                  // Weekly View
                  WeeklyView(),
                  // Monthly View
                  MonthlyView(),
                ],
              ),
            ),

            // // Bottom Bar with Icons
            // BottomNavigationBar(
            //   items: [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Chart'),
            //     BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Voice'),
            //     BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
            //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
