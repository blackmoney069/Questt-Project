// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import "package:geolocator/geolocator.dart";

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
      home: LocationApp(),
    );
  }
}

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  State<LocationApp> createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPostion = await Geolocator().getLastKnownPosition();
    print(lastPostion);

    setState(() {
      locationMessage = "$position.latitude , $position.longitude";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month),
              SizedBox(width: 5,),
              Text("Daily Summary")
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Get user Location',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  getCurrentLocation();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.green[300],
                  child: Text(
                    'Get Current Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.cloud,
                    ),
                    highlightColor: Colors.blue,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.location_pin)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.newspaper)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ],
              ),
            ),
          ),
        ));
  }
}
