import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haiya_client/screens/personal_information/personal_information_screen.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';
import 'package:haiya_client/shared/widgets/gender_radio.dart';

import '../../../constants.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  String _title = currentUser.title,
      _firstName = currentUser.firstname,
      _lastName = currentUser.lastname,
      _gender = currentUser.gender == 'M'
          ? "male"
          : currentUser.gender == 'F'
              ? "female"
              : "other",
      _phone = currentUser.phone;
  int _height = currentUser.height!, _weight = currentUser.weight!;
  final ValueNotifier<String> _dob = ValueNotifier(currentUser.dob);
  final UserService _userService = new UserService();
  static FormFields _formFields = new FormFields();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tempUser = currentUser;
    tempUser.drugAllergy = [];
    tempUser.congenitalDisease = [];
  }

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

  bool _isFormEmpty() {
    if (_firstName != '' &&
        _lastName != '' &&
        _dob.value != '' &&
        _height != 0 &&
        _weight != 0 &&
        _phone != '') {
      return false;
    }
    return true;
  }

  void onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate() && !_isFormEmpty()) {
      bool isSuccess = await _userService.updatePersonalInfo();

      if (isSuccess) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PersonalInformationScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Invalid information. Please try again.',
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Title
          _formFields.buildTitleField(
            "Title*",
            _title,
            (value) => setState(() => {
                  _title = value!,
                  tempUser.title = _title,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // First Name
          _formFields.buildTextRequiredField(
            "First Name*",
            _firstName,
            (value) => setState(() => {
                  _firstName = value!,
                  tempUser.firstname = _firstName,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Last Name
          _formFields.buildTextRequiredField(
            "Last Name*",
            _lastName,
            (value) => setState(() => {
                  _lastName = value!,
                  tempUser.lastname = _lastName,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Phone Number
          _formFields.buildPhoneField(
            "Phone Number*",
            _phone,
            (value) => setState(() => {
                  _phone = value.toString(),
                  tempUser.phone = _phone,
                }),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Gender and Date of birth
          Row(
            children: [
              Expanded(
                child: GenderRadio(
                  initialGenderOption: _gender,
                  callBack: (value) => setState(() => {
                        _gender = value,
                        tempUser.gender = _gender,
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
                  "Weight*",
                  _weight.toString(),
                  (value) => setState(() => {
                        _weight = int.parse(value!),
                        tempUser.weight = _weight,
                      }),
                ),
              ),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(
                child: _formFields.buildWeightHeightField(
                  "Height*",
                  _height.toString(),
                  (value) => setState(() => {
                        _height = int.parse(value!),
                        tempUser.height = _height,
                      }),
                ),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          Text(
            """Note: For the drug allergy and congenital disease, you can add it more. However, you cannot edit or delete it since we will keep the record as your medication information.""",
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Drug Allergy
          _formFields.buildDrugAllergyField(context),
          SizedBox(height: kDefaultPadding / 1.5),

          // Congenital Disease
          _formFields.buildCongenitalDiseaseField(context),
          SizedBox(height: kDefaultPadding * 1.5),

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
