import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:budget_tracking_app/backend/expense_chart.dart';

class ExpenseGraph extends StatelessWidget {
  const ExpenseGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box("UserMoneyInfo");

    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: userBox.listenable(keys: ["Expense"]),
        builder: (context, Box box, _) {
          double expense = box.get("Expense", defaultValue: 0.00);

          return Stack(
            alignment: Alignment.center,
            children: [
              const ExpensePieChart(),
              Align(
                alignment: const Alignment(0, -0.23),
                child: Text(
                  "\$${expense.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

