import 'package:flutter/material.dart';

import 'add_employee.dart';
import 'admin_homepage.dart';
import 'homepage.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _loginAdmin() async {
    setState(() {
      _errorMessage = ''; // Clear previous error message
    });

    // Check if entered credentials match the fixed admin credentials
    if (_usernameController.text.trim() == '75' &&
        _passwordController.text.trim() == 'password') {
      // Navigate to admin dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid credentials. Please try again.'; // Display error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Admin ID',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginAdmin,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
