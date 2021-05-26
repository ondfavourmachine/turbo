import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turbo_car_ride_app/reusables/custom_divider.dart';

class MainScreen extends StatefulWidget {
  static const String mainScreen = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _gMapController = Completer();
  GoogleMapController _googleMapCtrl;
  static final CameraPosition dummyGooglePosition = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: dummyGooglePosition,
              onMapCreated: (GoogleMapController controller) {
                _gMapController.complete(controller);
                _googleMapCtrl = controller;
              },
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: .5,
                            blurRadius: 10,
                            color: Colors.black38,
                            offset: Offset(0.7, 0.7))
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Hey there',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          'Where to?',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Bolt-regular'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: .5,
                                  blurRadius: 5,
                                  color: Colors.black12,
                                  offset: Offset(0.7, 0.7))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.yellowAccent,
                              ),
                              SizedBox(width: 10),
                              Text('Search Drop off')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.home, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Home',
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text('Your living home address',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 12))
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyCustomDivider(),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.work, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Work',
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text('Your office address',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
