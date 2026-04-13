import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_tracking_app/backend/DatabaseHelper.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  final db = DatabaseFunction();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 6,
        radius: Radius.circular(10),
        child: ListView(
          controller: _scrollController,
          padding:  EdgeInsets.all(24),
          children: [
            SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "Enter username",
                    hintStyle:TextStyle(fontWeight: FontWeight.w800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    counterText: "",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Save button section
            SizedBox(
              height: 60, 
              child: ElevatedButton(
                onPressed: () {
                  String input = usernameController.text.trim();
                  if (input.isNotEmpty) {
                    db.saveUsername(input); 
                    usernameController.clear();
                  } else {
                    
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("⚠️ Please input Username"),
                        backgroundColor: Color.fromARGB(255, 12, 29, 1),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), 
                  ),
                ),
                child: Text(
                  "Save",//save button for the username text field
                  style: TextStyle(
                      fontSize: 18
                      ,fontWeight: FontWeight.bold
                      ,color: Colors.white) 
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FAQ:",
                  style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w800),
                ), 
          ],
        ),
        SizedBox(height: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:What is this app?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:This is a budget tracking app that helps you manage your income and expenses easily. You can add transactions, see a list of them, and view charts of your spending habits."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),
        SizedBox(height: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:How do I add a transaction?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:Tap on the AppBar to select Income or Expense, then fill in the details: Name, Amount, Category, and Note. Once you save, it will appear in your transaction list."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),
        SizedBox(height: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:Can I edit or delete a transaction?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:No, once a transaction is added, it cannot be edited or deleted."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),//Can I track different categories of spending?
        SizedBox(height: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:Can I track different categories of spending?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:Yes! You can assign each transaction to a category (like Food, Entertainment, or Bills) to see category-wise summaries in the chart."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),
        SizedBox(height: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:Does the app work offline?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:Yes, the app works completely offline. You don’t need an internet connection to add or view transactions."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),
        SizedBox(height: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:Can I reset all my data?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:Yes, the app works completely offline. You don’t need an internet connection to add or view transactions."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),
      
            SizedBox(height: 5),
            
                ElevatedButton.icon(
                  onPressed: () {
                    db.clearValues(); //clears all the values stored in db
                  },
                  icon: Icon(Icons.refresh_outlined, color: Colors.white),
                  label: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 53, 156, 165),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), 
                    ),
                    padding:EdgeInsets.symmetric(
                        horizontal: 100, vertical: 16), 
                    elevation: 2,
                  ),
                ),
                SizedBox(height: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q:Who can I contact for support?"
            ,style:TextStyle(
              fontSize: 23,fontWeight: FontWeight.w800,
            )
            )
          ],
        ),
        SizedBox(height: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("A:You can contact us at ahstudioteam@gmail.com if you face any issues or have suggestions."
            ,style:TextStyle(
              fontSize: 20,fontWeight: FontWeight.w800
            )
            )
          ],
        ),

              ],
            ),
      ),
    );
  }
}
