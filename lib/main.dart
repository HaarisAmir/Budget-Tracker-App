// ignore: unused_import
import 'package:budget_tracking_app/pages/1homepage.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_app/backend/0splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("UserMoneyInfo");
  await Hive.openBox("TransactionHistory");
  await Hive.openBox("IncomeSpread");
  await Hive.openBox("ExpenseSpread");
  runApp(Myapp());
}
class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  // bool isDarkMode=false; feature to be implemanted later
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(), feature to be implemanted later
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
  
//       debugShowCheckedModeBanner: false,
//       home:SplashScreen()
//     );
//   }
// }
