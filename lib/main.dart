import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double latitude = 0.0;
  double longitude = 0.0;

  void _getCurrentLocation() async {
    Location location = Location();
    bool isServiceEnabled = false;
    PermissionStatus isPermissionGranted = PermissionStatus.denied;
    isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      // request permission
      isServiceEnabled = await location.requestService();

      if (!isServiceEnabled) {
        return;
      }
    }

    isPermissionGranted = await location.hasPermission();
    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();
      if (isPermissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // 一一度だ位置情報を取得しに行く
    // await location.getLocation().then((res) {
    //   setState(() {
    // latitude = res.latitude ?? 0;
    // longitude = res.longitude ?? 0;
    //   });
    // });

    // 位置が変化する度に情報を更新する
    location.onLocationChanged.listen((res) {
      setState(() {
        latitude = res.latitude ?? 0;
        longitude = res.longitude ?? 0;
      });
      print('latitude: $latitude, longitude: $longitude');
    });
  }

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
    print("initState() called");
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    sleep(const Duration(seconds: 1));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: 5.0,
            maxZoom: 18.0,
            minZoom: 1.0,
          ),
          layers: [
            // TileLayerOptions(
            //   urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            //   subdomains: ['a', 'b', 'c'],
            // ),
            TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/hk-p/cl6mxxgcj001o15mxvjxr2gs9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGstcCIsImEiOiJjbDYwNTV5ejUxNzlwM2RxaDY5Zm0xMXBoIn0.eig0zZUYx91cfE9reSSlIA',
                additionalOptions: {
                  'accessToken':
                      'sk.eyJ1IjoiaGstcCIsImEiOiJjbDZwcndxaGwwazZ3M2N0NWlsN3M2cmtjIn0._hGqYOO9j9JcvRQn6gg-1w',
                  'id': 'mapbox.mapbox-streets-v8',
                }),

            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude, longitude),
                  builder: (ctx) => Container(
                    // Location marker
                    child: Column(
                      children: const [
                        Text("YOU",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              backgroundColor: Colors.black,
                            )),
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
