import 'package:flutter/material.dart';
import 'package:moh_phi_project/screens/phi_dashboard.dart';
//import 'package:moh_phi_project/screens/authentication/login.dart';
import 'package:moh_phi_project/screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
    );
    
  }
}
