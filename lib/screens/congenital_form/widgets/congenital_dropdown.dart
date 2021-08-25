import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/congenital_disease.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class CongenitalDropdown extends StatefulWidget {
  const CongenitalDropdown({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final Function onSaved;

  @override
  _CongenitalDropdownState createState() => _CongenitalDropdownState();
}

class _CongenitalDropdownState extends State<CongenitalDropdown> {
  List<String> _congentialDiseaseItems = [];
  List<String> _severityLevels = [];

  CongenitalDisease _currentDisease = new CongenitalDisease(
    name: '',
    reaction: '',
    severity: '',
  );
  String? _name, _reaction, _severity;
  bool _isSaved = false;
  static FormFields _formFields = new FormFields();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _congentialDiseaseItems = ConstantService.dummyCongentialDiseaseOptions();
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
                  "Congenital Disease's Name *",
                  style: TextStyle(color: kGreyColor),
                ),
                icon: const Icon(Icons.arrow_drop_down_outlined),
                onChanged: (String? newValue) {
                  setState(() {
                    _name = newValue;
                    _currentDisease.name = _name;
                  });
                },
                items: _congentialDiseaseItems
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
                hint: Text("Severity Level *",
                    style: TextStyle(color: kGreyColor)),
                icon: const Icon(Icons.arrow_drop_down_outlined),
                onChanged: (String? newValue) {
                  setState(() {
                    _severity = newValue;
                    _currentDisease.severity = _severity;
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
                        _currentDisease.reaction = _reaction,
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
                            widget.onSaved(_currentDisease);
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
