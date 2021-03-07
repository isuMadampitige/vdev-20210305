import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vdev_app/screens/dashboard_screen.dart';
import 'package:vdev_app/screens/sign_in_screen.dart';

class SpalshScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpalshScreenState();
  }
}

class _SpalshScreenState extends State<SpalshScreen> {
  void pageMap() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      var user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // signed in
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => DashboardScreen(user)));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SignInScreen()));
      }
    });
  }

  @override
  void initState() {
    pageMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: width,
          height: height,
          child: Center(
            child: Container(
              height: height / 5,
              child: Image(image: AssetImage('assets/images/vdev.png')),
            ),
          )),
    );
  }
}
