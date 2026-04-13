import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensePieChart extends StatefulWidget {
  const ExpensePieChart({super.key});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  late Box expenseBox;

  @override
  void initState() {
    super.initState();
    expenseBox = Hive.box("ExpenseSpread");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: expenseBox.listenable(),
      builder: (context, Box box, _) {
        final keys = [
          "Food & Groceries",
          "Transportation",
          "Housing & Bills",
          "Entertainment",
          "Health & Fitness",
          "Education",
          "Personal Care",
          "Travel",
          "Others / Miscellaneous"
        ];

        // Use default 10.0 for all categories if Hive box is empty
        final values = keys.map((k) {
          final val = expenseBox.get(k);
          return val == null ? 10.0 : val as double;
        }).toList();

        // Ensure chart always has positive values
        final total = values.fold(0.0, (a, b) => a + b);
        final safeValues = total == 0 ? List.filled(values.length, 1.0) : values;

        final colors = [
          Colors.blue,
          Colors.orange,
          Colors.green,
          Colors.purple,
          Colors.red,
          Colors.teal,
          Colors.indigo,
          Colors.amber,
          Colors.lime
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
                "Expense Breakdown",
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
