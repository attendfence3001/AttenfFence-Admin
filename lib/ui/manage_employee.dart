import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    getUsersFromDatabase();
  }

  void getUsersFromDatabase() {
    databaseReference.child('users').once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        setState(() {
          users.clear();
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, value) {
            users.add({'uid': key, ...value});
          });
        });
      } else {
        // Handle case when no users are available
        print('No users found in the database.');
      }
    }).catchError((error) {
      // Handle any errors that occur during database access
      print('Error fetching users: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: users.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text(user['email']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${user['name']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${user['email']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Role: ${user['role']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Department: ${user['department']}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}
