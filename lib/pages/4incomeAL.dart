import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:budget_tracking_app/backend/income_chart.dart';

class IncomeGraph extends StatelessWidget {
  const IncomeGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box("UserMoneyInfo");

    return ValueListenableBuilder(
      valueListenable: userBox.listenable(), // 👈 listens for changes
      builder: (context, Box box, _) {
        double income = box.get("Income", defaultValue: 0.00);

        return SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 📊 Pie Chart (can also be made listenable if needed)
              const IncomePieChart(),

              // 💰 Text inside the chart
              Align(
                alignment: const Alignment(0, -0.23),
                child: Text(
                  "\$${income.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
