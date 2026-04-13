import 'package:budget_tracking_app/backend/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin {

    @override
  void initState() {//method that makes it full screen and hides all the navigationbar 
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3,microseconds: 5),(){//decides amount of time to show splashscreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_)=> Bottomnavigation()
        ));
    });
  }

@override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);//puts out of fullscreen and shows navi bar again
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:Color(0xFF01201F)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_screen.png',
              //image for splash screen
              fit:BoxFit.cover ,
      
            ),
            // SizedBox(height: 20,),  
            // Text("budget tracking app",style: TextStyle(   // add ur text herre if needed -dont deletee
            //   fontStyle: FontStyle.italic,
            //   color: Colors.red,
            //   fontSize: 32,
            // ),)    
          ],
        ),
      ),
    );
  }
}