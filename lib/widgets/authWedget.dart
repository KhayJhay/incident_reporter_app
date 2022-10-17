import 'package:flutter/material.dart';

Widget buildTextField(TextEditingController controller, IconData icon,
    String hintext, bool isPassword, bool isEmail) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 25.0),
    child: TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please this field is required");
        }
        if (isEmail) {
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter a valid email");
          }
        }
        if (isPassword) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (!regex.hasMatch(value)) {
            return ("Please Enter Valid Password(Min. 6 charaters)");
          }
        }
        return null;
      },
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      onSaved: (value) {
        controller.text = value.toString();
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(15),
        hintText: hintext,
        hintStyle: TextStyle(fontSize: 14, color: Colors.white),
      ),
    ),
  );
}
