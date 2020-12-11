import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class DisplayGoogleMap extends StatefulWidget {
  DisplayGoogleMap(
      {Key key, this.destinationAddress, this.destinationCoordinates})
      : super(key: key);

  @override
  _DisplayGoogleMapState createState() => _DisplayGoogleMapState();

  final LatLng destinationCoordinates;
  final String destinationAddress;
}

class _DisplayGoogleMapState extends State<DisplayGoogleMap> {
  @override
  void initState() {
    super.initState();

    widget.destinationCoordinates == null
        ? _initialLocation = LatLng(3.84811, 11.50495)
        : _initialLocation = widget.destinationCoordinates;
    print("true");
    print(_initialLocation);
    // getCurrentLocation().then((value) {
    //       _currentLocation = LatLng(value.latitude, value.longitude);
    //     });

    getCurrentLocation();
    // getAddress();
    // goToDestination();
  }

  GoogleMapController _mapController;

  final Geolocator _geolocator = Geolocator();
  LatLng _initialLocation;
  LatLng _currentLocation;
  LatLng _destinationLocation;
  String _startAddress = '';

  String _placeDistance;
  String _currentAddress;

  Position _myPosition;

// //GETTING CURRENT LOCATION USING LOCATION PACKAGE
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _myPosition = position;
        _currentLocation = LatLng(_myPosition.latitude, _myPosition.longitude);
        print("map test 1");
      });
      getAddress();
    }).catchError((e) {
      print(e);
    });
  }

//   // //GETTING CURRENT LOCATION USING LOCATION PACKAGE

  // LatLng _currentLocation;
  // Location _myLocation = Location();
  // LocationData _myLocationData;
  // bool _serviceEnabled;
  // PermissionStatus _permissionGranted;

  // _DisplayGoogleMapState(){
  //    getCurrentLocation().then((value) {
  //       _currentLocation = LatLng(value.latitude, value.longitude);
  //     });
  // }

  // Future<LocationData> getCurrentLocation() async {
  //   _serviceEnabled = await _myLocation.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await _myLocation.requestService();
  //     if (!_serviceEnabled) {
  //       print("service not enabled");

  //     }
  //     print("service is enabled");
  //   }
  //   print("service is enabled");

  //   _permissionGranted = await _myLocation.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await _myLocation.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       print("permission not granted");

  //     }
  //   }
  //   _myLocationData = await _myLocation.getLocation();
  //   print("lat: $_myLocationData");
  //   return _myLocationData;
  // }

  //GETTING CURRENT LOCATION USING LOCATION PACKAGE

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  getAddress() async {
    try {
      print("dsfgchjgujb mn  hfchgvgfhgvgfhgfh");
      // getCurrentLocation();
      List<Placemark> p = await placemarkFromCoordinates(
          _currentLocation.latitude, _currentLocation.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        print("map test 2");
        print(place.locality);
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // goToDestination(String destination) async {
  //   try {
  //     List<Location> ddLocation;
  //     print("test 1111");
  //     ddLocation = await locationFromAddress(destination);
  //     // String destination2 = _destinationAddressController.text;
  //     // destination2 == '' ? print("empty destination") : print(destination2);
  //     print("welcome");
  //     print(destination);

  //     Location locate = Location();
  //     print("initialiseddd");

  //     ddLocation[0].latitude == null && ddLocation[0].longitude == null
  //         ? print("value is empty")
  //         : print(ddLocation[0]);
  //     locate = ddLocation[0];
  //     print("initialisedddvbnmjhghjhjh");
  //     _destinationLocation = LatLng(locate.latitude, locate.longitude);

  //     print(_destinationLocation);

  //     // GoogleMapController _ddcontroller = _mapController;

  //     // _ddcontroller.animateCamera(CameraUpdate.newCameraPosition(
  //     //     CameraPosition(target: _destinationLocation, zoom: 17)));

  //     _yaounde = _destinationLocation;

  //     print("you hve arrived");

  //     print(locate);

  //     print("you hve arrived finally");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    setState(() {
    });
    print("map test");
    // getAddress();
    print(_startAddress);

    return Container(
      height: height,
      width: width,
      
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              // markers: markers != null ? Set<Marker>.from(markers) : null,
              initialCameraPosition:
                  CameraPosition(target: _initialLocation, zoom: 15),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              // polylines: Set<Polyline>.of(polylines.values),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipOval(
                        child: Material(
                          color: Colors.orange[100], // button color
                          child: InkWell(
                            splashColor: Colors.orange, // inkwell color
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(Icons.my_location),
                            ),
                            onTap: () {
                              _mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: _currentLocation,
                                    zoom: 15.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipOval(
                        child: Material(
                          color: Colors.orange[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ), // button color
                          child: InkWell(
                            splashColor: Colors.orange, // inkwell color
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                            onTap: () {
                              _mapController.animateCamera(
                                CameraUpdate.zoomIn(),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipOval(
                        child: Material(
                          color: Colors.orange[100], // button color
                          child: InkWell(
                            splashColor: Colors.orange, // inkwell color
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(Icons.remove),
                            ),
                            onTap: () {
                              _mapController.animateCamera(
                                CameraUpdate.zoomOut(),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
