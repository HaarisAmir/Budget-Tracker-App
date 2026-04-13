// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:budget_tracking_app/pages/4expenseAL.dart';
import 'package:budget_tracking_app/pages/4incomeAL.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          backgroundColor:Color.fromARGB(255, 145, 193, 248),
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 255, 221, 1),
            indicatorWeight: 5
            ,tabs: [
              Tab(
                text: "Income",//name of the thing in topbar for AL
                icon: Icon(
                  Icons.trending_up_rounded,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  size: 40,//change size of icon
                  ),
              ),
              Tab(
                text: "Expense",//name of the thing in topbar for AL
                icon: Icon(
                  Icons.trending_down_rounded,
                  color: const Color.fromARGB(255, 253, 253, 253),
                  size: 35,//change size of icon
                )  
              ),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            IncomeGraph(),//calling the pages 
            ExpenseGraph()         
          ],
        )
      ));
  }
}