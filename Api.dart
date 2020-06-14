import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  final int updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int todayRecovered;
  final int active;

  API(
      {this.active,
      this.cases,
      this.deaths,
      this.todayCases,
      this.todayDeaths,
      this.todayRecovered,
      this.updated});

  factory API.fromJson(Map<String, dynamic> json) {
    return API(
      updated: json['updated'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
    );
  }
}

Future<API> fetchApi() async {
  final response = await http.get('https://disease.sh/v2/all');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return API.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HttpfetchAPI extends StatefulWidget {
  @override
  _HttpfetchAPIState createState() => _HttpfetchAPIState();
}

class _HttpfetchAPIState extends State<HttpfetchAPI> {
  Future<API> futureAPI;

  @override
  void initState() {
    super.initState();
    futureAPI = fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<API>(
          future: futureAPI,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Active cases'),
                          SizedBox(width: 10.0),
                          Text(snapshot.data.active.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total cases'),
                          SizedBox(width: 10.0),
                          Text(snapshot.data.todayCases.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Deaths'),
                          SizedBox(width: 10.0),
                          Text(snapshot.data.todayDeaths.toString())
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) return Text("${snapshot.error}");
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
