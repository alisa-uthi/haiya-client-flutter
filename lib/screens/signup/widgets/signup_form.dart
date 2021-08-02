import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
      _title = 'Mr.',
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
  List<String> _selectedCongential = [];
  List<String> _selectedDrugAllergy = [];
  final ValueNotifier<String> _dob = ValueNotifier('');

  static AuthService _authService = new AuthService();
  static ConstantService _constantService = new ConstantService();
  static FormFields _formFields = new FormFields();

  final _formKey = GlobalKey<FormState>();

  List<MultiSelectItem<String>> _congentialDiseaseItems = _constantService
      .congentialDiseaseOptions()
      .map((disease) => MultiSelectItem<String>(disease, disease))
      .toList();

  List<MultiSelectItem<String>> _drugAllergyItems = _constantService
      .drugAllergyOptions()
      .map((drugAllergy) => MultiSelectItem<String>(drugAllergy, drugAllergy))
      .toList();

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
            (value) => setState(() => _title = value),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // First Name
          _formFields.buildTextRequiredField(
            "First Name",
            _firstName,
            (value) => setState(() => _firstName = value),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Last Name
          _formFields.buildTextRequiredField(
            "Last Name",
            _lastName,
            (value) => setState(() => _lastName = value),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Address
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  child: Text(
                    "Address",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                _formFields.buildTextField(
                  "Room",
                  _addrRoom,
                  (value) => setState(() => _addrRoom = value),
                ),
                _formFields.buildTextField(
                  "Floor",
                  _addrFloor,
                  (value) => setState(() => _addrFloor = value),
                ),
                _formFields.buildTextRequiredField(
                  "Address Number",
                  _addrNo,
                  (value) => setState(() => _addrNo = value),
                ),
                _formFields.buildTextField(
                  "Moo",
                  _addrMoo,
                  (value) => setState(() => _addrMoo = value),
                ),
                _formFields.buildTextField(
                  "Soi",
                  _addrSoi,
                  (value) => setState(() => _addrSoi = value),
                ),
                _formFields.buildTextRequiredField(
                  "Road",
                  _addrRoad,
                  (value) => setState(() => _addrRoad = value),
                ),
                _formFields.buildTextRequiredField(
                  "Subdistrict",
                  _addrSubDistrict,
                  (value) => setState(() => _addrSubDistrict = value),
                ),
                _formFields.buildTextRequiredField(
                  "District",
                  _addrDistrict,
                  (value) => setState(() => _addrDistrict = value),
                ),
                _formFields.buildTextRequiredField(
                  "Province",
                  _addrProvince,
                  (value) => setState(() => _addrProvince = value),
                ),
                _formFields.buildTextRequiredField(
                  "Postal Code",
                  _addrPostalCode,
                  (value) => setState(() => _addrPostalCode = value),
                ),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Phone Number
          _formFields.buildPhoneField(
            "Phone Number",
            _phone,
            (value) => setState(() => _phone = value.toString()),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Gender and Date of birth
          Row(
            children: [
              Expanded(
                child: GenderRadio(
                  callBack: (value) => setState(() => _gender = value),
                ),
              ),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(
                  child: _formFields.buildDobField(
                      _dob, () => _handleDatePicker())),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Weight and Height
          Row(
            children: [
              Expanded(
                child: _formFields.buildWeightHeightField("Weight", _weight,
                    (value) => setState(() => _weight = value.toString())),
              ),
              SizedBox(width: kDefaultPadding / 1.5),
              Expanded(
                child: _formFields.buildWeightHeightField("Height", _height,
                    (value) => setState(() => _height = value.toString())),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Email
          _formFields.buildEmailField(
            "Email",
            _email,
            (value) => setState(() => _email = value),
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Password
          _formFields.buildPasswordField(
              "Password",
              _password,
              (value) => setState(() => _password = value),
              _isPassHidden,
              _togglePasswordVisibility),
          SizedBox(height: kDefaultPadding / 1.5),

          // Confirm Password
          _formFields.buildConfirmPasswordField(
              "Confirm",
              _confirmPass,
              (value) => setState(() => _confirmPass = value),
              _password,
              _isConfirmPassHidden,
              _toggleConfirmPasswordVisibility),
          SizedBox(height: kDefaultPadding),

          // Congential Disease
          _formFields.buildMultiSelectField(
            "Congential Disease",
            _selectedCongential,
            _congentialDiseaseItems,
            (values) {
              setState(() => _selectedCongential = values);
            },
            (item) {
              setState(() => _selectedCongential.remove(item));
            },
          ),
          SizedBox(height: kDefaultPadding / 1.5),

          // Drug Allergy
          _formFields.buildMultiSelectField(
            "Drug Allergy",
            _selectedDrugAllergy,
            _drugAllergyItems,
            (values) {
              setState(() => _selectedDrugAllergy = values);
            },
            (item) {
              setState(() => _selectedDrugAllergy.remove(item));
            },
          ),
          SizedBox(height: kDefaultPadding),

          // Term of Services and Agreement
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

          // Submit Button
          CustomBtn(
            text: "CONFIRM",
            boxColor: kSuccessColor,
            textColor: Colors.white,
            onPressed: () => {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (_formKey.currentState!.validate() &&
                    _dob.value != '' &&
                    _isAgreeOnTerms) {
                  // TODO: Add call api and navigator
                  print("Submmit");
                  print("""${_email} ,
      ${_password} ,
      ${_confirmPass} ,
      ${_title} ,
      ${_firstName} ,
      ${_lastName} ,
      ${_gender} ,
      ${_height} ,
      ${_weight} ,
      ${_phone} ,
      ${_addrRoom} ,
      ${_addrFloor} ,
      ${_addrNo} ,
      ${_addrMoo} ,
      ${_addrSoi} ,
      ${_addrRoad} ,
      ${_addrSubDistrict} ,
      ${_addrDistrict} ,
      ${_addrProvince} ,
      ${_addrPostalCode} ,
      DOB: ${_dob.value} 
      Congen: ${_selectedCongential} ,
      Drug Allergy: ${_selectedDrugAllergy}
      """);
                  // Navigator.pushNamed(context, SignInScreen.routeName);
                }
              })
            },
          ),
          SizedBox(height: kDefaultPadding / 1.5),
        ],
      ),
    );
  }
}
