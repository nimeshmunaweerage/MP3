import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(  // Wrap the entire body with SingleChildScrollView
        child: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add image here
              Image.asset(
                'lib/assets/images/aboutpage.jpg', // Replace with your image path
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.info, color: Colors.indigo, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "About MOH Sri Lanka",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "This mobile application is designed to assist Public Health Inspectors (PHIs) and Medical Officers (MOs) of Health in Sri Lanka. "
                "Our aim is to streamline workflows, improve communication, and enable quick access to essential data, empowering healthcare professionals to serve the community effectively.",
                style: TextStyle(fontSize: 16, height: 1.4, color: Colors.black87),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.indigo, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "Key Features",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.indigo),
                    title: Text("Access PHI and MO dashboards"),
                  ),
                  ListTile(
                    leading: Icon(Icons.folder, color: Colors.indigo),
                    title: Text("Manage patient records"),
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart, color: Colors.indigo),
                    title: Text("View statistical charts"),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.indigo),
                    title: Text("Quick settings and preferences"),
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.indigo),
                    title: Text("Comprehensive 'About' section for user guidance"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
