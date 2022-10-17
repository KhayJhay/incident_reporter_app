import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:incident_reporter_app/models/powerReport.dart';

class Power_Alert_Page extends StatelessWidget {
  const Power_Alert_Page({super.key});

  @override
  Widget build(BuildContext context) {
    bool _istrue = false;
    double _width = MediaQuery.of(context).size.width;
    final fireIncidentController = TextEditingController();
    final nameController = TextEditingController();
    final dateController = TextEditingController();
    final timeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Power Alert",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explain what happened *",
                    style: TextStyle(fontFamily: 'Poppins-SemiBold'),
                  ),
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    height: 80,
                    child: TextFormField(
                      controller: fireIncidentController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Name *",
                        style: TextStyle(fontFamily: 'Poppins-SemiBold'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            height: 40,
                            width: 100,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Date *",
                        style: TextStyle(fontFamily: 'Poppins-SemiBold'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            height: 40,
                            width: 100,
                            child: TextFormField(
                              controller: dateController,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Time*",
                        style: TextStyle(fontFamily: 'Poppins-SemiBold'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            height: 40,
                            width: 100,
                            child: TextFormField(
                              controller: timeController,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Did you see it happen",
                    style: TextStyle(fontFamily: 'Poppins-SemiBold'),
                  ),
                  Switch.adaptive(
                      value: _istrue,
                      onChanged: ((value) {
                        _istrue = !_istrue;
                      }))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular', fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.image_rounded,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular', fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.video_camera_front,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Video",
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular', fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Audio",
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular', fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 200,
                width: _width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage("assets/images/fire.jpg"))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                  width: _width,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        final report = PowerAlertreport(
                            name: nameController.text,
                            body: fireIncidentController.text,
                            date: dateController.text,
                            time: timeController.text);
                        submitpowerReport(report);
                      },
                      child: Text('Submit'))),
            )
          ],
        ),
      ),
    );
  }

  Future submitpowerReport(PowerAlertreport report) async {
    final docReport =
        FirebaseFirestore.instance.collection('powerReport').doc();
    report.id = docReport.id;
    final json = report.toJson();
    await docReport.set(json);
  }

  Future powerReport(
      {required String name,
      required String body,
      required String date,
      required String time}) async {
    final docReport =
        FirebaseFirestore.instance.collection('powerReport').doc();
    final report = PowerAlertreport(
        id: docReport.id, name: name, body: body, date: date, time: time);
    final json = report.toJson();

    await docReport.set(json);
  }
}
