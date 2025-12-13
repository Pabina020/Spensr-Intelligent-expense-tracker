
import 'package:flutter/material.dart';
import 'daily_view.dart';
import 'weekly_view.dart';
import 'monthly_view.dart';
import 'package:spensr/theme/app_colors.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: HomeView(),
  ));
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning, Pabs!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: colors.primaryText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Have a great day!",
                    style: TextStyle(
                      fontSize: 16,
                      color: colors.disabledText,
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colors.containerBG,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        "Daily",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Weekly",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Monthly",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: colors.disabledText,
                  indicator: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Tab Content Area
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DailyView(),
                  WeeklyView(),
                  MonthlyView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
