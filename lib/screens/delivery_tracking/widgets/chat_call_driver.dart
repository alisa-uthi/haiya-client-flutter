import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatCallDriver extends StatelessWidget {
  const ChatCallDriver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: kGreyColor.withOpacity(0.2),
          radius: 20,
          child: IconButton(
            onPressed: () => launch("tel://0804488048"),
            icon: Icon(
              Icons.call,
              size: 25,
              color: Colors.black54,
            ),
          ),
        ),
        SizedBox(width: kDefaultPadding / 1.5),
        CircleAvatar(
          backgroundColor: kGreyColor.withOpacity(0.2),
          radius: 20,
          child: IconButton(
            onPressed: () => launch("tel://0804488048"), //TODO: Change this
            icon: Icon(
              Icons.chat_rounded,
              size: 25,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
