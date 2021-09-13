import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

import '../../constants.dart';

class NotificationScreen extends StatelessWidget {
  static final routeName = '/notification';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: BottomNavBar(index: 2),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(text: "Notification"),
            Text("Asdas"),
          ],
        ),
      ),
    );
  }
}
