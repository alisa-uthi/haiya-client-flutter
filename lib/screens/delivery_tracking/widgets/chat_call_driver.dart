import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/chat/chat_screen.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatCallDriver extends StatefulWidget {
  final int driverId;

  const ChatCallDriver({
    Key? key,
    required this.driverId,
  }) : super(key: key);

  @override
  _ChatCallDriverState createState() => _ChatCallDriverState();
}

class _ChatCallDriverState extends State<ChatCallDriver> {
  UserDetail? _driver;

  @override
  void initState() {
    super.initState();
    _fetchDriverData();
  }

  Future _fetchDriverData() async {
    UserService _userService = new UserService();

    UserDetail? result = await _userService.getUserById(widget.driverId);
    if (result != null) {
      setState(() => _driver = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _driver != null
        ? Row(
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            ChatScreen(
                          peerId: _driver!.id,
                          peerAvatar: _driver!.image,
                          peerNickname: _driver!.firstname,
                        ),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  }, //TODO: Change this
                  icon: Icon(
                    Icons.chat_rounded,
                    size: 25,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
