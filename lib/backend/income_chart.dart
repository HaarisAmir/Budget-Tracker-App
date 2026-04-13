import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class IncomePieChart extends StatefulWidget {
  const IncomePieChart({super.key});

  @override
  State<IncomePieChart> createState() => _IncomePieChartState();
}

class _IncomePieChartState extends State<IncomePieChart> {
  late Box incomeBox;

  @override
  void initState() {
    super.initState();
    incomeBox = Hive.box("IncomeSpread");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: incomeBox.listenable(),
      builder: (context, Box box, _) {
        final keys = [
          "Salary",
          "Freelance",
          "Investment",
          "Allowance",
          "Bonus",
          "Other Income"
        ];

        // Use default 10.0 for all categories if Hive box is empty
        final values = keys.map((k) {
          final val = incomeBox.get(k);
          return val == null ? 10.0 : val as double;
        }).toList();

        // Ensure chart always has positive values
        final total = values.fold(0.0, (a, b) => a + b);
        final safeValues = total == 0 ? List.filled(values.length, 1.0) : values;

        final colors = [
          Colors.blueAccent,
          Colors.orangeAccent,
          Colors.greenAccent,
          Colors.purpleAccent,
          Colors.redAccent,
          Colors.tealAccent,
        ];

        // Calculate percentages for legend
        final percentages = safeValues
            .map((v) => ((v / safeValues.fold(0.0, (a, b) => a + b)) * 100))
            .toList();

        return Container(
          decoration:  BoxDecoration(
            color: Colors.white,
          ),
          padding:  EdgeInsets.all(12),
          height: 690,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Income Breakdown",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  height: 2,
                  color: Colors.black,
                ),
              ),
               SizedBox(height: 1), // gap b/w text and piechart

              // Pie chart with fixed height
              SizedBox(
                height: 400,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 75,
                    borderData: FlBorderData(show: false),
                    sections: List.generate(keys.length, (i) {
                      final value = safeValues[i];
                      return PieChartSectionData(
                        color: colors[i],
                        value: value,
                        title: '', // hide title on chart
                        radius: 115,
                      );
                    }),
                  ),
                ),
              ),
               SizedBox(height: 8), // space between chart and legend

              // Legend with percentages
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 8,
                children: List.generate(keys.length, (i) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colors[i],
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${keys[i]} (${percentages[i].toStringAsFixed(2)}%)',
                        style:  TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
