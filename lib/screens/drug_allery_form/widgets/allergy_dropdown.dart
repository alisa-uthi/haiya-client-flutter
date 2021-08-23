import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/drug_allergy.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class AllergyDropdown extends StatefulWidget {
  const AllergyDropdown({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final Function onSaved;

  @override
  _AllergyDropdownState createState() => _AllergyDropdownState();
}

class _AllergyDropdownState extends State<AllergyDropdown> {
  List<String> _drugAllergyItems = [];
  List<String> _severityLevels = [];
  DrugAllergy _currentAllergy = new DrugAllergy(
    name: '',
    severity: '',
    reaction: '',
  );
  String? _name, _reaction, _severity;
  bool _isSaved = false;
  static FormFields _formFields = new FormFields();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _drugAllergyItems = ConstantService.dummyDrugAllergyOptions();
    _severityLevels = ['Low', 'Medium', 'Severe', 'Very Severe'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Name
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: DropdownButton<String>(
                value: _name,
                isExpanded: true,
                hint: Text(
                  "Drug Allergy's Name *",
                  style: TextStyle(color: kGreyColor),
                ),
                icon: const Icon(Icons.arrow_drop_down_outlined),
                onChanged: (String? newValue) {
                  setState(() {
                    _name = newValue;
                    _currentAllergy.name = _name;
                  });
                },
                items: _drugAllergyItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),

            // Severity
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: DropdownButton<String>(
                value: _severity,
                isExpanded: true,
                hint: Text(
                  "Severity Level *",
                  style: TextStyle(color: kGreyColor),
                ),
                icon: const Icon(Icons.arrow_drop_down_outlined),
                onChanged: (String? newValue) {
                  setState(() {
                    _severity = newValue;
                    _currentAllergy.severity = _severity;
                  });
                },
                items: _severityLevels
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),

            // Reaction
            Form(
              key: _formKey,
              child: _formFields.buildTextRequiredField(
                "Reaction *",
                (value) => {
                  setState(() => {
                        _reaction = value,
                        _currentAllergy.reaction = _reaction,
                      }),
                },
              ),
            ),

            ElevatedButton(
              onPressed: !_isSaved
                  ? () {
                      if (!_isSaved) {
                        setState(() {
                          if (_name != '' &&
                              _severity != '' &&
                              _formKey.currentState!.validate()) {
                            _isSaved = true;
                            widget.onSaved(_currentAllergy);
                          } else {
                            _isSaved = false;
                          }
                        });
                      }
                    }
                  : () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _isSaved ? kGreyColor : kSuccessColor,
                ),
              ),
              child: Text(
                _isSaved ? "Saved!" : "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
