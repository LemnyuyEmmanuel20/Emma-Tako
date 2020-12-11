import 'package:flutter/material.dart';
import 'package:trial/components/DisplayGoogleMap.dart';
import 'package:trial/screens/RoutePage.dart';

import '../Drawer.dart';
// import 'package:address_search_field/address_search_field.dart';

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
  DisplayGoogleMap _map = DisplayGoogleMap();
  final destinationAddressController = TextEditingController();
  String textToSend;

  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   destinationAddressController.dispose();
  //   super.dispose();
  // }

  // final GeoMethods geoMethods = GeoMethods(
  //   googleApiKey: 'GOOGLE_API_KEY',
  //   language: 'es-419',
  //   countryCode: 'ec',
  //   country: 'Cameroon',
  //   city: 'Yaounde',
  // );

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Center(
          child: Stack(
        children: <Widget>[
          _map,
          Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  controller: destinationAddressController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          setState(() {});
                          sendDataToRouteScreen(context);
                        },
                        iconSize: 30.0,
                      ),
                      icon: Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                      hintText: "Destination",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, top: 16)),
                  onEditingComplete: () {
                    setState(() {});
                    sendDataToRouteScreen(context);
                  },
                  onChanged: (value) {
                    setState(() {
                      textToSend = value;
                    });
                  },
                ),
              ))
        ],
      )),
    );
  }

  void sendDataToRouteScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoutePage(
            destinationAddress: textToSend,
          ),
        ));
  }
}
