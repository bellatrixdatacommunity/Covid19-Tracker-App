import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyCases extends StatefulWidget {
  @override
  _DailyCasesState createState() => _DailyCasesState();
}

class _DailyCasesState extends State<DailyCases> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMd().add_jm().format(now);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, // set state to fetch data from API
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(children: <Widget>[
          Container(
            height: height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF526EFA),
              image: DecorationImage(
                  image: AssetImage("Assets/person.png"),
                  alignment: Alignment.topLeft //background image
                  ),
            ),
            child: Container(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(formattedDate, // to display system date
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  Text(
                    "Daily Cases",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  Text(
                    "50,238",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              height: height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Card(
                  // total deaths card
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.only(top: 12, bottom: 9,left:9),
                    width: width * 0.84,
                    height: height * 0.16,
                    child: Column(children: <Widget>[
                      SizedBox(
                        width:width*0.84,
                        child: Text(
                          "TOTAL DEATHS:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.35,
                            child: Container(
                              padding:EdgeInsets.only(top:4),
                              child: Text("5,112", // number of active cases
                                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Icon(
                            Icons.mood_bad,
                            color: Colors.red,
                            size: 30
                          ),
                        ],
                      ) //row
                    ]),
                  ),
                ),
                Card(
                  // total deaths card
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.only(top: 12, bottom: 9,left:9),
                    width: width * 0.84,
                    height: height * 0.16,
                    child: Column(children: <Widget>[
                      SizedBox(
                        width:width*0.84,
                        child: Text(
                          "TOTAL RECOVERED:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.35,
                            child: Container(
                              padding:EdgeInsets.only(top:4),
                              child: Text("10,112", // number of active cases
                                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Icon(
                            Icons.mood,
                            color: Colors.green,
                            size: 30
                          ),
                        ],
                      ) //row
                    ]),
                  ),
                )
              ]))
        ]));
  }
}
