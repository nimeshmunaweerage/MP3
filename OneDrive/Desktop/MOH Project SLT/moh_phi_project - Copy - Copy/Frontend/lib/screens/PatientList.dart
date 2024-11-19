import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patient List",
          style: TextStyle(color: Colors.white), // Explicitly set text color to white
        ),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow color to white
      ),
      body: Center(
        child: Text(
          "List of Patients",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

