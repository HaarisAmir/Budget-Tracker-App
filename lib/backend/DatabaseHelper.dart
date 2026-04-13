import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseFunction{
  final userBox = Hive.box("UserMoneyInfo");
  final iSpread = Hive.box("IncomeSpread");
  final eSpread = Hive.box("ExpenseSpread");
  final historyBox  = Hive.box("TransactionHistory");

  void addIncome(String Name, String Note, String date, double newIncome, String incomeType)async{
    double oldIncome = userBox.get("Income", defaultValue: 0.00); // get old values
    double oldbalance = userBox.get("Balance", defaultValue: 0.00);
    double oldTypeValue = iSpread.get(incomeType, defaultValue: 0.00);
    userBox.put("Income", oldIncome + newIncome); //update in database
    userBox.put("Balance", oldbalance + newIncome);
    iSpread.put(incomeType, oldTypeValue + newIncome); // will update UI as its listenable
    List HistoryValues = historyBox.values.toList();// get old records
    List newRecord = [Name,Note,date,newIncome,"Income",incomeType];// get new record
    HistoryValues.insert(0, newRecord); // adds to beginning of list
    if (historyBox.length >16){
      historyBox.deleteAt(16);
    }
    await historyBox.clear();
    await historyBox.addAll(HistoryValues);
  }
  void addExpense(String Name, String Note, String date,double newExpense, String expenseType)async{
    double oldExpense = userBox.get("Expense", defaultValue: 0.00); //get old value
    double oldbalance = userBox.get("Balance", defaultValue: 0.00);
    double oldTypeValue = eSpread.get(expenseType, defaultValue: 0.00);
    userBox.put("Expense", oldExpense + newExpense); //pudate in database
    userBox.put("Balance", oldbalance - newExpense);
    eSpread.put(expenseType, oldTypeValue + newExpense);
    List HistoryValues = historyBox.values.toList();// get old records
    List newRecord = [Name,Note,date,newExpense,"Expense",expenseType];// get new record
    print("New Record: $newRecord");
    HistoryValues.insert(0, newRecord); // adds to beginning of list
    if (historyBox.length >16){
      historyBox.deleteAt(16);
    }
    await historyBox.clear();
    await historyBox.addAll(HistoryValues);

  }

  void clearValues(){
    //reset Homepage values
    userBox.put("Balance",0.00);
    userBox.put("Income", 0.00);
    userBox.put("Expense", 0.00);
    userBox.put("Username", "");
    // reset income spread
    iSpread.put("Salary", 0.00);
    iSpread.put("Freelance", 0.00);
    iSpread.put("Investment", 0.00);
    iSpread.put("Allowance", 0.00);
    iSpread.put("Bonus", 0.00);
    iSpread.put("Other Income", 0.00);
    //reset expense spread
    eSpread.put("Food & Groceries", 0.00);
    eSpread.put("Transportation", 0.00);
    eSpread.put("Housing & Bills", 0.00);
    eSpread.put("Entertainment", 0.00);
    eSpread.put("Health & Fitness", 0.00);
    eSpread.put("Education", 0.00);
    eSpread.put("Personal Care", 0.00);
    eSpread.put("Travel", 0.00);
    eSpread.put("Others / Miscellaneous", 0.00);
    // reset history
    historyBox.clear();
  }

  void saveUsername(String newUsername){
    userBox.put("Username", newUsername);
  }

}

