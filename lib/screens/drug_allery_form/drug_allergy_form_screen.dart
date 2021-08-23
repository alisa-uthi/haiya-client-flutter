import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

import '../../constants.dart';
import 'widgets/allergy_form.dart';

class DrugAllergyFormScreen extends StatelessWidget {
  static final routeName = '/drug-allergy';

  const DrugAllergyFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: "Drug Allergy"),
                SizedBox(height: kDefaultPadding / 2),
                AllergyForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
