// ignore_for_file: unused_import
import 'package:budget_tracking_app/pages/2Transaction_list.dart';
import 'package:budget_tracking_app/backend/TopbarADDtransacion.dart';
import 'package:budget_tracking_app/pages/5settingspage.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_app/backend/variabal.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

// AH studio

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    final userBox = Hive.box("UserMoneyInfo"); //Shortcut to make code more readable
    final incomeBox = Hive.box("IncomeSpread");
    final expenseBox = Hive.box("ExpenseSpread");
    final historyBox = Hive.box("TransactionHistory");


    if (userBox.isEmpty) {
      //initialise values for first ever run of app
      userBox.put("Balance", 0.00);
      userBox.put("Income", 0.00);
      userBox.put("Expense", 0.00);
      userBox.put("Username", "");
    }
    if (incomeBox.isEmpty) {
      incomeBox.put("Salary", 0.00); 
      incomeBox.put("Freelance", 0.00);
      incomeBox.put("Investment", 0.00);
      incomeBox.put("Allowance", 0.00);
      incomeBox.put("Bonus", 0.00);
      incomeBox.put("Other Income", 0.00);
    }
    if (expenseBox.isEmpty){
      expenseBox.put("Food & Groceries", 0.00);
      expenseBox.put("Transportation", 0.00);
      expenseBox.put("Housing & Bills", 0.00);
      expenseBox.put("Entertainment", 0.00);
      expenseBox.put("Health & Fitness", 0.00);
      expenseBox.put("Education", 0.00);
      expenseBox.put("Personal Care", 0.00);
      expenseBox.put("Travel", 0.00);
      expenseBox.put("Others / Miscellaneous", 0.00);
    }

    if (historyBox.isEmpty){
    // Name Note Date Amount Income/Expense Category
    DateTime now = DateTime.now();
    String date = DateFormat('dd/MM/yy').format(now);
    for (int i = 0; i < 16; i++) {
    List initRecord = [" " ," " ,date, 0.00, " ", " "];
      historyBox.add(initRecord);
    print(historyBox);
    }

    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: Hive.box('UserMoneyInfo').listenable(keys: ['Username']),
                builder: (context, Box box, _) {
                  final username = box.get('Username', defaultValue: '');
                  return Text(
                    prompt(username, Now), // rebuilds automatically when username changes
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 35, 244),
                    ),
                  );
                },
              ),
              SizedBox(height: 10, width: 10), //controls y-axiss
              Center(
                child: Container(
                  height: 150, //height of bal box
                  width: 370, //width of bal box
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('assets/images/splash_screen.png')//put image behind text
                    //   ,fit: BoxFit.cover),
                    color: Color(0XFFF4F4F4),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.elliptical(20, 30),
                      left: Radius.elliptical(20, 30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ], //creates a shodowy outline so it distingues bw box and background
                  ),
                  child: Center(                  //BALANCE
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box('UserMoneyInfo').listenable(keys: ['Balance']), //Makes textbox value change whenever db value cange
                      builder: (context, Box box, widget) {
                        final balance = box.get('Balance', defaultValue: 0.00);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                fontSize: 30, //change size of the total bal
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 237, 32, 0), //text color
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "\$$balance", //python f string equivalent 
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30, width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150, //height of income box
                    width: 180, //width of income box
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/splash_screen.png')//put image behind text
                      //   ,fit: BoxFit.cover),
                      color: Color(0XFFF4F4F4),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.elliptical(20, 30),
                        left: Radius.elliptical(20, 30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ], //creates a shodowy outline so it distingues bw box and background
                    ),
                    child: Center(                //INCOME
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('UserMoneyInfo').listenable(keys: ['Income']),
                        builder: (context, Box box, widget) {
                          final income =box.get('Income', defaultValue: 0.0);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Income",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: const Color.fromARGB(221, 243, 3, 3),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "\$$income",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Container(
                    height: 150, //height of Expense box
                    width: 180, //width of expense box
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/splash_screen.png')//put image behind text
                      //   ,fit: BoxFit.cover),
                      color: Color(0XFFF4F4F4),
                      border: Border.all(color: Colors.transparent), //outline
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.elliptical(20, 30),
                        left: Radius.elliptical(20, 30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ], //creates a shodowy outline so it distingues bw box and background
                    ),
                  
                    child: Center(        //EXPENSE
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('UserMoneyInfo').listenable(keys: ['Expense']),
                        builder: (context, Box box, widget) {
                          final expense =box.get('Expense', defaultValue: 0.0);
                          return 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: const Color.fromARGB(221, 243, 42, 42),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "\$$expense",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//understand the row logic...
