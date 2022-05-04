// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import "package:geolocator/geolocator.dart";
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DailySummaryApp(),
    );
  }
}

class DailySummaryApp extends StatefulWidget {
  const DailySummaryApp({Key? key}) : super(key: key);

  @override
  State<DailySummaryApp> createState() => _DailySummaryAppState();
}

class _DailySummaryAppState extends State<DailySummaryApp> {
  var latitude;
  var longitude;
  void initState() {
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
    });
  }

  void getWeatherInfo() async {
    final apiParameters = {
      'lat': "$latitude",
      'lon': "$longitude",
      'appid': '98e8dfcf44ea2319b693eb4c58b2a6018'
    };

    final uri = Uri.http(
        'api.openweathermap.org', '/data/2.5/forecast/daily', apiParameters);
    final response = await http.get(uri);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month),
              SizedBox(
                width: 10,
              ),
              Text("Daily Summary")
            ],
          ),
        ),
        body: Column(
          children: [
            WeatherDescription(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SwipeCards(),
            ),
            SummaryChart(),
            FlatButton(
                onPressed: getWeatherInfo, child: Text("Get Weather Info"),
            )
          ],
        ));
  }
}

class WeatherDescription extends StatelessWidget {
  const WeatherDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Weather Description will go here"),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.cloud,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwipeCards extends StatelessWidget {
  const SwipeCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlatButton(child: SwipeCard(), onPressed: () {}),
        FlatButton(child: SwipeCard(), onPressed: () {}),
        FlatButton(child: SwipeCard(), onPressed: () {}),
        FlatButton(child: SwipeCard(), onPressed: () {}),
      ],
    );
  }
}

class SwipeCard extends StatelessWidget {
  const SwipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Date XX XX XXXX"),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(
              Icons.cloud,
              size: 80,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "22°C",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ]),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.cloud),
                    SizedBox(
                      width: 10,
                    ),
                    Text("XX%")
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.cloud),
                    SizedBox(
                      width: 10,
                    ),
                    Text("XX%")
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.fast_rewind),
                    SizedBox(
                      width: 10,
                    ),
                    Text("XX%")
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.cloud),
                    SizedBox(
                      width: 10,
                    ),
                    Text("XX%")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryChart extends StatelessWidget {
  const SummaryChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        color: Colors.green,
      ),
    );
  }
}

class TempData {
  String temp;
  String date;

  TempData(this.temp, this.date);
}
