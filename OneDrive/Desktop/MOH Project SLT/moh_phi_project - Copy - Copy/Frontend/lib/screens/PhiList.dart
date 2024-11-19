import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PhiList extends StatefulWidget {
  @override
  _PhiListState createState() => _PhiListState();
}

class _PhiListState extends State<PhiList> {
  List<String> phiUsers = [];
  List<String> filteredPhiUsers = [];
  bool isLoading = true;
  String searchQuery = '';
  String selectedFilter = 'All';

  // Fetch the list of PHI users from the backend
  Future<void> fetchPhiUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No token found. Please log in.')));
      return;
    }

    final response = await http.get(
      Uri.parse('http://localhost:5000/api/auth/philist'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        phiUsers = List<String>.from(data['phiUsers'].map((user) => user['username']));
        filteredPhiUsers = phiUsers; // Set initial filtered list
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      final errorData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'])));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPhiUsers(); // Fetch the users when the screen loads
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredPhiUsers = phiUsers
          .where((user) =>
              user.toLowerCase().contains(searchQuery.toLowerCase()) &&
              (selectedFilter == 'All' || user == selectedFilter)) // Apply search and filter
          .toList();
    });
  }

  void updateSelectedFilter(String? filter) {
    setState(() {
      selectedFilter = filter!;
      filteredPhiUsers = phiUsers
          .where((user) =>
              user.toLowerCase().contains(searchQuery.toLowerCase()) &&
              (selectedFilter == 'All' || user == selectedFilter)) // Apply search and filter
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PHI List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Loading PHI users...',
                      style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: updateSearchQuery,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.indigo),
                      hintText: 'Search by username...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    onChanged: updateSelectedFilter,
                    isExpanded: true,
                    items: ['All', 'Matara', 'Dewinuwara','Hakmana','Kaburugamuwa']
                        .map((filter) => DropdownMenuItem<String>(
                              value: filter,
                              child: Text(filter),
                            ))
                        .toList(),
                    underline: Container(
                      height: 2,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Expanded(
                  child: filteredPhiUsers.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error, color: Colors.red, size: 50),
                                SizedBox(height: 16),
                                Text(
                                  'No PHI found.',
                                  style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredPhiUsers.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.indigo,
                                  child:
                                      Icon(Icons.person, color: Colors.white),
                                ),
                                title: Text(
                                  filteredPhiUsers[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'PHI',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.indigo,
                                ),
                                onTap: () {
                                  // Handle tap (e.g., navigate to a detailed view or patient profile)
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
