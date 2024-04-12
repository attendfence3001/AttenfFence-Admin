import 'package:attedence_admin_panel/models/AttendaceList.dart';
import 'package:attedence_admin_panel/models/office.dart';
import 'package:firebase_database/firebase_database.dart';

String getDoubleDigit(String value) {
  if (value.length >= 2) return value;
  return "0" + value;
}

String getFormattedDate(DateTime day) {
  String formattedDate = getDoubleDigit(day.day.toString()) +
      "-" +
      getDoubleDigit(day.month.toString()) +
      "-" +
      getDoubleDigit(day.year.toString());
  return formattedDate;
}

String getFormattedTime(DateTime day) {
  String time = getDoubleDigit(day.hour.toString()) +
      ":" +
      getDoubleDigit(day.minute.toString()) +
      ":" +
      getDoubleDigit(day.second.toString());

  return time;
}

class AttendanceDatabase {
  static final _databaseReference = FirebaseDatabase.instance.reference();
  static final AttendanceDatabase _instance = AttendanceDatabase._internal();

  factory AttendanceDatabase() {
    return _instance;
  }

  AttendanceDatabase._internal();

  Future<DataSnapshot?> getAttendanceBasedOnUID(String uid) async {
    DataSnapshot dataSnapshot = await FirebaseDatabase.instance
        .reference()
        .child("Attendance")
        .child(uid)
        .once();
    return dataSnapshot;
  }

  Future<dynamic> getAttendanceOfParticularDateBasedOnUID(
      String uid, DateTime dateTime) async {
    DataSnapshot? snapshot = await getAttendanceBasedOnUID(uid);
    if (snapshot != null) {
      String formattedDate = getFormattedDate(dateTime);
      if (snapshot.value != null && snapshot.value is Map) {
        Map attendanceData = snapshot.value as Map;
        return attendanceData[formattedDate];
      }
    }
    return null;
  }

  Future<Map<String, String>> getOfficeFromID() async {
    DataSnapshot dataSnapshot =
        await _databaseReference.child("location").once();
    Map<String, String> map = {};

    if (dataSnapshot.value != null && dataSnapshot.value is Map) {
      (dataSnapshot.value as Map).forEach((key, value) {
        map[key] = value["name"];
      });
    }

    return map;
  }

  Future<AttendanceList> getAttendanceListOfParticularDateBasedOnUID(
      String uid, DateTime dateTime) async {
    var snapshot = await getAttendanceOfParticularDateBasedOnUID(uid, dateTime);
    var mapOfOffice = await getOfficeFromID();
    AttendanceList attendanceList = AttendanceList.fromJson(
        snapshot, getFormattedDate(dateTime), mapOfOffice);
    attendanceList.dateTime = dateTime;

    return attendanceList;
  }

  static Future markAttendance(
      String uid, DateTime dateTime, Office office, String markType) async {
    String time = getFormattedTime(dateTime);
    String date = getFormattedDate(dateTime);
    var json = {
      "office": office.getKey,
      "time": time,
    };
    String markChild = markType + "-" + time;
    return _databaseReference
        .child("Attendance")
        .child(uid)
        .child(date)
        .child(markChild)
        .update(json);
  }
}
