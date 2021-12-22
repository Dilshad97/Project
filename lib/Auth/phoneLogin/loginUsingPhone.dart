import 'dart:async';

import 'package:demoproject/Auth/phoneLogin/provider.dart';
import 'package:demoproject/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthPage extends StatefulWidget {
  PhoneAuthPage({Key key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 45;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";
  @override


  final _scaffoldKey = GlobalKey<ScaffoldState>();



  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        key: _scaffoldKey,
        backgroundColor: ColorConstants.red.shade300,
        // appBar: AppBar(
        //   backgroundColor: Colors.black87,
        //   title: Text(
        //     "SignUp",
        //     style: TextStyle(color: Colors.white, fontSize: 24),
        //   ),
        //   centerTitle: true,
        // ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                textField(),
                SizedBox(
                  height: 30,
                ),
                Container(

                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      Text(
                        "Enter 6 digit OTP",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                otpField(),
                SizedBox(
                  height: 40,
                ),
                RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Send OTP again in ",
                          style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                        ),
                        TextSpan(
                          text: "00:$start",
                          style: TextStyle(fontSize: 16, color: Colors.red.shade800),
                        ),
                        TextSpan(
                          text: " sec ",
                          style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 150,
                ),
                // InkWell(
                //   onTap: () {
                //     authClass.signInwithPhoneNumber(
                //         verificationIdFinal, smsCode, context, _scaffoldKey);
                //   },
                //   child: Container(
                //     height: 60,
                //     width: MediaQuery.of(context).size.width - 60,
                //     decoration: BoxDecoration(
                //         color: Color(0xffff9601),
                //         borderRadius: BorderRadius.circular(15)),
                //     child: Center(
                //       child: Text(
                //         "Submit",
                //         style: TextStyle(
                //             fontSize: 17,
                //             color: Color(0xfffbe2ae),
                //             fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //   ),
                // ),


                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: const Size(300, 45),
                    ),
                    onPressed: () {
                      authClass.signInwithPhoneNumber(
                          verificationIdFinal, smsCode, context, _scaffoldKey);
                    },
                    child: Text("Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ))),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,

      // fieldStyle: OtpFieldStyle(
      //   backgroundColor: Color(0xff1d1d1d),
      //   borderColor: Colors.white,
      // ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xffd0b6b6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        style: TextStyle(color: Colors.white, fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone Number",
          hintStyle: TextStyle(color: Colors.white, fontSize: 17),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+91) ",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
              setState(() {
                start = 45;
                wait = true;
                buttonName = "Resend";
              });
              await authClass.verifyPhoneNumber(
                  "+91 ${phoneController.text}", context, setData,_scaffoldKey);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}