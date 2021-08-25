import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signup_success/signup_success_screen.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

class VerifyOtpScreen extends StatefulWidget {
  static final routeName = '/verify-otp';

  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  int _enteredOtp = 0;
  bool _isCorrectOtp = false;
  FlutterOtp _otp = FlutterOtp();

  void _sendOtp() {
    _otp.sendOtp(
      currentUser.phone.substring(1),
      null,
      1000,
      9999,
      '+66',
    );
  }

  @override
  void initState() {
    super.initState();
    // _sendOtp();   //TODO: Remove this comment
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(text: "OTP Verification"),
              Center(
                child: Column(
                  children: [
                    Text("The OTP has been sent to"),
                    //TODO: Change to dynamic phone number
                    Text(currentUser.phone),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              _buildOtpField(),
              Spacer(),
              _buildConfirmButton(context),
              SizedBox(height: kDefaultPadding * 1.5),
              _buildResendOtp(),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendOtp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Not getting OTP"),
        GestureDetector(
          onTap: () => _sendOtp(),
          child: Text(
            "Resend",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return CustomBtn(
      text: "CONFIRM OTP",
      boxColor: kSuccessColor,
      onPressed: () {
        //TODO: Implement
        // setState(() => _isCorrectOtp = _otp.resultChecker(_enteredOtp));
        // if (_isCorrectOtp) {
        Navigator.pushReplacementNamed(
          context,
          SignupSuccessScreen.routeName,
        );
        // } else {}
      },
      textColor: Colors.white,
    );
  }

  Widget _buildOtpField() {
    return CustomCard(
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: cardInputDecoration.copyWith(labelText: "OTP Number"),
        onChanged: (value) => setState(() => _enteredOtp = int.parse(value)),
      ),
    );
  }
}
