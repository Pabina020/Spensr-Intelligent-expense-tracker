
import 'package:flutter/material.dart';
import 'package:spensr/screen/home/components/custom_weekly_bar_chart.dart';
import 'package:spensr/theme/app_colors.dart';

class WeeklyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expense and Income Cards
            Row(
              children: [
                // Expense Card
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.containerBG,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expense",
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.disabledText,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$729.00",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Income Card
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.containerBG,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Income",
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.disabledText,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$239.00",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Date range selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colors.containerBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 18, color: colors.primaryText),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Jun 23 - Jun 30, 2023",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.primaryText,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20, color: colors.primaryText),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Total for this week card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.containerBG,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total for this week",
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.disabledText,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$224.12",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: colors.primaryText,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Chart Section - Using the CustomWeeklyBarChart
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.containerBG,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Optional: Add a title for the chart if needed
                  // Text(
                  //   "Weekly Spending",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w600,
                  //     color: colors.primaryText,
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  
                  // The CustomWeeklyBarChart widget
                  CustomWeeklyBarChart(),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Today section
            Text(
              "Today",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colors.primaryText,
              ),
            ),

            SizedBox(height: 16),

            // Today's transactions
            Column(
              children: [
                // Educational Fees
                _buildTransactionItem(
                  icon: Icons.book,
                  title: "Educational Fees",
                  subtitle: "Studies",
                  amount: "-\$298.89",
                  amountColor: Colors.red,
                ),
                
                // Food
                _buildTransactionItem(
                  icon: Icons.fastfood,
                  title: "Food",
                  subtitle: "Pizzas, momos, chowmein",
                  amount: "-\$28.89",
                  amountColor: Colors.red,
                ),
                
                // Work
                _buildTransactionItem(
                  icon: Icons.work,
                  title: "Work",
                  subtitle: "Office",
                  amount: "+\$1220.00",
                  amountColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
