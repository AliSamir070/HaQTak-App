import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PhoneVerififcationScreen extends StatelessWidget {
  static String route = "PhoneVerififcationScreen";
  OtpFieldController controller = OtpFieldController();
  String code = "";
  @override
  Widget build(BuildContext context) {
    String phone = ModalRoute.of(context)!.settings.arguments as String;
    if(code.isEmpty){
      verifyPhone(phone);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Verify $phone",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(
            height: 20,
          ),
          OTPTextField(
            controller: controller,
            length: 6,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22
            ),
            fieldWidth: 60,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            width: double.infinity,
            fieldStyle: FieldStyle.box,
            contentPadding: EdgeInsets.symmetric(vertical: 30),
            keyboardType: TextInputType.phone,
            otpFieldStyle: OtpFieldStyle(
              backgroundColor: Theme.of(context).canvasColor,
              enabledBorderColor: Theme.of(context).canvasColor,
              focusBorderColor: Theme.of(context).canvasColor,
            ),
          )
        ],
      ),
    );
  }
  void verifyPhone(String phone)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (credential){
          print("Verified");
        },
        verificationFailed: (e){},
        codeSent: (verifId,resendToken){
          code = verifId;
        },
        codeAutoRetrievalTimeout: (verifId){
          code = verifId;
          print(code);
        }
    );
  }
}
