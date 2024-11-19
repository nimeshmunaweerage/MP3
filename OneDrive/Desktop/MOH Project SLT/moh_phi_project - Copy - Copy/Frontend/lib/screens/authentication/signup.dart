import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Ensure this import is correct
import 'dart:convert';
import 'package:moh_phi_project/screens/authentication/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;
  String? selectedRole; // To hold the selected role value

  // List of roles for dropdown
  final List<String> roles = ['PHI', 'Medical Officer'];

  // Method to sign up the user
  Future<void> signUp() async {
    // Check if the form is valid
    if (formKey.currentState!.validate()) {
      // Prepare the data to send
      final usernameValue = username.text;
      final passwordValue = password.text;
      final roleValue = selectedRole;

      // Make the POST request
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/auth/signup'), // Use 10.0.2.2 for Android emulators
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': usernameValue,
          'password': passwordValue,
          'role': roleValue,
        }),
      );

      // Handle the response
      if (response.statusCode == 201) {
        // User created successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User created successfully!')),
        );
        // Optionally navigate to login or home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Handle error
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['message'])),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ListTile(
                      title: Text(
                        "Register New Account",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Username Field
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: "Username",
                        ),
                      ),
                    ),

                    // Role Dropdown
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedRole,
                        hint: const Text("Select Role"),
                        icon: const Icon(Icons.arrow_drop_down),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person_outline),
                        ),
                        items: roles
                            .map((role) => DropdownMenuItem<String>(
                                  value: role,
                                  child: Text(role),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select a role";
                          }
                          return null;
                        },
                      ),
                    ),

                    // Password Field
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),

                    // Confirm Password Field
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          } else if (password.text != confirmPassword.text) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Sign up Button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple,
                      ),
                      child: TextButton(
                        onPressed: signUp, // Call the signUp method
                        child: const Text("SIGN UP", style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    // Login button and navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            // Navigate to Login
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text("LOGIN"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
