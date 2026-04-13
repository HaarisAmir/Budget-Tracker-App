import 'package:budget_tracking_app/pages/3expense.dart';
import 'package:budget_tracking_app/pages/3income.dart';

// void SetExpense(){
//     income=ExpenseamountController.text;
// }

double bal=1000000000000;
double income=200;
double expense=0;
String username="Harissssss";
int Now=DateTime.now().hour;
class Print{
  String message1;//use for saying TOTAL BAL maybe
  dynamic message2;//use for saying the bal or can be anything
  double message3;//use for currency..can be anything 

  Print(this.message1,this.message2,this.message3);
}

Print getbalinfo(){
  return Print(" Total Balance", '\$', bal);
}

Print getincomeinfo(){
  return Print("Income", '\$', income);
}
Print getexpenseinfo(){
  return Print("Expense", '\$', expense);
}
String prompt(username,now){ //we can add smt later ... u can this if u want
  String time="";
  if (6<=now && now<=12) {time= "☀️ Good Morning!";}
  if (12<=now&& now<17) {time= "🌤️ Good Afternoon!";}
  if(now>=17 && now<21){time="🌆 Good Evening!";}
  if (now >=21 || now<6)  {time="🌙 Good Night!";}
  if (username!= "") {
    return "$time $username ";//fix time...
  } else {
    return time;
  }
}