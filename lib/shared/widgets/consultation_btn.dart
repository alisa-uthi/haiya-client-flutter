import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/consultation/consultation_video_screen.dart';

class ConsultationBtn extends StatelessWidget {
  const ConsultationBtn({
    Key? key,
    required this.pharmacyName,
  }) : super(key: key);

  final String pharmacyName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              ConsultationVideoScreen(pharmacyName: pharmacyName),
          transitionDuration: Duration(seconds: 0),
        ),
      ),
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
