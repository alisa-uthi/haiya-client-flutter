import 'package:flutter/material.dart';

import '../../../constants.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    Key? key,
    required this.phone,
  }) : super(key: key);

  final String? phone;

  String formatPhone(String phoneNumber) {
    return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: kDefaultPadding / 3),
        Text('Tel. ${formatPhone(phone!)}'),
      ],
    );
  }
}
