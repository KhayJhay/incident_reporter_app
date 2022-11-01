import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';

class SendEmailpage extends StatefulWidget {
  final String title;
  const SendEmailpage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SendEmailpage> createState() => _SendEmailpageState();
}

class _SendEmailpageState extends State<SendEmailpage> {
  bool showPassword = false;
  final nameController = TextEditingController();
  final subectController = TextEditingController();
  final emailController = TextEditingController();
  final bodyController = TextEditingController();

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_g6bextp";
    const templateId = "template_hbjb4mh";
    const publicKey = "rEJSGt93FU0hPnI_d";
    final response = await http.post(url,
        headers: {
      'Content-Type': 'application/json',
          'origin': 'http://localhost',
        },
        body: json.encode({
          "service_id": serviceId,
          "template_Id": templateId,
          "public_Key": publicKey,
          "template_params": {
            "name": nameController.text,
            "subject": subectController.text,
            "message": bodyController.text,
            "user_email": emailController.text,
          }
        }));
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Lottie.asset(
                  "assets/lotties/message.json",
                  height: 200,
                ),
              ),
              buildTextField(
                nameController,
                "Name",
                " ",
                false,
              ),
              buildTextField(subectController, "Report title", " ", false),
              buildTextField(bodyController, "Report", " ", false),
              buildTextField(
                emailController,
                "E-mail",
                " ",
                false,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 20,
                ),
                child: TextButton(
                  onPressed: (() {
                    sendEmail();
                  }),
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xFFEFF3F4),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Center(
                      child: Text(
                        "SEND",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          letterSpacing: 2,
                          fontFamily: "Poppins-SemiBold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
