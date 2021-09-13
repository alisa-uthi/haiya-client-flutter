import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import '../../../constants.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({
    Key? key,
    required this.pharmacyName,
    required this.address,
  }) : super(key: key);

  final String pharmacyName;
  final Address address;

  void _launchMaps(BuildContext context) async {
    String baseGoogleUrl = 'https://www.google.com/maps/dir/?api=1';
    String googleUrl =
        '${baseGoogleUrl}&destination=${address.latitude},${address.longitude}';
    await launch(googleUrl);
    // if (await canLaunch(baseGoogleUrl)) {
    //   print('launching com googleUrl');
    //   await launch(googleUrl);
    // } else {
    //   CustomSnackBar.buildSnackbar(
    //     context,
    //     "Could not open Google Maps application",
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: "Address",
          moreText: "View Map",
          onMoreTap: () {
            // Launch google maps
            _launchMaps(context);

            // To use directions API from Google maps, need billing account //
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation1, animation2) =>
            //         PharmacyAddressMapsScreen(
            //       pharmacyName: pharmacyName,
            //       address: address,
            //     ),
            //     transitionDuration: Duration(seconds: 0),
            //   ),
            // );
          },
        ),
        SizedBox(height: kDefaultPadding / 2),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Text(address.location),
          ),
        ),
      ],
    );
  }
}
