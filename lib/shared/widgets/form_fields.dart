import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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

  Widget buildTextField(String label, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: cardInputDecoration.copyWith(labelText: label),
        onChanged: onChange,
      ),
    );
  }

  Widget buildTextRequiredField(String label, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
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

  Widget buildPhoneField(String label, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
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

  Widget buildWeightHeightField(String label, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
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

  Widget buildEmailField(String label, Function(String?)? onChange) {
    return CustomCard(
      child: TextFormField(
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

  Widget buildPasswordField(String label, Function(String?)? onChange,
      bool _isHidden, Function() toggleVisibility) {
    return CustomCard(
      child: TextFormField(
        obscureText: _isHidden,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
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
        textInputAction: TextInputAction.next,
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

  Widget buildMultiSelectField(
    String label,
    List<MultiSelectItem<String>> items,
    Function(List<String>) onConfirm,
    Function(String) onChipRemove,
  ) {
    return CustomCard(
      child: MultiSelectBottomSheetField<String>(
        buttonIcon: Icon(
          Icons.add_rounded,
          color: kGreyColor,
        ),
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        title: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding / 2),
          child: Text(label),
        ),
        buttonText: Text(label, style: TextStyle(color: kGreyColor)),
        items: items,
        selectedColor: kPrimaryColor,
        searchable: true,
        onConfirm: (value) => onConfirm(value),
        chipDisplay: MultiSelectChipDisplay(
          chipColor: kBackgroundColor,
          textStyle: TextStyle(color: Colors.black),
          onTap: (item) => onChipRemove(item),
        ),
      ),
    );
  }
}
