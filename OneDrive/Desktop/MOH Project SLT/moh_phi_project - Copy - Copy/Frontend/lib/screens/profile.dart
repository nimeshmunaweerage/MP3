// lib/screens/profile.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moh_phi_project/widgets/info_card.dart';
import 'package:moh_phi_project/widgets/menu.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String email = 'None';
  String role = '';
  String location = "None"; // Default location (can be changed as per user data)

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && !JwtDecoder.isExpired(token)) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      setState(() {
        name = decodedToken['username'] ?? 'N/A';
        email = decodedToken['email'] ?? 'None'; // Replace with user email if available
        role = decodedToken['role'] ?? 'Unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 76, 82, 121),
      drawer: Menu(username: name, email: email), // Pass username and email to Menu
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 82, 121),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 80),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/images/user.png'),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans Regular",
              ),
            ),
            Text(
              role,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey[200],
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans Regular",
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            InfoCard(text: name, icon: Icons.person, onPressed: () async {}),
            InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            InfoCard(text: location, icon: Icons.location_city_outlined, onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}
