import 'package:demoproject/Auth/forget_password/provider/forget_provider.dart';
import 'package:demoproject/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key key}) : super(key: key);

  TextEditingController resetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          CustomTextfield(
            controller: resetPasswordController,
            hintName: "Enter You Email",
            inputType: TextInputType.emailAddress,
            isObscureText: false,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(300, 45),
              ),
              onPressed: () {
                ForgetPasswordProvider provider =
                    Provider.of<ForgetPasswordProvider>(context, listen: false);
                provider.resetPassword(resetPasswordController.text);
              },
              child: Text("Reset",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ))),
        ]));
  }
}
