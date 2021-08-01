import 'package:flutter/material.dart';

import '../../../constants.dart';

enum GenderOption { female, male, other }

class GenderRadio extends StatefulWidget {
  final Function? callBack;
  GenderRadio({this.callBack});

  @override
  _GenderRadioState createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  GenderOption _genderOption = GenderOption.male;

  void _handleGenderChange(GenderOption? value, String gender) {
    widget.callBack!(gender);
    setState(() {
      _genderOption = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Gender",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Row(
            children: [
              Radio(
                activeColor: kPrimaryColor,
                value: GenderOption.male,
                groupValue: _genderOption,
                onChanged: (GenderOption? value) =>
                    _handleGenderChange(value, "Male"),
              ),
              Text(
                "M",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Radio(
                activeColor: kPrimaryColor,
                value: GenderOption.female,
                groupValue: _genderOption,
                onChanged: (GenderOption? value) =>
                    _handleGenderChange(value, "Female"),
              ),
              Text(
                "F",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Radio(
                activeColor: kPrimaryColor,
                value: GenderOption.other,
                groupValue: _genderOption,
                onChanged: (GenderOption? value) =>
                    _handleGenderChange(value, "Other"),
              ),
              Text(
                "-",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
