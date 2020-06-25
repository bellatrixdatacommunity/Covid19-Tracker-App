
import 'package:bordered_text/bordered_text.dart';
import 'package:covid_tracker/daily_cases.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyHomePage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => DailyCases(),
    },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      

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
  Future<API> _futureAPI;

  @override
  void initState() {
    super.initState();
    _futureAPI = fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMd().add_jm().format(now);

    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFE0E0E0),
          image: DecorationImage(
              image: AssetImage("Assets/personb.png"), //background image
              alignment: Alignment.topLeft)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                // refresh button
                onPressed: () {
                  setState(() {
                    _futureAPI = fetchApi();
                  });
                }, // set state to fetch data from API
                icon: Icon(
                  Icons.refresh,
                  color: Color(0xFF526EFA),
                  size: 35,
                )),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: FutureBuilder<API>(
              future: _futureAPI,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.9,
                            height: height * 0.15,
                            child: Column(
                              // contains date and other data on top right
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  formattedDate, // to display system date
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF526EFA)),
                                ),
                                BorderedText(
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                  child: Text(
                                    "Corona Virus Cases",
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFF526EFA)),
                                  ),
                                ),
                                BorderedText(
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                  child: Text(
                                    snapshot.data.cases.toString(),
                                    style: TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF526EFA),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            // for first two cards
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                // Death Card
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.all(14),
                                    width: width * 0.4,
                                    height: height * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          "DEATHS",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.4,
                                          child: Text(
                                            snapshot.data.deaths.toString(),
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Icon(Icons.mood_bad, color: Colors.red)
                                      ],
                                    )),
                              ),
                              Card(
                                // recovered card
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.all(14),
                                    width: width * 0.4,
                                    height: height * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          "RECOVERED",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.4,
                                          child: Text(
                                            snapshot.data.recovered
                                                .toString(), // recovered cases number
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Icon(Icons.mood, color: Colors.green)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Card(
                            // active cases card
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.only(top: 12, bottom: 9),
                                width: width * 0.84,
                                height: height * 0.16,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: width * 0.35,
                                          child: Text(
                                            "ACTIVE CASES",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.35,
                                          child: Text(
                                              snapshot.data.active
                                                  .toString(), // number of active cases
                                              style: TextStyle(fontSize: 30)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_downward,
                                              color: Colors.green,
                                            ),
                                            Column(
                                              // mild condition
                                              children: <Widget>[
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                      "95%", // mild condition percentage
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                ),
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                    "Mild Condition",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          // critical cases
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                      "5%", //critical cases percentage
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                ),
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                    "Critical",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            //closed cases card
                            color: Colors.white,
                            child: Container(
                                padding: EdgeInsets.only(top: 12, bottom: 9),
                                width: width * 0.84,
                                height: height * 0.16,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: width * 0.35,
                                          child: Text(
                                            "CLOSED CASES",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.35,
                                          child: Text(
                                              NumberFormat.compact()
                                                  .format((snapshot
                                                          .data.updated -
                                                      (snapshot.data.deaths +
                                                          snapshot
                                                              .data.recovered)))
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      30)), //number of closed cases
                                        ),
                                      ],
                                    ),
                                    Column(
                                      //recovered cases
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_downward,
                                              color: Colors.green,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                      "88%", //percentage of recovered cases
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                ),
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                    "Recovered",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          // deaths
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                      "12%", // percentage death
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                ),
                                                SizedBox(
                                                  width: width * 0.35,
                                                  child: Text(
                                                    "Deaths",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) return Text("${snapshot.error}");
                return CircularProgressIndicator();
              }),
        ),
        floatingActionButton: Container(
            height: 40,
            width: 180,
            child: FloatingActionButton.extended(
              //button to move to daily cases page
              onPressed: () {
               Navigator.pushNamed(context, '/second');
              },
              label: BorderedText(
                  strokeWidth: 2,
                  strokeColor: Color(0XFF707070),
                  child: Text(
                    "DAILY CASES",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: -1,
                    ),
                  )),
              backgroundColor: Color(0XFF526EFA),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Color(0XFF707070), width: 0.9)),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
