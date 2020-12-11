import 'package:flutter/material.dart';
//import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trial/requests/NetworkHelper.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key key, this.destinationAddress}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
  final String destinationAddress;
}

class _RoutePageState extends State<RoutePage> {
  //final _closeMemo = AsyncMemoizer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _endAddress = widget.destinationAddress;
    print("Rout test");
    print(_endAddress);
    getJsonData();

    getCurrentLocation();
    navigate();
  }

  GoogleMapController mapController;
// For holding Co-ordinates as LatLng
  List<LatLng> polyPoints = [];

//For holding instance of Polyline
  Set<Polyline> polyLines = {};
// For holding instance of Marker
  Set<Marker> markers = {};
  var data;
  String _startAddress;
  String _endAddress;
  Location _startLocation;
  Location _endLocation;
  LatLng _startCoordinates;
  LatLng _endCoordinates;
  Position _myPosition;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  setMarkers() {
    Marker startMarker = Marker(
      markerId: MarkerId("Home"),
      position: LatLng(_startLocation.latitude, _startLocation.longitude),
      infoWindow: InfoWindow(
        title: "start",
        snippet: "start location",
      ),
    );

    Marker endMarker = Marker(
      markerId: MarkerId("Destination"),
      position: LatLng(_endLocation.latitude, _endLocation.longitude),
      // position: LatLng(endLat, endLng),
      infoWindow: InfoWindow(
        title: "destination",
        snippet: "destination location",
      ),
    );
    setState(() {
      markers.add(startMarker);
      markers.add(endMarker);
    });

    double _northeastLat;
    double _northeastLng;

    double _southwestLat;
    double _southwestLng;

    // Calculating to check that
    // southwest coordinate <= northeast coordinate
    if (_startLocation.latitude <= _endLocation.latitude) {
      _southwestLat = _startLocation.latitude;
      _northeastLat = _endLocation.latitude;
    } else {
      _southwestLat = _endLocation.latitude;
      _northeastLat = _startLocation.latitude;
    }
    if (_startLocation.longitude <= _endLocation.longitude) {
      _southwestLng = _startLocation.longitude;
      _northeastLng = _endLocation.longitude;
    } else {
      _northeastLng = _startLocation.longitude;
      _southwestLng = _endLocation.longitude;
    }

    // Accomodate the two locations within the
    // camera view of the map
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(_southwestLat, _southwestLng),
          northeast: LatLng(_northeastLat, _northeastLng),
        ),
        30.0,
      ),
    );
  }

  getCurrentLocation() async {
    print("Rout test 1: getting current location");
    print(_startCoordinates);
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _myPosition = position;
        _startCoordinates = LatLng(_myPosition.latitude, _myPosition.longitude);
        print(_startCoordinates);
      });
      await getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  getAddress() async {
    try {
      print("Rout test 2: getting address");
      print(_startAddress);
      List<Placemark> p = await placemarkFromCoordinates(
          _startCoordinates.latitude, _startCoordinates.longitude);

      Placemark place = p[0];

      setState(() {
        _startAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        print(_startAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  navigate() async {
    try {
      print("Rout test 3: navigating");
      print(_endAddress);
      print(_endLocation);

      List<Location> endLocations = await locationFromAddress(_endAddress);
      setState(() {
        _endLocation = endLocations[0];
        _endCoordinates =
            LatLng(endLocations[0].latitude, endLocations[0].longitude);

        print("endLocation");
        print(_endLocation);
      });
      await accomodate();
    } catch (e) {
      print(e);
    }
  }

//  WidgetsBinding.instance
//         .addPostFrameCallback((_) => accomodate());

  accomodate() async {
    try {
      print("Rout test 3: navigating");
      print(_startAddress);
      print(_startLocation);

      List<Location> startLocations = await locationFromAddress(_startAddress);

      print("startLocation");
      print(_startLocation);
      print("startLocation");

      setState(() {
        _startLocation = startLocations[0];
        _startCoordinates =
            LatLng(_startLocation.latitude, _startLocation.longitude);
      });

      setMarkers();
      getJsonData();
    } catch (e) {
      print(e);
    }
  }

  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: _startCoordinates.latitude,
      startLng: _startCoordinates.longitude,
      endLat: _endCoordinates.latitude,
      endLng: _endCoordinates.longitude,
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }
      setPolyLines();
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.lightBlue,
      points: polyPoints,
    );

    setState(() {
      polyLines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _endCoordinates,
              zoom: 15,
            ),
            markers: markers,
            polylines: polyLines,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: RaisedButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () {
                  accomodate();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Go'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
