import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyBox = Hive.box("TransactionHistory");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(218, 5, 43, 16),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 4,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 6,
          radius: const Radius.circular(10),
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(24),
            itemCount: 15,
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                valueListenable: historyBox.listenable(keys: [index]),
                builder: (context, Box box, _) {
                  DateTime now = DateTime.now();
                  String date = DateFormat('dd/MM/yy').format(now);

                  // Get record, provide default if empty
                  final record = box.get(
                    index,
                    defaultValue: [" ", " ", date, 0.00, " ", " "],
                  );

                  // Text color depending on Income/Expense
                  final color = record[4] == "Income"
                      ? const Color.fromARGB(255, 0, 180, 0)
                      : const Color.fromARGB(255, 167, 60, 60);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.elliptical(20, 30),
                          left: Radius.elliptical(20, 30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transaction Name: ${record[0]}\n"
                              "Transaction Type: ${record[5]}\n"
                              "Transaction Amount: ${record[3]}\n"
                              "Transaction Note: ${record[1]}\n"
                              "Transaction Date: ${record[2]}",
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w900,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
