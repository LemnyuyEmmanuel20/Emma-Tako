import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        color: Color(0xfff7951d),
        child: Padding(
          padding: EdgeInsets.only(top: 50.0, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Lemnyuy Emmanuel",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Software Engineer",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Home"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("My Profile"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () => Navigator.of(context).pushNamed("login"),
        leading: Icon(
          Icons.map,
          color: Colors.black,
        ),
        title: Text("Map"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.chat,
          color: Colors.black,
        ),
        title: Text("chats"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.book,
          color: Colors.black,
        ),
        title: Text("Book a ride"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.local_taxi,
          color: Colors.black,
        ),
        title: Text("Ride history"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.assessment,
          color: Colors.black,
        ),
        title: Text("earnings"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        title: Text("Settings"),
      ),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),

      ListTile(
          onTap: () {},
          leading: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          title: Text("Logout")),
      Divider(
        thickness: 1,
        color: Colors.black12,
      ),
    ]);
  }
}
