import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:trial/DriverInfo/Login.dart';
import 'package:trial/DriverInfo/Profile.dart';

// Create a Form widget.
// ignore: must_be_immutable
class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

//void setState(Null Function() param0) {}

// Create a corresponding State class.
// This class holds data related to the form.
class RegistrationFormState extends State<RegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  //final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  String name, email, mobile, password, confirmpassword;
  var user;
  bool tuVal = false;

  //Function to hide and show password
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });

    String phoneNumber;
    String phoneIsoCode;
    bool visible = false;
    String confirmedNumber = '';

    void onPhoneNumberChange(
        String number, String internationalizedPhoneNumber, String isoCode) {
      print(number);
      setState(() {
        phoneNumber = number;
        phoneIsoCode = isoCode;
      });
    }

    onValidPhoneNumber(
        String number, String internationalizedPhoneNumber, String isoCode) {
      setState(() {
        visible = true;
        confirmedNumber = internationalizedPhoneNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      //home: new Scaffold(
      /*appBar: new AppBar(
          title: new Text('Form Validation'),
        ), */
      // body: new SingleChildScrollView(
      child: new ListView(
        // margin: new EdgeInsets.all(15.0),
        children: [
          new Form(
            key: _key,
            // ignore: deprecated_member_use
            autovalidate: _validate,
            child: FormUI(),
          ),
        ],
        //],
      ),
      //),
      //),
    );
  }

  Widget FormUI() {
    // Build a Form widget using the _formKey created above.

    String phoneNumber;
    String phoneIsoCode;
    bool visible = false;
    String confirmedNumber = '';
    var onPhoneNumberChange;

    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ),

        //card for Full name TextFormField
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(bottom: 20.0, top: 20, left: 10, right: 10),
          child: TextFormField(
            //maxLength: 10,
            validator: validateName,
            onSaved: (String val) {
              name = val;
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 25, right: 15),
                  child: Icon(Icons.person, color: Colors.black),
                ),
                contentPadding: EdgeInsets.all(10),
                labelText: "Full name"),
          ),
        ),

        //card for user name TextFormField
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(bottom: 20.0, top: 20, left: 10, right: 10),
          child: TextFormField(
            //maxLength: 10,
            validator: validateName,
            onSaved: (String val) {
              name = val;
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 25, right: 15),
                  child: Icon(Icons.person, color: Colors.black),
                ),
                contentPadding: EdgeInsets.all(10),
                labelText: "user name"),
          ),
        ),

        //card for Email TextFormField
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
              email = val;
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Icon(Icons.email, color: Colors.black),
                ),
                contentPadding: EdgeInsets.all(10),
                labelText: "Email"),
          ),
        ),

        //card for Mobile TextFormField
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
          child: InternationalPhoneInput(
            onPhoneNumberChange: onPhoneNumberChange,
            initialPhoneNumber: phoneNumber,
            initialSelection: phoneIsoCode,
            enabledCountries: [
              '+237',
              '+236',
              '+235',
              '+243',
              '+242',
              '+240',
              '+241',
              '+234',
              '+224',
              '+233',
              '+225'
            ],
            labelText: "Phone Number",
          ),
        ),

        //card for Password TextFormField
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
          child: TextFormField(
            validator: validatePassword,
            onSaved: (String val) {
              password = val;
            },
            obscureText: _secureText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: showHide,
                  icon: Icon(
                      _secureText ? Icons.visibility_off : Icons.visibility),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Icon(Icons.phonelink_lock, color: Colors.black),
                ),
                contentPadding: EdgeInsets.all(10),
                labelText: "Password"),
          ),
        ),

        //card for Confirm Password TextFormField
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
          child: TextFormField(
            validator: validateConfirmPassword,
            onSaved: (String val) {
              confirmpassword = val;
            },
            obscureText: _secureText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: showHide,
                  icon: Icon(
                      _secureText ? Icons.visibility_off : Icons.visibility),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Icon(Icons.phonelink_lock, color: Colors.black),
                ),
                contentPadding: EdgeInsets.all(10),
                labelText: "Confirm password"),
          ),
        ),

        //Checkbox list

        CheckboxListTile(
            title: Text("I agree to terms and conditions "),
            value: tuVal,
            onChanged: (newValue) {
              setState(() {
                tuVal = newValue;
              });
            },
            //code to make checkbox appear before title
            controlAffinity: ListTileControlAffinity.leading),

        //signup button
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          // use buttontheme so as to determine the height and width of a button as u like
          child: ButtonTheme(
            minWidth: 300,
            height: 55,
            // only raised buttons can take border colors
            child: RaisedButton(
              onPressed: _sendToServer,
              color: Color(0xfff7951d),
              shape: new RoundedRectangleBorder(
                  //side:BorderSide(color: Colors.deepOrange, width: 2),
                  borderRadius: BorderRadius.circular(10.0)),
              //onPressed: _sendToServer(),
              child: Text('Register'),
              textColor: Colors.white,

              //color: Colors.deepO
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 25.0),
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Already have an account?  ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: "Log in",
                    style: TextStyle(
                        color: Color(0xfff7951d), fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
        ),
      ],
    );
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

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length < 9) {
      return "Mobile number must be at least 9 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must have at least 8 characters";
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.length == 0) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must have at least 8 characters";
    }
    return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Name $name");
      //print("Mobile $mobile");
      print("Email $email");
      print("Email $password");
      print("Email $confirmpassword");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginForm()),
      );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Profile(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
