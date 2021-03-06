import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vdev_app/screens/splash_screen.dart';

/* @author Isuru Madampitige
   @date 2021/03/05 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpalshScreen(),
    );
  }
}
