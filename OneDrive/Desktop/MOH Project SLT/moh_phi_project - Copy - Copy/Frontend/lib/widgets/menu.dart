// lib/widgets/custom_drawer.dart

import 'package:flutter/material.dart';
import 'package:moh_phi_project/screens/authentication/login.dart';
import 'package:moh_phi_project/screens/phi_dashboard.dart';
import 'package:moh_phi_project/screens/mo_dashboard.dart';
import 'package:moh_phi_project/screens/profile.dart';

class Menu extends StatelessWidget {
  final String username;  // Accept username as a parameter
  final String email;     // Accept email as a parameter

  // Constructor to receive the username and email
  Menu({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                username,  // Display the dynamic username
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            accountEmail: Text(email),  // Display the dynamic email
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("lib/assets/images/user.png"),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhiDashboard()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoDashboard()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text('Policies'),
            onTap: () {
              // Handle policies tap
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              // Handle logout tap
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Exit'),
            onTap: () {
              // Handle exit tap
            },
          ),
        ],
      ),
    );
  }
}
