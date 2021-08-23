import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/congenital_disease.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';
import 'congenital_dropdown.dart';

class CongenitalForm extends StatefulWidget {
  const CongenitalForm({Key? key}) : super(key: key);

  @override
  _CongenitalFormState createState() => _CongenitalFormState();
}

class _CongenitalFormState extends State<CongenitalForm> {
  int _count = 1;
  List<CongenitalDisease>? _congenitalDisease = [];

  void _addNewCongenitalDisease() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _congenitalList = List.generate(
      _count,
      (int i) => CongenitalDropdown(
        onSaved: (disease) => _congenitalDisease!.add(disease),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ..._congenitalList,
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
                tempUser.congenitalDisease = _congenitalDisease;
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
