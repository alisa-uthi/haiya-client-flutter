import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/consultation/consultation_video_screen.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/provider/request_consult_provider.dart';
import 'package:provider/src/provider.dart';

class ConsultationBtn extends StatefulWidget {
  const ConsultationBtn({
    Key? key,
    required this.pharmacyId,
    required this.pharmacyName,
  }) : super(key: key);

  final int pharmacyId;
  final String pharmacyName;

  @override
  State<ConsultationBtn> createState() => _ConsultationBtnState();
}

class _ConsultationBtnState extends State<ConsultationBtn> {
  late RequestConsulProvider requestConsulProvider;

  @override
  void initState() {
    super.initState();
    requestConsulProvider = context.read<RequestConsulProvider>();
  }

  _onSendRequest() {
    requestConsulProvider.sendRequest(currentUser.id, widget.pharmacyId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   PageRouteBuilder(
      //     pageBuilder: (context, animation1, animation2) =>
      //         ConsultationVideoScreen(pharmacyName: widget.pharmacyName),
      //     transitionDuration: Duration(seconds: 0),
      //   ),
      // ),
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
        width: MediaQuery.of(context).size.width / 1.5,
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
              "Consult with pharmacist",
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
