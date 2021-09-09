import 'package:flutter/material.dart';
import 'package:haiya_client/screens/add_shipping_address/add_address_screen.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
      child: new Icon(
        Icons.add,
        color: Colors.white,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
      ),
    );
  }
}
