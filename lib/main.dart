import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view/Screen/OverView.dart';
import 'package:page_view/model/User.dart';
import 'package:page_view/widgets/CardSendMoney.dart';
import 'package:page_view/widgets/HistoryCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color inactiveColor = Color.fromRGBO(158, 158, 158, 1);
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  ListHistory listHistory = new ListHistory();
  ListHistory listHistory2 = new ListHistory();
  PageController controller = PageController();
  StreamController<double> swipeCardSreamControler = StreamController<double>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    swipeCardSreamControler.sink.add(0.0);
    setState(() {
      listHistory.list.add(History(
          service_name: 'Viettin Bank',
          service: Service.receive,
          date_trans: '07-23',
          time_trans: "20:05",
          money: 267.8));
      listHistory.list.add(History(
          service_name: 'Viettin Bank',
          service: Service.transfer,
          date_trans: '07-23',
          time_trans: "20:05",
          money: 267.8));
      listHistory.list.add(History(
          service_name: 'Viettin Bank',
          service: Service.payment,
          date_trans: '07-23',
          time_trans: "20:05",
          money: 267.8));
      listHistory2.list.add(History(
          service_name: 'Luxury Restaurant',
          service: Service.payment,
          date_trans: '07-25',
          time_trans: "21:05",
          money: 1007.8));
    });
    controller.addListener(() {
      swipeCardSreamControler.sink.add(controller.page);
    });
  }

  @override
  void dispose() {
    swipeCardSreamControler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/bg1.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SafeArea(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.menu,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.notifications,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Wallet",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontFamily: 'Varela',
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => OverView()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: StreamBuilder<double>(
                                    stream: swipeCardSreamControler.stream,
                                    builder: (context, snapshot) {
                                      return PageView.builder(
                                        controller: controller,
                                        itemBuilder: (context, position) {
                                          if (position ==
                                              snapshot.data.floor()) {
                                            return Transform(
                                                transform: Matrix4.identity()
                                                  ..rotateX(
                                                      snapshot.data - position),
                                                child: CreditCard());
                                          } else if (position ==
                                              snapshot.data.floor() + 1) {
                                            return Transform(
                                                transform: Matrix4.identity()
                                                  ..rotateX(
                                                      snapshot.data - position),
                                                child: CreditCard());
                                          } else {
                                            return CreditCard();
                                          }
                                        },
                                        itemCount: 10,
                                      );
                                    }),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.067,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Send Money",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'Varela',
                                          color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Color.fromRGBO(158, 158, 158, 1),
                                    )
                                  ],
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  150 /
                                  896,
                              child: Stack(
                                children: <Widget>[
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      if (index == 0)
                                        return CardAddMoney();
                                      else if (index % 2 == 0 && index != 6)
                                        return CardSendMoney(
                                          user: User(
                                              avartar_assets:
                                                  'assets/images/users/anna.jpeg',
                                              name: "Anna"),
                                        );
                                      else if (index % 3 == 0)
                                        return CardSendMoney(
                                          user: User(
                                              avartar_assets:
                                                  'assets/images/users/gillian.jpeg',
                                              name: "Gillian"),
                                        );
                                      else
                                        return CardSendMoney(
                                          user: User(
                                              avartar_assets:
                                                  'assets/images/users/judith.jpeg',
                                              name: "Judith"),
                                        );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 0, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "All",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Varela',
                                            color: Colors.black),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Receive",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              fontFamily: 'Varela',
                                              color: inactiveColor),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Send",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              fontFamily: 'Varela',
                                              color: inactiveColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: inactiveColor,
                                  )
                                ],
                              ),
                            ),
                            HistoryCard(
                              date: "23 July 2019",
                              listHistor: listHistory,
                            ),
                            HistoryCard(
                              date: "23 July 2018",
                              listHistor: listHistory2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.98),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                height: 40,
                width: 80,
                color: Color.fromRGBO(230, 36, 101, 1),
                child: Center(
                  child: Text(
                    "VISA",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Card no.",
                    style: TextStyle(
                        color: Color.fromRGBO(158, 158, 158, 1),
                        fontSize: 14,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "****  ****  ****  9988",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Expires",
                          style: TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1),
                              fontSize: 16,
                              fontFamily: 'Varela',
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "06/23",
                            style: TextStyle(
                                color: Color.fromRGBO(127, 127, 127, 1),
                                fontSize: 20,
                                fontFamily: 'Varela',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Container(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Color.fromRGBO(127, 127, 127, 1),
                    ),
                    Text(
                      "Swipe",
                      style: TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                          fontSize: 14,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color.fromRGBO(127, 127, 127, 1),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
