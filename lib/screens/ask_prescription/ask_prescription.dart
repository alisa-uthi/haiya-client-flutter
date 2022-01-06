import 'package:flutter/material.dart';
import 'package:haiya_client/screens/chat/chat_screen.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../constants.dart';

class AskPrescriptionScreen extends StatefulWidget {
  static final routeName = '/ask-prescription';

  const AskPrescriptionScreen({
    Key? key,
    required this.pharmacyId,
    required this.pharmacyName,
  }) : super(key: key);

  final int pharmacyId;
  final String pharmacyName;

  @override
  State<AskPrescriptionScreen> createState() => _AskPrescriptionScreenState();
}

class _AskPrescriptionScreenState extends State<AskPrescriptionScreen> {
  UserDetail? _pharmacist;

  @override
  void initState() {
    super.initState();
    _fetchPharmacistData();
  }

  Future _fetchPharmacistData() async {
    // TODO: Get pharmacist of the given pharmacy

    int _pharmacistID = 5; // TODO: Change this to dynamic
    UserService _userService = new UserService();
    UserDetail? result = await _userService.getUserById(_pharmacistID);
    if (result != null) {
      setState(() => _pharmacist = result);
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.pharmacyName,
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: BottomNavBar(index: 0),
      body: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Spacer(),
            Text(
              "Welcome to",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              widget.pharmacyName,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              "Do you have a prescription?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: kDefaultPadding * 3),
            CustomBtn(
              text: "Yes",
              boxColor: kSuccessColor,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        ChatScreen(
                      peerId: _pharmacist!.id,
                      peerAvatar: _pharmacist!.image,
                      peerNickname: _pharmacist!.firstname,
                      role: "Pharmacist",
                    ),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
              textColor: Colors.white,
            ),
            SizedBox(height: kDefaultPadding),
            CustomBtn(
              text: "No",
              boxColor: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (buider, animation1, animation2) =>
                        ProductListScreen(
                      category: allCategories[0],
                      pharmacyId: widget.pharmacyId,
                      pharmacyName: widget.pharmacyName,
                    ),
                  ),
                );
              },
              textColor: Colors.white,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
