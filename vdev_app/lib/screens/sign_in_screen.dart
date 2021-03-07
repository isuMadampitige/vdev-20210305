import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vdev_app/screens/dashboard_screen.dart';
import 'package:vdev_app/services/auth_services.dart';

class SignInScreen extends StatefulWidget {
  final User user;
  const SignInScreen(this.user);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();

  bool isValid;
  bool isSubmites;
  bool _buttonEnableByEmail = false;
  bool _buttonEnableByPassword = false;

  @override
  void initState() {
    super.initState();
    emailContoller.addListener(() {
      print("value: ${emailContoller.text}");
      setState(() {
        if (_formKey.currentState.validate()) {
          if (emailContoller.text.length == 0) {
            _buttonEnableByEmail = false;
            return "* Required";
          } else if (!emailContoller.text.contains("@")) {
            _buttonEnableByEmail = false;
            return "Please enter valid email";
          } else if (!emailContoller.text.contains(".lk")) {
            _buttonEnableByEmail = false;
            return "Please enter valid email";
          } else {
            _buttonEnableByEmail = true;
            return null;
          }
        }
      });
    });

    passwordContoller.addListener(() {
      print("value: ${passwordContoller.text}");
      setState(() {
        if (_formKey.currentState.validate()) {
          if (passwordContoller.text.isEmpty) {
            _buttonEnableByPassword = false;
            return "* Required";
          } else if (passwordContoller.text.length < 6) {
            _buttonEnableByPassword = false;
            return "Password should be atleast 6 characters";
          } else if (passwordContoller.text.length > 15) {
            _buttonEnableByPassword = false;
            return "Password should not be greater than 12 characters";
          } else
            _buttonEnableByPassword = true;
          return null;
        }
      });
    });
  }

/*dailog user sign in loading*/
  _showDailogLoading(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
          content: Container(
              width: 150.0,
              height: 80.0,
              child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 1 / 10,
                          ),
                          LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 3,
                                  child: TextFormField(
                                    controller: emailContoller,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 20.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red[200],
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red[200],
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return "* Required";
                                      } else if (!value.contains("@")) {
                                        return "Please enter valid email";
                                      } else if (!value.contains(".lk")) {
                                        return "Please enter valid email";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (input) => _email = input.trim(),
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 1 / 30,
                          ),
                          LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 3,
                                  child: TextFormField(
                                    controller: passwordContoller,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        size: 20.0,
                                      ),
                                      fillColor: Colors.grey,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red[200],
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red[200],
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else if (value.length < 6) {
                                        return "Password should be atleast 6 characters";
                                      } else if (value.length > 15) {
                                        return "Password should not be greater than 12 characters";
                                      } else
                                        return null;
                                    },
                                    onSaved: (input) =>
                                        _password = input.trim(),
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: 50.0,
                          ),
                          LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 120.0,
                                  child: RaisedButton(
                                    color: _buttonEnableByEmail &&
                                            _buttonEnableByPassword
                                        ? Colors.green
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    onPressed: _buttonEnableByEmail == true &&
                                            _buttonEnableByPassword == true
                                        ? _submit
                                        : null,
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                              visible: (isValid == false && isSubmites == true),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      // Button send image
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Invalid email or password",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Email: joe@black.lk Password: Jo45*78",
                                              style: TextStyle(fontSize: 18)),
                                          Text(
                                              "Email: amal@acme.lk Password: La79*!_io",
                                              style: TextStyle(fontSize: 18)),
                                          Text(
                                              "Email: peter@pan.lk Password: Nap42-24",
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))))
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

/*user sign in */
  _submit() async {
    isSubmites = true;
    try {
      if (_formKey.currentState.validate()) {
        // _showPrograssDailog();
        _showDailogLoading('Please wait while we sign you in ...');
        _formKey.currentState.save();
        await AuthService.signIn(
                context: context, email: _email, password: _password)
            .then((value) {
          Navigator.pop(context);
          if (value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => DashboardScreen(widget.user)));
          }
        });
      }
    } catch (err) {
      Navigator.pop(context);
      print(err);
      setState(() {
        isValid = false;
      });
    }
  }
}
