import 'package:budget_tracking_app/backend/variabal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:budget_tracking_app/backend/DatabaseHelper.dart';

// DateTime Now = DateTime(2019,4,15);
DateTime Now = DateTime.now();
String Date = DateFormat('dd/MM/yy').format(Now);

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  TextEditingController IncomeDatecontroller = TextEditingController(text: Date);
  final db = DatabaseFunction();
  TextEditingController IncomeamountController = TextEditingController();
  TextEditingController IncomeCategoryController = TextEditingController();
  TextEditingController IncomeNotecontroller = TextEditingController();
  TextEditingController IncomeNamecontroller = TextEditingController();
  final List<String> IncomeCategory = [
    'Salary',
    'Freelance',
    'Investment',
    'Allowance',
    'Bonus',
    'Other Income'
  ];
  String? selectedIncome; // dropdown menu option saved in this

  @override
  Widget build(BuildContext context) {
    return SafeArea( // prevents UI from being obstructed by system bars
      bottom: true,
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date
              Text(
                "Date",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),//controls space b/w them
              TextField(
                controller: IncomeDatecontroller,
                enabled: false,
                showCursor: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              // Name
              Text(
                "Name",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                controller: IncomeNamecontroller,
                keyboardType: TextInputType.text,
                // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "Transaction Name",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w800
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  counterText: "",
                  contentPadding:EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              // Amount
              Text(
                "Amount",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                controller: IncomeamountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
                maxLength: 8,
                decoration: InputDecoration(
                  hintText: "Enter your Amount",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w800
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  counterText: "",
                  contentPadding:EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              // Category
              Text(
                "Category",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedIncome,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  hintText: "Select Income type",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w800
                  ),
                ),
                
                items: IncomeCategory.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedIncome = newValue;
                  });
                },
              ),
              SizedBox(height: 10),
              // Note
              Text(
                "Note",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                controller: IncomeNotecontroller,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w800
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  counterText: "",
                  contentPadding:EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              SizedBox(height: 30),
              // Save button 
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
                  child: SizedBox(
                    height: 70,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        String input = IncomeamountController.text;
                        double amount = double.tryParse(input) ?? 0.00;//coverts the string value of amount input to double
                        String name = IncomeNamecontroller.text;
                        String note = IncomeNotecontroller.text;
                        String date = IncomeDatecontroller.text;
                        if (selectedIncome == null && (input.isEmpty || amount == 0)) {//input not inputted and category not selected
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("⚠️ Please input valid Amount and select a Category"),
                              backgroundColor: Color.fromARGB(255, 12, 29, 1),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else if (input.isEmpty || amount == 0){// no amount inputted
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("⚠️ Please input valid Amount"),
                              backgroundColor: Color.fromARGB(255, 12, 29, 1),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else if(selectedIncome == null){// no category selected
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("⚠️ Please select an Income Category"),
                              backgroundColor: Color.fromARGB(255, 12, 29, 1),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else{
                          db.addIncome(name,note, date, amount, selectedIncome!);
                          IncomeCategoryController.clear();
                          IncomeNamecontroller.clear();
                          IncomeNotecontroller.clear();
                          IncomeamountController.clear();
                          setState(() {
                            selectedIncome = null;
                          });

                        }
                      },
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold , 
                          color: Color.fromARGB(255, 243, 184, 8))),
                      ),
                    ),
                  ),
                ),
              ]),
          ),
        ),
      );
  }
}
