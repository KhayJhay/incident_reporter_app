import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:incident_reporter_app/pages/incident_list_page.dart';
import 'package:incident_reporter_app/pages/sendEmailpage.dart';
import 'package:incident_reporter_app/widgets/constants.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/fireReport_model.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:incident_reporter_app/models/powerReport.dart';

class Power_Alert_Page extends StatefulWidget {
  const Power_Alert_Page({super.key});

  @override
  State<Power_Alert_Page> createState() => _Power_Alert_PageState();
}

class _Power_Alert_PageState extends State<Power_Alert_Page> {
  bool isCheck = false;
  late File imageFile;

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isCheck = true;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isCheck = true;
      });
    }
  }

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
          "Car Accident",
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
                    TextButton(
                      onPressed: () {
                        _getFromCamera();
                      },
                      child: Container(
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: (() {
                        _getFromGallery();
                      }),
                      child: Container(
                          height: 60,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 16),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: isCheck
                      ? Container(
                          height: 200,
                          width: _width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Lottie.asset(
                          "assets/lotties/noimage.json",
                          height: 250,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                      width: _width,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.QUESTION,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Submit Report or Send Email',
                                desc:
                                    'Will you like to make a report or send email to emergency service directly',
                                btnCancelText: "Send Email",
                                btnCancelColor: Colors.blue,
                                btnCancelOnPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SendEmailpage(
                                          title: "Fire-service Email"),
                                    ),
                                  );
                                },
                                btnOkOnPress: () {
                                  final report = PowerAlertreport(
                                      name: nameController.text,
                                      body: fireIncidentController.text,
                                      date: dateController.text,
                                      time: timeController.text);
                                  submitpowerReport(report);
                                },
                                btnOkText: "Submit Report")
                              ..show();
                          },
                          /*
                             AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Invalid Authentication',
            desc: '$e',
            btnOkOnPress: () {},
          )..show();
                            */
                          child: Text('Submit'))),
                )
              ],
            ),
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
