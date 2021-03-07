import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  final List<dynamic> productList;

  const InfoScreen(this.productList);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  TabController _tabController;
  bool _productsLoading = false;

  _init() {
    print(widget.productList.length);
  }

  @override
  void initState() {
    _init();
    _tabController = TabController(vsync: this, length: 3);
    // _tabController.addListener(_handleTabChange);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            controller: _tabController,
            tabs: [
              Tab(
                text: 'Project',
              ),
              Tab(
                text: 'Categories',
              ),
              Tab(
                text: 'About',
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
              child: TabBarView(
            controller: _tabController,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 3.5 / 4,
                  height: MediaQuery.of(context).size.height * 3 / 4,
                  child: Image(image: AssetImage('assets/images/project.png')),
                ),
              ),
              Container(
                child: _productsLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : widget.productList == null
                        ? Center(
                            child: Text('No products.'),
                          )
                        : Container(
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              3.5 /
                                              4,
                                          child: ListView.builder(
                                            itemCount:
                                                widget.productList.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _productCard(
                                                widget.productList[index],
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
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text("Isuru Madampitige",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            style: TextStyle(fontSize: 22, color: Colors.red),
                            text: "GitHub Project Click Here",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url =
                                    "https://github.com/isuMadampitige/vdev-20210305.git";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                      ])),
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
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
                  color: Colors.green,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                product['name'],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
  }
}
