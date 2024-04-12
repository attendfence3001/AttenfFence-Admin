import 'dart:async';
import 'package:attedence_admin_panel/models/preference_manager.dart';
import 'package:attedence_admin_panel/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:attedence_admin_panel/constants/colors.dart';
import 'package:attedence_admin_panel/services/authentication.dart';
import 'package:attedence_admin_panel/ui/login.dart';

import 'admin_homepage.dart';
import 'login_admin.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class SplashScreenWidget extends StatefulWidget {
  SplashScreenWidget({this.auth});

  final BaseAuth? auth;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  sharedPreInit() async {
    return await UserPreferences().init();
  }

  void initState() {
    super.initState();
    sharedPreInit();
    Timer(Duration(seconds: 3), () {
      widget.auth?.getCurrentUser().then((user) async {
        if (await widget.auth?.getCurrentUser() != null) {
          setState(() {
            if (user != null) {
              _userId = user.uid;
            }
            authStatus = user.uid == null
                ? AuthStatus.NOT_LOGGED_IN
                : AuthStatus.LOGGED_IN;

            MaterialPageRoute loginRoute = MaterialPageRoute(
                builder: (BuildContext context) => AdminLoginScreen());
            MaterialPageRoute homePageRoute = MaterialPageRoute(
                builder: (BuildContext context) => HomePage());

            if (authStatus == AuthStatus.LOGGED_IN) {
              Navigator.pushReplacement(context, homePageRoute);
            } else {
              if (authStatus == AuthStatus.NOT_LOGGED_IN)
                Navigator.pushReplacement(context, loginRoute);
            }
          });
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AdminLoginScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [splashScreenColorBottom, splashScreenColorTop],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/logo/logo-white.png",
              height: 150,
            ),
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
