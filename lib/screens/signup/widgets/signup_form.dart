import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haiya_client/screens/congenital_form/congenital_form_screen.dart';
import 'package:haiya_client/screens/term_agreement/term_agreement_screen.dart';
import 'package:haiya_client/screens/verify_otp/verify_otp_screen.dart';
import 'package:haiya_client/shared/models/congenital_disease.dart';
import 'package:haiya_client/shared/models/drug_allergy.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

import '../../../constants.dart';
import 'gender_radio.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isPassHidden = true, _isConfirmPassHidden = true;
  String? _email = tempUser.email,
      _password = tempUser.password,
      _confirmPass,
      _title = tempUser.title,
      _firstName = tempUser.firstname,
      _lastName = tempUser.lastname,
      _gender = tempUser.gender,
      _phone = tempUser.phone;
  int? _height = tempUser.height, _weight = tempUser.weight;
  final ValueNotifier<String> _dob = ValueNotifier('');

  static AuthService _authService = new AuthService();
  static FormFields _formFields = new FormFields();

  final _formKey = GlobalKey<FormState>();

  void _handleDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1800, 1, 1),
      maxTime: DateTime(2020, 12, 31),
      theme: DatePickerTheme(
        itemStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        doneStyle: TextStyle(color: Colors.black, fontSize: 16),
      ),
      onConfirm: (date) {
        _dob.value = date.toString().split(" ")[0];
        tempUser.dob = _dob.value;
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
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

  bool _isFormEmpty() {
    if (_firstName != '' &&
        _lastName != '' &&
        _dob.value != '' &&
        _height != null &&
        _weight != null &&
        _phone != '' &&
        _email != '' &&
        _password != '' &&
        _confirmPass != '' &&
        _confirmPass != null) {
      return false;
    }
    return true;
  }

  void onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate() && _dob.value != '') {
      bool isSuccess = await _authService.signUp();

      if (isSuccess) {
        Navigator.pushNamed(context, VerifyOtpScreen.routeName);
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Invalid information. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Title
          _formFields.buildTitleField(
            "Title",
            _title,
            (value) => setState(() => {
                  _title = value,
                  tempUser.title = _title!,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // First Name
          _formFields.buildTextRequiredField(
            "First Name",
            (value) => setState(() => {
                  _firstName = value,
                  tempUser.firstname = _firstName!,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Last Name
          _formFields.buildTextRequiredField(
            "Last Name",
            (value) => setState(() => {
                  _lastName = value,
                  tempUser.lastname = _lastName!,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Phone Number
          _formFields.buildPhoneField(
            "Phone Number",
            (value) => setState(() => {
                  _phone = value.toString(),
                  tempUser.phone = _phone!,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Gender and Date of birth
          Row(
            children: [
              Expanded(
                child: GenderRadio(
                  callBack: (value) => setState(() => {
                        _gender = value,
                        tempUser.gender = _gender!,
                      }),
                ),
              ),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(
                child:
                    _formFields.buildDobField(_dob, () => _handleDatePicker()),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Weight and Height
          Row(
            children: [
              Expanded(
                child: _formFields.buildWeightHeightField(
                  "Weight",
                  (value) => setState(() => {
                        _weight = int.parse(value!),
                        tempUser.weight = _weight!,
                      }),
                ),
              ),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(
                child: _formFields.buildWeightHeightField(
                  "Height",
                  (value) => setState(() => {
                        _height = int.parse(value!),
                        tempUser.height = _height!,
                      }),
                ),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Drug Allergy
          _formFields.buildDrugAllergyField(context),
          SizedBox(height: kDefaultPadding / 1.5),

          // Congenital Disease
          _formFields.buildCongenitalDiseaseField(context),
          SizedBox(height: kDefaultPadding / 1.5),

          // Email
          _formFields.buildEmailField(
            "Email",
            (value) => setState(() => {
                  _email = value,
                  tempUser.email = _email!,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Password
          _formFields.buildPasswordField(
              "Password",
              (value) => setState(() => {
                    _password = value,
                    tempUser.password = _password!,
                  }),
              _isPassHidden,
              _togglePasswordVisibility),
          SizedBox(height: kDefaultPadding / 1.5),

          // Confirm Password
          _formFields.buildConfirmPasswordField(
              "Confirm Password",
              (value) => setState(() => _confirmPass = value),
              _password,
              _isConfirmPassHidden,
              _toggleConfirmPasswordVisibility),
          SizedBox(height: kDefaultPadding * 2),

          // Submit Button
          CustomBtn(
            text: "CONFIRM",
            boxColor: _isFormEmpty() ? kGreyColor : kSuccessColor,
            textColor: Colors.white,
            onPressed: () => onSubmit(context),
          ),
          SizedBox(height: kDefaultPadding / 1.5),
        ],
      ),
    );
  }
}
