
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:spensr/theme/app_colors.dart';

class MonthlyView extends StatelessWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with month and total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month selector
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: colors.containerBG,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month, size: 16, color: colors.primaryText),
                    SizedBox(width: 8),
                    Text(
                      'July 2025',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.primaryText,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.keyboard_arrow_down, size: 16, color: colors.primaryText),
                  ],
                ),
              ),

              // Total for this month
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total for this Month',
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.disabledText,
                    ),
                  ),
                  Text(
                    '\$2344.12',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: colors.primaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // Graph container
          Container(
            height: 220,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.containerBG,
              borderRadius: BorderRadius.circular(16),
            ),
            child: LineChart(
              LineChartData(
                minX: 1,
                maxX: 31,
                minY: 0,
                maxY: 2200,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 7,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: colors.disabledText,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 200),
                      FlSpot(5, 400),
                      FlSpot(10, 300),
                      FlSpot(15, 1100),
                      FlSpot(20, 900),
                      FlSpot(25, 1800),
                      FlSpot(30, 2100),
                    ],
                    isCurved: true,
                    color: colors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: colors.primary.withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Today section
          Text(
            'Today',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.primaryText,
            ),
          ),

          SizedBox(height: 16),

          // Today's transaction
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.check_circle, color: Colors.green),
            ),
            title: Text(
              'Educational Fees',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              'Studies',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            trailing: Text(
              '-\$298.89',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),

          SizedBox(height: 24),

          // Yesterday section
          Text(
            'Yesterday',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.primaryText,
            ),
          ),

          SizedBox(height: 16),

          // Yesterday's transactions
          Column(
            children: [
              // Food
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.restaurant_menu, color: Colors.deepPurple),
                ),
                title: Text(
                  'Food',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Pizzas, momos, chowmein',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                trailing: Text(
                  '-\$28.89',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Work
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.work, color: Colors.blue),
                ),
                title: Text(
                  'Work',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Office',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                trailing: Text(
                  '+\$1220.00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
