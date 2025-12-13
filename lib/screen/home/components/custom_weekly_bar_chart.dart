
import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';
import 'package:spensr/localization/localized_strings.dart';

class CustomWeeklyBarChart extends StatefulWidget {
  const CustomWeeklyBarChart({super.key});

  @override
  State<CustomWeeklyBarChart> createState() => _CustomWeeklyBarChartState();
}

class _CustomWeeklyBarChartState extends State<CustomWeeklyBarChart> {
  int selectedIndex = -1;
  final List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  final List<String> fullDayNames = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  // Static height data for the bars (example data)
  final List<double> heights = [60, 70, 80, 40, 40, 30, 90];

  @override
  Widget build(BuildContext context) {
    // Use the selectedIndex to update the label
    String dayLabel = selectedIndex == -1
        ? LocalizedStrings.today
        : fullDayNames[selectedIndex];

    return SizedBox(
      height: 200, // Fixed height to prevent overflow
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Chart Section: Weekly Bar Chart
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(days.length, (index) {
                  final bool isSelected = selectedIndex == index;
                  final double barHeight = heights[index] + (isSelected ? 10 : 0);
                  final Color barColor = isSelected
                      ? AppColors.of(context).primary
                      : AppColors.of(context).barchartBG;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: barHeight,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: barColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            days[index],
                            style: TextStyle(
                              color: AppColors.of(context).primaryText,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          
          // Day Label Section
          Container(
            height: 40, // Fixed height for the label section
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              dayLabel,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.of(context).disabledText,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
