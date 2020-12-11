import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial/screens/HomePage.dart';

import '../Drawer.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            backgroundColor: Color(0xfff7951d),
          ),
          body: Center(child: HomeScreen())),
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final fullname = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();

  Map<int, File> imageFileMap = {};
  File imageFile;

  File _image;
  @override
  void initState() {
    super.initState();
  }

  void open_camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void open_gallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  /// Crop Image
  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      _image = croppedImage;
      setState(() {});
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(
                fullnameHolder: fullname.text,
                usernameHolder: username.text,
                emailHolder: email.text,
                numberHolder: phoneNumber.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 15.0),
            /*decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
              /*image: DecorationImage(
                  image: AssetImage("assets/usericon.jpg"),
                  fit: BoxFit.fitHeight), */
            ),*/

            child: new Stack(children: <Widget>[
              _image == null
                  ? new Text('No image selected.')
                  : new CircleAvatar(
                      backgroundImage: new FileImage(_image),
                      radius: 50.0,
                    ),
              new Positioned(
                right: -13.0,
                bottom: 0.0,
                child: new IconButton(
                  onPressed: () {
                    //open_camera();
                    open_gallery();
                  },
                  icon: Icon(Icons.camera_alt),
                  color: Color(0xfff7951d),
                  iconSize: 25,
                ),
              ),
            ]),
            width: 310,
            height: 110,
            //color: Colors.orange,
          ),
          Container(
            width: 280,
            padding:
                EdgeInsets.only(top: 20.0, bottom: 13, left: 15, right: 15),
            child: TextFormField(
              validator: validateName,
              onSaved: (String val) {
                var name = val;
              },
              controller: fullname,
              autocorrect: true,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                labelText: 'Full name',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Container(
              width: 280,
              padding: EdgeInsets.all(13.0),
              child: TextFormField(
                controller: username,
                autocorrect: true,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  //hintText: 'Email',
                  //helperText: 'Keep it short, this is just a demo.',
                  labelText: 'User name',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                ),
              )),
          Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: email,
              autocorrect: true,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                //hintText: 'Email',
                //helperText: 'Keep it short, this is just a demo.',
                labelText: 'Email',
                prefixIcon: const Icon(
                  Icons.mail,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Container(
              width: 280,
              padding: EdgeInsets.all(13.0),
              child: TextFormField(
                controller: phoneNumber,
                autocorrect: true,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  labelText: 'Phone',
                  hintText: 'Phone',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black54,
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
            child: ButtonTheme(
              minWidth: 300,
              height: 55,
              child: RaisedButton(
                onPressed: () => getItemAndNavigate(context),
                color: Color(0xfff7951d),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Colors.white,
                child: Text('Save'),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (value.length < 3) {
      return "Name must be at least 3 letters";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
}

class SecondScreen extends StatefulWidget {
  final fullnameHolder;
  final usernameHolder;
  final emailHolder;
  final numberHolder;

  SecondScreen(
      {Key key,
      @required this.fullnameHolder,
      this.usernameHolder,
      this.emailHolder,
      this.numberHolder})
      : super(key: key);
  SecondScreenState createState() => SecondScreenState(this.fullnameHolder,
      this.usernameHolder, this.emailHolder, this.numberHolder);
}

class SecondScreenState extends State<SecondScreen> {
  final fullnameHolder;
  final usernameHolder;
  final emailHolder;
  final numberHolder;

  Future<File> imageFile;
  File imageFileReturn;

  SecondScreenState(this.fullnameHolder, this.usernameHolder, this.emailHolder,
      this.numberHolder);

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        imageFileReturn = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 400,
            height: 400,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  /*SecondScreen1(
      {Key key,
      @required this.fullnameHolder,
      this.usernameHolder,
      this.emailHolder,
      this.numberHolder})
      : super(key: key); */

  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Color(0xfff7951d),
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        body: Center(
          child: ListView(children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                  child: Container(
                    alignment: Alignment.center,
                    //padding: EdgeInsets.only(top: 25.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                      image: DecorationImage(
                          image: AssetImage("assets/avatar.jpg"),
                          fit: BoxFit.fitHeight),
                    ),
                    width: 310,
                    height: 110,
                    //color: Colors.orange,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    'Full name: ' + fullnameHolder,
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    'User name: ' + usernameHolder,
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
              child: Row(children: <Widget>[
                Text(
                  'Email: ' + emailHolder,
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    'Tel: ' + numberHolder,
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, left: 90, right: 90),
                child: ButtonTheme(
                  minWidth: 20,
                  height: 50,
                  child: RaisedButton.icon(
                    onPressed: () => goBack(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    //splashColor: Colors.red,
                    color: Color(0xfff7951d),
                  ),
                ))
          ]),
          //mainAxisAlignment: MainAxisAlignment.center,
        ));
  }
}
