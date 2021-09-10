import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/send_issue_success/send_issue_success_screen.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/services/issue_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class IssueForm extends StatefulWidget {
  const IssueForm({Key? key}) : super(key: key);

  @override
  _IssueFormState createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  String _title = '',
      _type = ConstantService.dummyIssueType()[0],
      _email = currentUser.email,
      _detail = '';
  FormFields _formFields = new FormFields();
  IssueService _issueService = new IssueService();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSend(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isSend = await _issueService.sendIssueReport(
        email: _email,
        issue: _title,
        type: _type,
        detail: _detail,
      );
      if (isSend) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                SendIssueSuccessScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Unable to send the issue. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          _formFields.buildEmailField(
            "Email*",
            _email,
            (value) => setState(() => _email = value!),
          ),
          SizedBox(height: kDefaultPadding / 2),

          // Issue Name
          _formFields.buildTextRequiredField(
            "Issue Name*",
            _title,
            (value) => setState(() => _title = value!),
          ),
          SizedBox(height: kDefaultPadding / 2),

          // Type of Issue
          _buildTypeOfIssueField(),
          SizedBox(height: kDefaultPadding / 2),

          // Issue Detail
          _buildDetailField(),
          SizedBox(height: kDefaultPadding),

          // Send Button
          CustomBtn(
            text: "SEND",
            boxColor: kPrimaryColor,
            textColor: Colors.white,
            onPressed: () => _onSend(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailField() {
    return CustomCard(
      child: TextFormField(
        initialValue: _detail,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        decoration: cardInputDecoration.copyWith(
          labelText: "Issue Detail",
        ),
        onChanged: (String value) {
          setState(() => _detail = value);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return kFieldNullError + "Issue Detail";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTypeOfIssueField() {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: DropdownButton<String>(
          value: _type,
          isExpanded: true,
          hint: Text(
            "Type of Issue*",
            style: TextStyle(color: kGreyColor),
          ),
          icon: const Icon(Icons.arrow_drop_down_outlined),
          onChanged: (String? newValue) {
            setState(() {
              _type = newValue!;
            });
          },
          items: ConstantService.dummyIssueType()
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
