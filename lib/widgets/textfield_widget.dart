import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    key,
    this.controller,
    this.icon,
    this.isObscureText,
    this.inputType,
    this.isEnable,
    this.hintName,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintName;
  final IconData icon;
  final bool isObscureText;
  final TextInputType inputType;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
          top: 20,
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return 'Enter valid $hintName';
            }
            if (hintName == 'Email' && !validateEmail(value)) {
              return ' Enter valid email ';
            } else
              return null;
          },
          obscureText: isObscureText,
          enabled: isEnable,
          keyboardType: inputType,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 45.0),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              hintText: hintName,
              suffixIcon: Icon(icon),
              fillColor: Colors.grey.shade200,
              filled: true),
        ));
  }
}

validateEmail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}
