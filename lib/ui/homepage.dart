import 'package:attedence_admin_panel/animations/loginanimation.dart';
import 'package:attedence_admin_panel/models/preference_manager.dart';
import 'package:attedence_admin_panel/ui/add_employee.dart';
import 'package:attedence_admin_panel/ui/attendance_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attedence_admin_panel/services/authentication.dart';
import 'package:attedence_admin_panel/ui/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth authObj = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox.shrink(),
          title: Padding(
            padding: const EdgeInsets.only(left: 55.0),
            child: new Text(
              "DASHBOARD",
              style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.w200),
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: _logOut)
          ],
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(105, 106, 183, 1),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color.fromRGBO(105, 106, 183, 1),
                  Color.fromRGBO(105, 106, 183, 1)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeAnimation(
                    2,
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddUser()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(255, 171, 64, 1),
                                Color.fromRGBO(255, 171, 64, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "Add Employee",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                AttendanceSummary(title: "Attendance Summary")),
                      );
                    },
                    child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/attendance_summary.png",
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 10),
                            Text("Attendance Summary",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _logOut() async {
    UserPreferences().reset();
    await authObj.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}
