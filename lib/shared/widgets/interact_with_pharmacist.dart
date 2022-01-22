import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/chat/chat_screen.dart';
import 'package:haiya_client/screens/consultation/consultation_video_screen.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/provider/request_consult_provider.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:provider/src/provider.dart';

class InteractWithPharmacist extends StatefulWidget {
  const InteractWithPharmacist({
    Key? key,
    required this.pharmacyId,
    required this.pharmacyName,
  }) : super(key: key);

  final int pharmacyId;
  final String pharmacyName;

  @override
  State<InteractWithPharmacist> createState() => _InteractWithPharmacistState();
}

class _InteractWithPharmacistState extends State<InteractWithPharmacist> {
  late RequestConsulProvider requestConsulProvider;

  UserDetail? _pharmacist;

  @override
  void initState() {
    super.initState();
    _fetchPharmacistData();
    requestConsulProvider = context.read<RequestConsulProvider>();
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

  _onSendRequest() {
    requestConsulProvider.sendRequest(currentUser.id, widget.pharmacyId);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildConsultationBtn(context),
        _buildChatBtn(context),
      ],
    );
  }

  GestureDetector _buildConsultationBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onSendRequest();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ConsultationVideoScreen(pharmacyName: widget.pharmacyName),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          color: kSuccessColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.meeting_room,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Meeting Room",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildChatBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onSendRequest();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ChatScreen(
              peerId: _pharmacist!.id,
              peerAvatar: _pharmacist!.image,
              peerNickname: _pharmacist!.firstname,
              role: "Pharmacist",
            ),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          color: kSuccessColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_rounded,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
