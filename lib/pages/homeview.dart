import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:incident_reporter_app/pages/fire_out_break.dart';
import 'package:incident_reporter_app/pages/incident_list_page.dart';
import 'package:incident_reporter_app/pages/map_view.dart';
import 'package:incident_reporter_app/pages/power_alert.dart';
import 'package:incident_reporter_app/widgets/directions_repository.dart';
import 'package:incident_reporter_app/widgets/constants.dart';
import '../widgets/directions_model.dart';
import 'water_damage_screen.dart';

class Home_View extends StatefulWidget {
  const Home_View({Key? key}) : super(key: key);

  @override
  State<Home_View> createState() => _Home_ViewState();
}

class _Home_ViewState extends State<Home_View>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int bottomTab = 0;

  var key;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showAlert(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            width: _width * 0.663,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 0.9)),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              onTap: (newIndex) {
                print(newIndex);
                setState(() {
                  currentIndex = newIndex;
                });
              },
              unselectedLabelStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins-Regular',
              ),
              labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontFamily: 'Poppins-Regular'),
              isScrollable: true,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Container(
                  width: _width * 0.28,
                  child: Tab(
                    text: "Map",
                  ),
                ),
                Container(
                  width: _width * 0.28,
                  child: Center(
                    child: Tab(
                      text: "List",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: _height,
        child: TabBarView(
          children: [
            MapView(),
            Incident_List_Page(
              body: GlobalVar.fireIncidentController.text,
              name: GlobalVar.nameController.text,
              date: GlobalVar.dateController.text,
              time: GlobalVar.timeController.text,
            ),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlert(context);
        },
        child: Icon(
          Icons.add,
          size: 18,
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: _height * 0.52,
                width: _width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "What are you reporting?",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 25,
                        )
                      ],
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Fire_Outbreak_Screen()));
                      },
                      leading: Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.deepOrangeAccent,
                      ),
                      title: Text(
                        "Fire Outbreak",
                        style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      thickness: 0.3,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Water_Damage_Page()));
                      },
                      leading: Icon(
                        Icons.water_drop_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Water damage",
                        style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Power_Alert_Page()));
                      },
                      leading: Icon(
                        Icons.car_crash_outlined,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Accident",
                        style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person_off_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      title: Text(
                        "Domestic Violence",
                        style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.anchor,
                        color: Colors.greenAccent,
                      ),
                      title: Text(
                        "Theft",
                        style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Show All  Incident Types",
                      style: TextStyle(
                        fontFamily: "Poppins-Regular",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Report an inncident here\n on the get go",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Poppins-Regular",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
