import 'package:budget_tracking_app/backend/variabal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:budget_tracking_app/backend/DatabaseHelper.dart';

DateTime Now = DateTime.now();
String Date = DateFormat('dd/MM/yy').format(Now);

class Expense extends StatefulWidget {
  Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  TextEditingController ExpenseDatecontroller = TextEditingController(text: Date);
  final db = DatabaseFunction();
  TextEditingController ExpenseamountController = TextEditingController();
  TextEditingController ExpenseCategoryController = TextEditingController();
  TextEditingController ExpenseNotecontroller = TextEditingController();
  TextEditingController ExpenseNamecontroller = TextEditingController();
  final List<String> ExpenseCategory = [
    'Food & Groceries',
    'Transportation',
    'Housing & Bills',
    'Entertainment',
    'Health & Fitness',
    'Education',
    'Personal Care',
    'Travel',
    'Others / Miscellaneous',
  ];
  String? selectedExpense; // dropdown menu option saved in this

  @override
  Widget build(BuildContext context) {
    return SafeArea( // makes suree nav bar doesnt interfere with save button
      bottom: true,
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date
              Text(
                "Date",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                controller:ExpenseDatecontroller,
                enabled: false,
                keyboardType: TextInputType.number,
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
                controller: ExpenseNamecontroller,
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
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                controller: ExpenseamountController,
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
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                value: selectedExpense,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  hintText: "Select Expense type",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w800
                  ),
                ),
                items: ExpenseCategory.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedExpense = newValue;
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
                controller: ExpenseNotecontroller,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w800
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              SizedBox(height: 30),
              // sabe button
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
                  child: SizedBox(
                    height: 70,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        String input = ExpenseamountController.text;
                        double amount = double.tryParse(input) ?? 0.00; //coverts the string value of amount input to double
                        String name = ExpenseNamecontroller.text;
                        String note = ExpenseNotecontroller.text;
                        String date = ExpenseDatecontroller.text;
                        print(date);
                        if (selectedExpense == null && (input.isEmpty || amount == 0)) { //input not inputted and category not selected
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("⚠️ Please input valid Amount and select a Category"),
                              backgroundColor:  Color.fromARGB(255, 12, 29, 1),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else if (input.isEmpty || amount == 0){ // no amount inputted
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("⚠️ Please input valid Amount"),
                              backgroundColor:  Color.fromARGB(255, 12, 29, 1),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else if(selectedExpense == null){ // no category selected
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("⚠️ Please select a Category"),
                              backgroundColor:  Color.fromARGB(255, 12, 29, 1),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else{
                          db.addExpense(name, note, date,amount, selectedExpense!); //update database
                          ExpenseCategoryController.clear(); //clear text fields
                          ExpenseNamecontroller.clear();
                          ExpenseNotecontroller.clear();
                          ExpenseamountController.clear();
                          setState(() {
                            selectedExpense = null;
                          });
                          
                        }
                      },
                      child:  Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.purple),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
