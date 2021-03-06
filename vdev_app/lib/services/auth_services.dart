import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* @author Isuru Madampitige
   @date 2021/03/05 */

class AuthService {
  static Future<bool> signIn(
      {BuildContext context, String email, String password}) async {
    final _auth = FirebaseAuth.instance;
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user;
      if (user != null) {
        return true;
      }
      return false;
    } on PlatformException catch (err) {
      throw (err);
    }
  }

  static signOut() {
    final _auth = FirebaseAuth.instance;
    _auth.signOut();
  }
}
