import 'package:demoproject/Auth/signup/logic/method.dart';
import 'package:demoproject/home/home_screen.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_const.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:demoproject/widgets/container.dart';
import 'package:demoproject/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        width: width,
        color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
              _widgetText(
                  'Eagleirance',
                  TextStyle(
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              CustomContainer(
                width: width,
                hight: height,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: _Textfield(context),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget _Textfield(BuildContext context) {
    return Column(
      children: [
        CustomTextfield(
          controller: firstnamecontroller,
          isObscureText: false,
          inputType: TextInputType.text,
          hintName: 'First Name',
        ),
        CustomTextfield(
          controller: lastnamecontroller,
          isObscureText: false,
          inputType: TextInputType.text,
          hintName: 'Last Name',
        ),
        CustomTextfield(
          controller: emailcontroller,
          isObscureText: false,
          inputType: TextInputType.text,
          hintName: 'Email ',
        ),
        CustomTextfield(
          controller: passwordcontroller,
          isObscureText: false,
          inputType: TextInputType.text,
          hintName: 'Password',
        ),
        CustomTextfield(
          controller: confirmpasswordcontroller,
          isObscureText: true,
          inputType: TextInputType.text,
          hintName: 'Confirm Password',
        ),
        SizedBox(height: 10),
        _signUpButton(context)
      ],
    );
  }

  Widget _signUpButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: const Size(300, 45),
        ),
        onPressed: () {
          print('tap');
          String pass = passwordcontroller.text;
          String confirmpass = confirmpasswordcontroller.text;
          if(_formKey.currentState.validate() && pass==confirmpass){
          SignupMethod().signup(emailcontroller.text, passwordcontroller.text, context);
        }else{
            return showInSnackBar("Password not matched");
          }},
        child: _widgetText(
            "SIGNUP", TextStyle(fontWeight: FontWeight.bold, fontSize: 16)));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _widgetText(String text, TextStyle style) => Text(text, style: style);
}
