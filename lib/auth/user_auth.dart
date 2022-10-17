import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:incident_reporter_app/models/user_model.dart';
import 'package:incident_reporter_app/pages/homeview.dart';

class Auth {
  UserModel userModel = UserModel();

  //creating account
  void createAccount(
    String username,
    String number,
  ) async {
    userModel.uid = FirebaseAuth.instance.currentUser!.uid;
    userModel.email = FirebaseAuth.instance.currentUser!.email;
    userModel.username = username;
    userModel.number = number;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .set(userModel.toMap());
  }

  //SignUp
  void SignUpAuth(
    BuildContext context,
    GlobalKey<FormState> keyForm,
    String username,
    String email,
    String number,
    String pass,
  ) async {
    if (keyForm.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((uid) {
        createAccount(
          username,
          number,
        );
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Account Created',
          desc: 'Account Successfully Created',
          btnOkOnPress: () {},
        )..show();
      }).catchError((e) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Invalid Authentication',
          desc: '$e',
          btnOkOnPress: () {},
        )..show();
      });
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Invalid Form',
        desc: 'Please enter invalid data into the fields',
        btnOkOnPress: () {},
      )..show();
    }
  }

//loggging In
  loginAuth(BuildContext context, GlobalKey<FormState> keyForm, String email,
      String pass) async {
    if (keyForm.currentState!.validate()) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_View(),
          ),
        ).catchError((e) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Invalid Authentication',
            desc: '$e',
            btnOkOnPress: () {},
          )..show();
        });
      });
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Invalid Form',
        desc: 'Please enter invalid data into the fields',
        btnOkOnPress: () {},
      )..show();
    }
  }
}
