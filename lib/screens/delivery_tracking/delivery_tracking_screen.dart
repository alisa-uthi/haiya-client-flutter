import 'package:flutter/material.dart';
import 'package:haiya_client/screens/rate_pharmacy/rate_pharmacy_screen.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

import '../../constants.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  static final routeName = '/delivery-tracking';

  const DeliveryTrackingScreen({Key? key}) : super(key: key);

  @override
  _DeliveryTrackingScreenState createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(text: "Delivery Tracking"),

              // TODO: Change to map later
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          RatePharmacyScreen(pharmacyName: 'Fascino'),
                    ),
                  );
                },
                child: Text("Mock\nOrder Received\nRate Pharmacy (Fascino)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
