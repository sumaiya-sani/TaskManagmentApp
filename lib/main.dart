import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daily_task/Screen/bottom.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

runApp(
   MaterialApp(
    home: BottomBar(),
    debugShowCheckedModeBanner: false,
  )

);
 
  
}

