import 'package:demoproject/Auth/Login/logic/method.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/utils/locator.dart';
import 'package:demoproject/utils/navigation_const.dart';
import 'package:demoproject/utils/navigation_util.dart';
import 'package:demoproject/widgets/container.dart';
import 'package:demoproject/widgets/textfield_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() => print("///completed"));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(backgroundColor: ColorConstants.red, elevation: 0),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: ColorConstants.red),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _widgetText(
                            'Sign In',
                            TextStyle(
                                color: ColorConstants.red,
                                fontSize: 27,
                                fontWeight: FontWeight.bold)),

                        /// Login TextFiend
                        _loginTextField(),
                        SizedBox(
                          height: 15,
                        ),

                        /// login Button
                        _loginButton(context, height, width),
                        SizedBox(
                          height: 15,
                        ),

                        ///forget password
                        _foregtPassButton(),
                        SizedBox(
                          height: 5,
                        ),
                        _widgetText('Or Sign in with ', null),
                        SizedBox(
                          height: 5,
                        ),

                        /// socical login
                        Padding(
                          padding: EdgeInsets.only(left: 75, right: 75, top: 8),
                          child: _socialLogin(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _widgetText(" Don't have account ? ",
                            TextStyle(color: Colors.red)),
                        SizedBox(
                          height: 5,
                        ),

                        /// register button
                        _registerButton(height, width, context)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _loginTextField() {
    return Column(
      children: [
        CustomTextfield(
          isObscureText: false,
          controller: emailcontroller,
          hintName: 'Email',
          inputType: TextInputType.text,
        ),
        CustomTextfield(
          isObscureText: true,
          controller: passwordcontroller,
          hintName: 'Password',
          inputType: TextInputType.text,
        ),
      ],
    );
  }

  Widget _loginButton(BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          return Methods().loginUser(
              emailcontroller.text, passwordcontroller.text, context);
        } else {
          return showInSnackBar("Invalid Email/Password");
        }
      },
      child: _widgetContainer(
        height / 1.4,
        width,
        _widgetText(
            'Login',
            TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  Widget _foregtPassButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            locator<NavigationUtil>().push(context, resetpassword);
          },
          child:
              _widgetText('Forget Password ||', TextStyle(color: Colors.blue)),
        ),
        GestureDetector(
            onTap: () {},
            child: _widgetText(' OTP Login', TextStyle(color: Colors.blue))),
      ],
    );
  }

  Widget _socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.network(
          'https://banner2.cleanpng.com/20201008/rtv/transparent-google-suite-icon-google-icon-5f7f985ccd60e3.5687494416021975968412.jpg',
          height: 35,
          width: 35,
        ),
        Image.network(
          'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png',
          height: 35,
          width: 35,
        ),
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRaekzA4ZW-1ZXQdwSVSlVBcTCoa6SyiAIaQ&usqp=CAU',
          height: 35,
          width: 35,
        ),
      ],
    );
  }

  Widget _registerButton(double height, double width, BuildContext context) {
    return InkWell(
      child: _widgetContainer(
          height / 1.4,
          width,
          _widgetText(
              'Register',
              TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ))),
      onTap: () {
        locator<NavigationUtil>().push(context, signup);
      },
    );
  }

  _widgetContainer(
    double height,
    double width,
    Text _widgetText,
  ) =>
      Container(
          height: height / 15,
          width: width / 1.4,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(50)),
          child: Center(child: _widgetText));

  _widgetText(String text, TextStyle style) => Text(text, style: style);

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
