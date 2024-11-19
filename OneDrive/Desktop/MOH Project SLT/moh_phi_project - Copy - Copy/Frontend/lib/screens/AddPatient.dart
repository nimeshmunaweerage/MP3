import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'FieldPage.dart'; // Import FieldPage for navigation

class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  String? selectedDisease;
  List<Map<String, dynamic>> diseases = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/auth/diseases'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          diseases = (data['diseases'] as List)
              .map((disease) => {'id': disease['ID'], 'name': disease['Name']})
              .toList();
        });
      } else {
        print('Failed to load diseases');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Patient',
          style: TextStyle(color: Colors.white), // Set the text color of the AppBar to white
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set the arrow color to white
          onPressed: () {
            Navigator.pop(context); // Pop the current screen from the stack
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 80, 106, 250), Color.fromARGB(255, 94, 181, 222)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Disease:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the color of the 'Select Disease' text to white
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : diseases.isEmpty
                      ? Center(
                          child: Text(
                            'No diseases available. Please try again later.',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 113, 189),
                                Color.fromARGB(255, 98, 192, 252),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: selectedDisease,
                            isExpanded: true,
                            hint: Text(
                              'Choose a disease',
                              style: TextStyle(color: Colors.white),
                            ),
                            dropdownColor: Colors.white, // Removed transparent
                            iconEnabledColor: Colors.white,
                            onChanged: (newValue) {
                              setState(() {
                                selectedDisease = newValue;
                              });
                            },
                            items: diseases.map((disease) {
                              return DropdownMenuItem<String>(
                                value: disease['id'].toString(),
                                child: Text(
                                  disease['name'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: selectedDisease != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FieldPage(diseaseId: selectedDisease!),
                          ),
                        );
                      }
                    : null,
                icon: Icon(Icons.arrow_forward, color: Colors.white), // Set the arrow color to white
                label: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 55, 78, 255),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
