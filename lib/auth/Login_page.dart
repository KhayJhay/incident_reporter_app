import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:incident_reporter_app/auth/sign_up_page.dart';
import 'package:incident_reporter_app/auth/user_auth.dart';

import '../widgets/authWedget.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final keyForm = GlobalKey<FormState>();

  bool isSignupScreen = true;
  bool isRememberme = false;
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final mobileController = TextEditingController();

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 152, 224),
      body: Stack(
        children: [
          Positioned(
            child: ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                  padding: EdgeInsets.only(left: 20),
                  height: _height / 2.1,
                  width: _width,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset('assets/images/logo.png'),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 460, left: 30, right: 30),
            child: buildLoginSection(),
          ),
        ],
      ),
    );
  }

  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: keyForm,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField(
                  emailController, CupertinoIcons.mail, "Email", false, true),
              buildTextField(passController, CupertinoIcons.lock_circle,
                  "Enter Password", true, false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: isRememberme,
                          onChanged: (value) {
                            setState(() {
                              isRememberme = !isRememberme;
                            });
                          }),
                      Text(
                        "Remember me",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: (() {
                  Auth().loginAuth(context, keyForm, emailController.text,
                      passController.text);
                  Timer(Duration(seconds: 2), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                }),
                child: Container(
                  height: 58,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: isLoading
                        ? SpinKitDoubleBounce(
                            color: Colors.white,
                          )
                        : Text(
                            'LOGIN',
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 18,
                              letterSpacing: 3,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(
                      thickness: 2.5,
                      color: Colors.white,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontFamily: 'Poppins-Light',
                        fontSize: 18,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      thickness: 0.3,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sign_Up_Page()));
                }),
                child: Container(
                  height: 58,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 18,
                        letterSpacing: 3,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
