// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:budget_tracking_app/pages/3expense.dart';
import 'package:budget_tracking_app/pages/3income.dart';



class Addtransaction extends StatefulWidget {
  const Addtransaction({super.key});

  @override
  State<Addtransaction> createState() => _AddtransactionState();
}

class _AddtransactionState extends State<Addtransaction> {
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
                text: "Income",
                icon: Icon(
                  Icons.payments_sharp,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  size: 40,//change size of icon
                  ),
              ),
              Tab(
                text: "Expense",
                icon: Icon(
                  Icons.money_off_csred,
                  color: const Color.fromARGB(255, 253, 253, 253),
                  size: 35,//change size of icon
                )  
              ),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            Income(),
            Expense()         
          ],
        )
      ));
  }
}