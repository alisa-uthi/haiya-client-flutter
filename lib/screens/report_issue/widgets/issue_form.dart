import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class IssueForm extends StatefulWidget {
  const IssueForm({Key? key}) : super(key: key);

  @override
  _IssueFormState createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  String _title = '',
      _category = 'Application',
      _email = currentUser.email,
      _detail = '';
  FormFields _formFields = new FormFields();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _formFields.buildTextRequiredField(
            "Email*",
            _email,
            (value) => setState(() => _email = value!),
          ),
          SizedBox(height: kDefaultPadding / 2),
          _formFields.buildTextRequiredField(
            "Issue Name*",
            _title,
            (value) => setState(() => _email = value!),
          ),
          SizedBox(height: kDefaultPadding / 2),
          SizedBox(height: kDefaultPadding / 2),
        ],
      ),
    );
  }
}
