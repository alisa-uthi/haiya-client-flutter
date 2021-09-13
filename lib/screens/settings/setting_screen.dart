import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/change_password_panel.dart';
import 'widgets/setting_options.dart';

class SettingScreen extends StatefulWidget {
  static final routeName = '/settings';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 0;
  PanelController _pc = new PanelController();

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .72;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Stack(
          children: [
            SlidingUpPanel(
              controller: _pc,
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              backdropEnabled: true,
              color: kBackgroundColor,
              body: _body(context),
              panelBuilder: (sc) => ChangePasswordPanel(
                scrollController: sc,
                closePanel: () => _pc.close(),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding * 2),
                topRight: Radius.circular(kDefaultPadding * 2),
              ),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - 0) + _initFabHeight;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText(text: "Setting"),
          SettingOptions(onClickChangePass: () => _pc.open()),
        ],
      ),
    );
  }
}
