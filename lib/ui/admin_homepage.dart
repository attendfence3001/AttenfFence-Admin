// import 'package:flutter/material.dart';
// // import 'package:your_app/attendance_management.dart'; // Import your attendance management screen
// // import 'package:your_app/leave_management.dart'; // Import your leave management screen
// // import 'package:your_app/employee_management.dart'; // Import your employee management screen
//
// import 'add_employee.dart';
// import 'homepage.dart';
// import 'manage_employee.dart'; // Import your user management screen
//
// class AdminHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   'Homepage',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AddUser()),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   'Add Employees',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
