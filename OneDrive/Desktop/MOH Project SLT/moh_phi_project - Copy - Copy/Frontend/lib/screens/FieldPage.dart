import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FieldPage extends StatefulWidget {
  final String diseaseId;

  const FieldPage({Key? key, required this.diseaseId}) : super(key: key);

  @override
  _FieldPageState createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  List<Map<String, dynamic>> fields = [];
  int currentIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFields();
  }

  Future<void> fetchFields() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/auth/disease/${widget.diseaseId}/fields'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          fields = (data['fields'] as List).map((field) => {
            'name': field['field_name'],
            'subFields': field['subFields'] ?? []
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load fields');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void goToNextField() {
    if (currentIndex < fields.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Handle end of fields
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('All Fields Completed'),
          content: Text('You have completed all the fields for this disease.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Return to the previous page
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Field ${currentIndex + 1}/${fields.length}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : fields.isEmpty
              ? Center(
                  child: Text(
                    'No fields available for this disease.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        fields[currentIndex]['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Display sub-fields for the current field
                    if (fields[currentIndex]['subFields'].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: fields[currentIndex]['subFields'].map<Widget>((subField) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                subField,
                                style: TextStyle(fontSize: 18, color: Colors.indigo[700]),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        onPressed: goToNextField,
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        label: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
