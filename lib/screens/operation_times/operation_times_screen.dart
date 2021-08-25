import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../constants.dart';
import 'widgets/contact_section.dart';
import 'widgets/opt_list.dart';

class OperationTimesScreen extends StatelessWidget {
  static final routeName = '/operation-time';

  const OperationTimesScreen({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);

  final Pharmacy? pharmacy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 0),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pharmacy!.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  SizedBox(height: kDefaultPadding),
                  OptList(operationTime: pharmacy!.operationTime),
                  SizedBox(height: kDefaultPadding / 2),
                  ContactSection(phone: pharmacy!.phone)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Operation Time",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
