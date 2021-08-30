import 'package:flutter/material.dart';
import 'package:haiya_client/screens/add_shipping_address/add_address_screen.dart';

import '../../../constants.dart';

class NoAddressSaved extends StatelessWidget {
  const NoAddressSaved({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("No shipping address saved at this time."),
        SizedBox(height: kDefaultPadding),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    AddAddressScreen(),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          ),
          child: Text("ADD NEW ADDRESS"),
        ),
      ],
    );
  }
}
