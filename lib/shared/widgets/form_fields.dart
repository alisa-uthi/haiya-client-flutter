import 'package:flutter/material.dart';
import 'package:haiya_client/screens/congenital_form/congenital_form_screen.dart';
import 'package:haiya_client/screens/drug_allery_form/drug_allergy_form_screen.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../constants.dart';

class FormFields {
  Widget buildTitleField(
      String label, String? variable, Function(String?)? onChange) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: DropdownButton<String>(
          value: variable,
          isExpanded: true,
          hint: Text(
            label,
            style: TextStyle(color: kGreyColor),
          ),
          items: <String>['Mr.', 'Mrs.', 'Ms.', 'Miss.'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    String? variable,
    Function(String?)? onChange,
  ) {
    return CustomCard(
      child: TextFormField(
        initialValue: variable,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: onChange,
      ),
    );
  }

  Widget buildTextRequiredField(
    String label,
    String? variable,
    Function(String?)? onChange,
  ) {
    return CustomCard(
      child: TextFormField(
        initialValue: variable,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: onChange,
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          return null;
        },
      ),
    );
  }

  Widget buildPhoneField(
      String label, String? variable, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
        initialValue: variable,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: onChange,
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

  Widget buildDobField(ValueNotifier dob, Function onTap) {
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
                    style: TextStyle(color: kGreyColor),
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
                          style: TextStyle(color: kGreyColor),
                        )
                      : Text(dob.value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildWeightHeightField(
      String label, String? variable, Function(String?)? onChange) {
    var initialVal = variable != 'null' ? variable : '';

    return CustomCard(
      child: TextFormField(
        initialValue: initialVal.toString(),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(
          labelText: label,
          suffixText: label == 'Weight' ? "kg" : "cm",
        ),
        onChanged: onChange,
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          return null;
        },
      ),
    );
  }

  Widget buildEmailField(
      String label, String? variable, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
        initialValue: variable,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: onChange,
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

  Widget buildPasswordField(
    String label,
    String? variable,
    Function(String?)? onChange,
    bool _isHidden,
    Function() toggleVisibility,
  ) {
    return CustomCard(
      child: TextFormField(
        initialValue: variable,
        obscureText: _isHidden,
        keyboardType: TextInputType.visiblePassword,
        decoration: cardInputDecoration.copyWith(
          labelText: label,
          hintText: "Password must be at least 8 characters",
          hintStyle: TextStyle(color: kGreyColor),
          suffixIcon: IconButton(
            onPressed: toggleVisibility,
            icon: _isHidden
                ? Icon(
                    Icons.visibility_off,
                    color: kGreyColor,
                  )
                : Icon(
                    Icons.visibility,
                    color: kGreyColor,
                  ),
          ),
        ),
        onChanged: onChange,
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

  Widget buildConfirmPasswordField(
    String label,
    Function(String?)? onChange,
    String? password,
    bool _isHidden,
    Function() toggleVisibility,
  ) {
    return CustomCard(
      child: TextFormField(
        obscureText: _isHidden,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        decoration: cardInputDecoration.copyWith(
          labelText: label,
          suffixIcon: IconButton(
            onPressed: toggleVisibility,
            icon: _isHidden
                ? Icon(
                    Icons.visibility_off,
                    color: kGreyColor,
                  )
                : Icon(
                    Icons.visibility,
                    color: kGreyColor,
                  ),
          ),
        ),
        onChanged: onChange,
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + label;
          }
          if (password != value) {
            return kMatchPassError;
          }
          return null;
        },
      ),
    );
  }

  Widget buildDrugAllergyField(BuildContext context) {
    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              "Drug Allergy",
              style: TextStyle(
                fontSize: 14,
                color: kGreyColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      DrugAllergyFormScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_forward,
              size: 20,
              color: kGreyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCongenitalDiseaseField(BuildContext context) {
    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              "Congenital Disease",
              style: TextStyle(
                fontSize: 14,
                color: kGreyColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      CongenitalFormScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_forward,
              size: 20,
              color: kGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
