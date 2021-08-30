import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/drug_allergy.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';
import 'allergy_dropdown.dart';

class AllergyForm extends StatefulWidget {
  const AllergyForm({Key? key}) : super(key: key);

  @override
  _AllergyFormState createState() => _AllergyFormState();
}

class _AllergyFormState extends State<AllergyForm> {
  int _count = 1;
  List<DrugAllergy>? _drugAllergy = [];

  void _addNewCongenitalDisease() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _allergyList = List.generate(
      _count,
      (int i) => AllergyDropdown(
        onSaved: (allergy) => _drugAllergy!.add(allergy),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ..._allergyList,
            ElevatedButton(
              onPressed: _addNewCongenitalDisease,
              child: new Icon(
                Icons.add,
                color: Colors.white,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            SizedBox(height: kDefaultPadding * 2.5),
            CustomBtn(
              text: "CONFIRM",
              boxColor: kSuccessColor,
              onPressed: () {
                tempUser.drugAllergy = _drugAllergy!;
                Navigator.pop(context);
              },
              textColor: Colors.white,
            ),
            SizedBox(height: kDefaultPadding),
          ],
        );
      },
    );
  }
}
