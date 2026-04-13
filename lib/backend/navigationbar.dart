import 'package:flutter/material.dart';
import 'package:budget_tracking_app/pages/1homepage.dart';
import 'package:budget_tracking_app/pages/2Transaction_list.dart';
import 'package:budget_tracking_app/backend/TopbarADDtransacion.dart';
import 'package:budget_tracking_app/backend/4analytics.dart';
import 'package:budget_tracking_app/pages/5settingspage.dart';
class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int currentIndex=0;
  final List<Widget> pages=[
    const Homepage(),
    const TransactionList(),
    const Addtransaction(),
    const Analytics(),
    const Settingspage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom:false,
          child: IndexedStack(
            index: currentIndex,
            children:pages,
          )),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.white,
        //   onPressed: (){
        //     setState(() {
        //       currentIndex=2;
        //     });
        //   },
        //   child: Icon(Icons.add),
    
        // ),
  
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex=index;
            });
          },
          items:const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 145, 193, 248),
            icon: Icon(Icons.home,color:Color.fromARGB(255, 248, 10, 50),size:30),
            label:"",
            activeIcon: Icon(Icons.home,color:Color.fromARGB(255, 3, 237, 50),size: 30,),//DB

          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 145, 193, 248),
            icon: Icon(Icons.list_alt,color: Color.fromARGB(255, 235, 10, 81),size: 30,),
            label:"",
            activeIcon: Icon(Icons.list_alt,color:Color.fromARGB(255, 3, 237, 50),size: 30)//transactionLIST
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 145, 193, 248),
            icon: Icon(Icons.add_circle_outline,color: Color.fromARGB(255, 233, 48, 12),size: 30,),//addd transaction
            label:"",
            activeIcon: Icon(Icons.add_circle_outline,color:Color.fromARGB(255, 3, 237, 50),size: 30)
          
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 145, 193, 248),
            icon: Icon(Icons.bar_chart,color: Color.fromARGB(255, 233, 48, 12),size: 30),//graph
            label:"",
            activeIcon: Icon(Icons.bar_chart,color:Color.fromARGB(255, 3, 237, 50),size: 30)
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 145, 193, 248),
            icon: Icon(Icons.settings,color: Color.fromARGB(255, 233, 48, 12),size: 30),//setting
            label:"",
            activeIcon: Icon(Icons.settings,color:Color.fromARGB(255, 3, 237, 50),size: 30)
          )
        ],
      )
    );
  }
}