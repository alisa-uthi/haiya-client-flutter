import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';
import 'gender_radio.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isPassHidden = true,
      _isConfirmPassHidden = true,
      _isAgreeOnTerms = false;
  String? _email,
      _password,
      _confirmPass,
      _ctzNum,
      _title,
      _firstName,
      _lastName,
      _gender,
      _height,
      _weight,
      _phone,
      _addrRoom,
      _addrFloor,
      _addrNo,
      _addrMoo,
      _addrSoi,
      _addrRoad,
      _addrSubDistrict,
      _addrDistrict,
      _addrProvince,
      _addrPostalCode;
  final ValueNotifier<String> _dob = ValueNotifier('');
  AuthService _authService = new AuthService();
  final _formKey = GlobalKey<FormState>();

  void _handleDatePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1800, 1, 1),
        maxTime: DateTime(2020, 12, 31),
        theme: DatePickerTheme(
          itemStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          doneStyle: TextStyle(color: Colors.black, fontSize: 16),
        ), onConfirm: (date) {
      _dob.value = date.toString().split(" ")[0];
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField("Title", _title),
          SizedBox(height: kDefaultPadding / 1.5),
          _buildTextField("First Name", _firstName),
          SizedBox(height: kDefaultPadding / 1.5),
          _buildTextField("Last Name", _lastName),
          SizedBox(height: kDefaultPadding / 1.5),
          _buildPhoneField("Phone Number", _phone),
          SizedBox(height: kDefaultPadding / 1.5),
          Row(
            children: [
              Expanded(
                child: GenderRadio(
                  callBack: (value) => setState(() => _gender = value),
                ),
              ),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(child: _buildDobField(_dob, () => _handleDatePicker())),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),
          Row(
            children: [
              Expanded(child: _buildWeightHeightField("Weight", _weight)),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(child: _buildWeightHeightField("Height", _weight)),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),
          _buildEmailField("Email", _email),
          SizedBox(height: kDefaultPadding / 1.5),
          _buildPasswordField("Password", _password),
          SizedBox(height: kDefaultPadding / 1.5),
          _buildConfirmPasswordField("Confirm", _confirmPass),
          SizedBox(height: kDefaultPadding),
          GestureDetector(
            // TODO: Link to terms conditions
            onTap: () {},
            child: Text(
              "Term of Services and Agreement",
              style: TextStyle(
                color: kPrimaryColor,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: kPrimaryColor,
                value: _isAgreeOnTerms,
                onChanged: (value) => setState(
                  () {
                    _isAgreeOnTerms = value!;
                  },
                ),
              ),
              Text("I agree to HAIYA’s Term of services"),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),
          CustomBtn(
            text: "CONFIRM",
            boxColor: kSuccessColor,
            onPressed: () {}, // TODO: Add call api and navigator
            textColor: Colors.white,
          ),
          SizedBox(height: kDefaultPadding / 1.5),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String? variable) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: (value) => setState(() => variable = value),
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneField(String label, String? variable) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: (value) => setState(() => variable = value.toString()),
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          if (value.length != 10) {
            return "Please enter valid phone number";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDobField(ValueNotifier dob, Function onTap) {
    return ValueListenableBuilder(
      valueListenable: dob,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => onTap(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding / 3),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                    top: kDefaultPadding / 2,
                  ),
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2.5),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2,
                    horizontal: kDefaultPadding,
                  ),
                  child: dob.value == ''
                      ? Text(
                          "Select Date of Birth",
                          style: TextStyle(color: kHintTextColor),
                        )
                      : Text(dob.value),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeightHeightField(String label, String? variable) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(
          labelText: label,
          suffixText: label == 'Weight' ? "kg" : "cm",
        ),
        onChanged: (value) => setState(() => variable = value.toString()),
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField(String label, String? variable) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: (value) => setState(() => variable = value),
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          if (!emailPattern.hasMatch(value)) {
            return kInvalidEmailError;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(String label, String? variable) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: TextFormField(
        obscureText: _isPassHidden,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(
          labelText: label,
          suffixIcon: IconButton(
            onPressed: _togglePasswordVisibility,
            icon: _isPassHidden
                ? Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
          ),
        ),
        onChanged: (value) => setState(() => variable = value),
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          if (value.length < 8) {
            return kShortPassError;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField(String label, String? variable) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: TextFormField(
        obscureText: _isConfirmPassHidden,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(
          labelText: label,
          suffixIcon: IconButton(
            onPressed: _toggleConfirmPasswordVisibility,
            icon: _isConfirmPassHidden
                ? Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
          ),
        ),
        onChanged: (value) => setState(() => variable = value),
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          if (_password != value) {
            return kMatchPassError;
          }
          return null;
        },
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPassHidden = !_isPassHidden;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPassHidden = !_isConfirmPassHidden;
    });
  }
}
