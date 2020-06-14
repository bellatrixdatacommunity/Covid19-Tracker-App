import 'package:bordered_text/bordered_text.dart';
import 'package:covid_tracker/daily_cases.dart';
import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        floatingActionButton: Container(
          height:40,
          width:180,
          child: FloatingActionButton.extended(
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=> DailyCases()
                )
              );
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
              )
            ),
            backgroundColor: Color(0XFF526EFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Color(0XFF707070),
                width:0.9
              )
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}