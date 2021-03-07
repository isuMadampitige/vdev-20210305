import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vdev_app/screens/info_screen.dart';
import 'package:vdev_app/screens/sign_in_screen.dart';
import 'package:vdev_app/services/auth_services.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  final User user;

  const DashboardScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DashboardScreen> {
  List<dynamic> _productList = List<dynamic>();
  bool _productsLoading = false;
  String signedTime = "";
  bool _isloading = false;

/*get product details from given endpoint*/
  Future<void> _getProductList() async {
    String url = 'https://gorest.co.in/public-api/categories';
    setState(() {
      _productsLoading = true;
    });
    try {
      await http.get(url).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          setState(() {
            Map<String, dynamic> map = json.decode(response.body);
            _productList = map["data"];
            print(_productList[0]["name"]);
            setState(() {
              _productsLoading = false;
            });
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

/*get user signed in time*/
  _getSignedInTime() {
    DateTime now = DateTime.now();
    signedTime = DateFormat('MMMM-d – kk:mm a').format(now);
    print(signedTime);
  }

  @override
  void initState() {
    _getSignedInTime();
    _getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.user == null
                          ? Center(
                              child: Text('No email.'),
                            )
                          : Container(
                              child: Text(
                                widget.user.email,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 44.0,
                      width: 110.0,
                      child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                        onPressed: () {
                          _showExitDailog();
                        },
                        child: Text(
                          'Sign-Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 3.5 / 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Product Categories",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _productsLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : _productList == null
                            ? Center(
                                child: Text('No products.'),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  3.1 /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  3.5 /
                                                  4,
                                              child: ListView.builder(
                                                itemCount: _productList.length,
                                                shrinkWrap: true,

                                                // physics: ClampingScrollPhysics(),
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return _productCard(
                                                    _productList[index],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                    SizedBox(
                      height: 40,
                    ),
                    LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 44.0,
                            width: 75.0,
                            child: RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InfoScreen(_productList)));
                              },
                              child: Text(
                                'Info',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Signed-in at:",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              signedTime,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          )
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*sign out confirm popup*/
  _showExitDailog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sign Out"),
          content: new Text('Are you sure you want to sign-out?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                AuthService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/*catogories product card*/
  _productCard(dynamic product) {
    return product['name'] == null
        ? Center(
            child: Text('No product name.'),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(0))),
            margin: EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                product['name'],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
  }
}
