import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:incident_reporter_app/models/floodReport_model.dart';
import 'package:incident_reporter_app/models/powerReport.dart';

import '../models/fireReport_model.dart';

class Incident_List_Page extends StatelessWidget {
  String? name, date, time, body;
  Incident_List_Page({
    Key? key,
    this.name,
    this.date,
    this.time,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    Stream<List<Report>> readReport() => FirebaseFirestore.instance
        .collection('fireReport')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Report.fromJson(doc.data())).toList());
    Stream<List<Floodreport>> readfloodReport() => FirebaseFirestore.instance
        .collection('floodReport')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Floodreport.fromJson(doc.data()))
            .toList());
    Stream<List<PowerAlertreport>> readpowerReport() =>
        FirebaseFirestore.instance.collection('powerReport').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => PowerAlertreport.fromJson(doc.data()))
                .toList());
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Search")
                  ],
                ),
                Text(
                  "Filtered by most recent ",
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          StreamBuilder<List<Report>>(
              stream: readReport(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final reports = snapshot.data!;
                  return SizedBox(
                      height: 320,
                      child: ListView(
                          children: reports.map(buildReports).toList()));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<List<Floodreport>>(
              stream: readfloodReport(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final reports = snapshot.data!;
                  return SizedBox(
                      height: 320,
                      child: ListView(
                          children: reports.map(buildfloodReports).toList()));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<List<PowerAlertreport>>(
              stream: readpowerReport(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final reports = snapshot.data!;
                  return SizedBox(
                      height: 350,
                      child: ListView(
                          children: reports.map(buildpowerReports).toList()));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          /*
          Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_fire_department_rounded,
                              color: Colors.deepOrangeAccent,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "FIRE OUTBREAK ",
                              style: TextStyle(
                                fontFamily: "Poppins-SemiBold",
                                color: Colors.deepOrangeAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$body",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Created by  $name " +
                                  "*" +
                                  " $date " +
                                  "*" +
                                  " $time",
                              style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "WATER DAMAGE ",
                              style: TextStyle(
                                fontFamily: "Poppins-SemiBold",
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$body",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Created by  $name " +
                                  "*" +
                                  " $date " +
                                  "*" +
                                  " $time",
                              style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.electric_bolt,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "POWER CUT ",
                              style: TextStyle(
                                fontFamily: "Poppins-SemiBold",
                                color: Color.fromARGB(255, 223, 205, 40),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$body",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Created by  $name " +
                                  "*" +
                                  " $date " +
                                  "*" +
                                  " $time",
                              style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.anchor,
                              color: Colors.greenAccent,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "THEFT ",
                              style: TextStyle(
                                fontFamily: "Poppins-SemiBold",
                                color: Colors.greenAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$body",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Created by  $name " +
                                  "*" +
                                  " $date " +
                                  "*" +
                                  " $time",
                              style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.personal_injury,
                              color: Colors.deepPurple,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "DOMESTIC VIOLENCE ",
                              style: TextStyle(
                                fontFamily: "Poppins-SemiBold",
                                color: Colors.deepPurple,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$body",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Created by  $name " +
                                  "*" +
                                  " $date " +
                                  "*" +
                                  " $time",
                              style: TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        */
        ],
      ),
    );
  }

  Widget buildReports(Report report) => Card(
        child: ListTile(
          title: Text(
            "FIRE OUTBREAK ",
            style: TextStyle(
              fontFamily: "Poppins-SemiBold",
              color: Colors.deepOrangeAccent,
              fontSize: 13,
            ),
          ),
          leading: Icon(
            Icons.local_fire_department_rounded,
            color: Colors.deepOrangeAccent,
            size: 48,
          ),
          subtitle: Column(
            children: [
              Text(
                "${report.body}",
                style: TextStyle(
                  fontFamily: "Poppins-Light",
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Created by  ${report.name} " +
                          "*" +
                          "  ${report.date}  " +
                          "*" +
                          "  ${report.time} ",
                      style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  Widget buildfloodReports(Floodreport report) => Card(
        child: ListTile(
          title: Text(
            "WATER DAMAGE / FLOODS",
            style: TextStyle(
              fontFamily: "Poppins-SemiBold",
              color: Colors.blue,
              fontSize: 13,
            ),
          ),
          leading: Icon(
            Icons.water_drop,
            color: Colors.blue,
            size: 48,
          ),
          subtitle: Column(
            children: [
              Text(
                "${report.body}",
                style: TextStyle(
                  fontFamily: "Poppins-Light",
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Created by  ${report.name} " +
                          "*" +
                          "  ${report.date}  " +
                          "*" +
                          "  ${report.time} ",
                      style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  Widget buildpowerReports(PowerAlertreport report) => Card(
        child: ListTile(
          title: Text(
            "CAR ACCIDENT",
            style: TextStyle(
              fontFamily: "Poppins-SemiBold",
              color: Colors.red,
              fontSize: 13,
            ),
          ),
          leading: Icon(
            Icons.car_crash,
            color: Colors.red,
            size: 48,
          ),
          subtitle: Column(
            children: [
              Text(
                "${report.body}",
                style: TextStyle(
                  fontFamily: "Poppins-Light",
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Created by  ${report.name} " +
                          "*" +
                          "  ${report.date}  " +
                          "*" +
                          "  ${report.time} ",
                      style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  /*
  Card(
        child: Container(
          padding: EdgeInsets.all(12),
          height: 120,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.deepOrangeAccent,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "FIRE OUTBREAK ",
                      style: TextStyle(
                        fontFamily: "Poppins-SemiBold",
                        color: Colors.deepOrangeAccent,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "$body",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Created by  ${report.name}" +
                          "*" +
                          " ${report.date} " +
                          "*" +
                          " ${report.time}",
                      style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
*/
}
