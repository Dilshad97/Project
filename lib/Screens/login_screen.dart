import 'package:demoproject/Screens/home_screen.dart';
import 'package:demoproject/Screens/sign_up_screen.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:demoproject/widgets/container.dart';
import 'package:demoproject/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(backgroundColor: ColorConstants.red, elevation: 0),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: ColorConstants.red),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/logo.png',height: 200,),
              _widgetText('Eagleirance', TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold,fontSize: 25)),
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
                        SizedBox(
                          height: 15,
                        ),

                        InkWell(
                          onTap: () {
                            // if(_formKey.currentState.validate()){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>Home()));
                            // }
                          },
                          child:  _widgetContainer(
                            height / 1.4,
                            width,
                            _widgetText(
                                'Sign In',
                                TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                              },
                              child: _widgetText('Forget Password ||',
                                  TextStyle(color: Colors.blue)),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: _widgetText(
                                    ' OTP Login', TextStyle(color: Colors.blue))),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _widgetText('Or Sign in with ', null),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 75, right: 75, top: 8),
                          child: Row(
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
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _widgetText(
                           " Don't have account ? ", TextStyle(color: Colors.red)),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child:_widgetContainer(
                              height / 1.4,
                              width,
                              _widgetText(
                                  'SIGN UP',
                                  TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ))) ,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                          },
                        )

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
}
