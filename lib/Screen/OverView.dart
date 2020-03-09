import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:page_view/widgets/HistoryCard.dart';
import 'package:page_view/widgets/WaveProgress.dart';

class OverView extends StatefulWidget {
  OverView({Key key}) : super(key: key);
  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  //Key
  GlobalKey pieChartKey = GlobalKey();
  //Key
  Color inactiveColor = Color.fromRGBO(158, 158, 158, 1);
  StreamController<PieTouchResponse> pieTouchedResultStreamController;

  int touchedIndex;
  @override
  void initState() {
    super.initState();

    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      if (details == null) {
        return;
      }

      setState(() {
        if (details.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
        } else {
          touchedIndex = details.touchedSectionPosition;
        }
      });
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color.fromRGBO(64, 84, 178, 1),
            value: 40,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontFamily: 'Varela',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Color.fromRGBO(254, 233, 78, 1),
            value: 30,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Varela',
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Color.fromRGBO(252, 68, 130, 1),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontFamily: 'Varela',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Color.fromRGBO(111, 239, 176, 1),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontFamily: 'Varela',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Overview",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            fontFamily: 'Varela',
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Varela',
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Accounts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Varela',
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            blurRadius: 7,
                            color:
                                Color.fromRGBO(34, 97, 251, 1).withOpacity(0.1),
                            offset: new Offset(5.0, 15.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(34, 97, 251, 1),
                      ),
                      width: (width - 60) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Text(
                              "Cash",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Varela',
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 40),
                            child: Text(
                              "\$ 35.18",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  fontFamily: 'Varela',
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 66, 97, 1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          new BoxShadow(
                            blurRadius: 5,
                            color:
                                Color.fromRGBO(252, 66, 97, 1).withOpacity(0.1),
                            offset: new Offset(5.0, 15.0),
                          )
                        ],
                      ),
                      width: (width - 60) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Text(
                              "Credit Debt",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Varela',
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 40),
                            child: Text(
                              "\$ 275.37",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  fontFamily: 'Varela',
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Spending ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'Varela',
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "July 2018 ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Varela',
                              color: inactiveColor),
                        ),
                      ),
                    ],
                  )),
              AspectRatio(
                aspectRatio: 2,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: AspectRatio(
                          key: pieChartKey,
                          aspectRatio: 1,
                          child: Container(
                            child: FlChart(
                              chart: PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(
                                        touchResponseStreamSink:
                                            pieTouchedResultStreamController
                                                .sink),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 1,
                                    startDegreeOffset: 0,
                                    centerSpaceRadius: 15,
                                    sections: showingSections()),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Indicator(
                                color: Color.fromRGBO(64, 84, 178, 1),
                                text: 'Home',
                                isSquare: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Indicator(
                                color: Color.fromRGBO(254, 233, 78, 1),
                                text: 'Food & Drink',
                                isSquare: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Indicator(
                                color: Color.fromRGBO(111, 239, 176, 1),
                                text: 'Hotel & Restaurant',
                                isSquare: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Indicator(
                                color: Color.fromRGBO(252, 68, 130, 1),
                                text: 'Travelling',
                                isSquare: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Budgets ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: 'Varela',
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "July ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Varela',
                            color: inactiveColor),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: AspectRatio(
                  aspectRatio: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Stack(children: <Widget>[
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(224, 224, 224, 1),
                                borderRadius: BorderRadius.circular(20)),
                            height: height * 0.025,
                          ),
                        ),
                        Center(
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(34, 89, 251, 1),
                                      Color.fromRGBO(199, 150, 255, 1)
                                    ]),
                                    color: Color.fromRGBO(249, 69, 100, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                height: height * 0.025,
                                width: (width - 80) * 0.8,
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Center(
                            child: Text(
                              "80%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Varela',
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Cash Flow",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Varela',
                      color: Colors.black),
                ),
              ),
              AspectRatio(
                aspectRatio: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Center(
                                child: WaveProgress(80, Colors.transparent,
                                    Color.fromRGBO(114, 113, 251, 1), 60)),
                            Center(
                              child: Center(
                                child: Text(
                                  "60%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Varela',
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Earned",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Varela',
                                    color: inactiveColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "\$ 200.0",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Varela',
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color.fromRGBO(158, 158, 158, 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
              color: textColor),
        )
      ],
    );
  }
}
