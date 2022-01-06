import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

class ConsultationVideoScreen extends StatefulWidget {
  static final routeName = '/consultation';
  const ConsultationVideoScreen({
    Key? key,
    required this.pharmacyName,
  }) : super(key: key);

  final String pharmacyName;

  @override
  _ConsultationVideoScreenState createState() =>
      _ConsultationVideoScreenState();
}

class _ConsultationVideoScreenState extends State<ConsultationVideoScreen> {
  // You can use these to add more control over the meet
  String serverText = "";
  String roomText = "Consultation";
  String subjectText = "Consultation Meeting";
  String nameText = currentUser.firstname + " " + currentUser.lastname;
  String emailText = currentUser.email;

  // Self-explainable bools
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    // Adding a Listener
    JitsiMeet.addListener(JitsiMeetingListener(
      onConferenceWillJoin: _onConferenceWillJoin,
      onConferenceJoined: _onConferenceJoined,
      onConferenceTerminated: _onConferenceTerminated,
      onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
      onPictureInPictureTerminated: _onPictureInPictureTerminated,
      onError: _onError,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Consult with pharmacist",
          style: TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(flex: 80),
              Center(
                child: Text(
                  "Join the Meet",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 50),
              Text(
                "Pharmacy: ${widget.pharmacyName}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const Spacer(flex: 30),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xfff3f3f3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  initialValue: nameText,
                  maxLines: 1,
                  onChanged: (value) {
                    setState(() => nameText = value);
                  },
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.person, color: Colors.black),
                    hintText: "Your Name",
                  ),
                ),
              ),
              const Spacer(flex: 20),
              Container(
                child: Text(
                  "Meet Guidelines -\n1) For privacy reasons you may change your name if you want.\n2) By default your audio & video are muted.",
                  style: TextStyle(
                    fontSize: 14,
                    color: kGreyColor,
                  ),
                ),
              ),
              const Spacer(flex: 58),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _onAudioMutedChanged(!isAudioMuted);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: isAudioMuted
                                  ? kPrimaryColor
                                  : Color(0xffffffff),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.06),
                                    offset: Offset(0, 4)),
                              ]),
                          width: 72,
                          height: 72,
                          child: Icon(
                            isAudioMuted
                                ? Icons.mic_off_sharp
                                : Icons.mic_none_sharp,
                            color: isAudioMuted ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding / 1.5),
                      GestureDetector(
                        onTap: () {
                          _onVideoMutedChanged(!isVideoMuted);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: isVideoMuted
                                  ? kPrimaryColor
                                  : Color(0xffffffff),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.06),
                                    offset: Offset(0, 4)),
                              ]),
                          width: 72,
                          height: 72,
                          child: Icon(
                            isVideoMuted
                                ? Icons.videocam_off_sharp
                                : Icons.videocam,
                            color: isVideoMuted ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _joinMeeting(); // Join meet on tap
                    },
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            color: kSuccessColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.06),
                                  offset: Offset(0, 4)),
                            ]),
                        width: 174,
                        height: 72,
                        child: Center(
                          child: Text(
                            "JOIN MEET",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ],
              ),
              const Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
// Can use this, to add one more button which makes the meet Audio only.
  // _onAudioOnlyChanged(bool? value) {
  //   setState(() {
  //     isAudioOnly = value!;
  //   });
  // }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

// Defining Join meeting function
  _joinMeeting() async {
    // Using default serverUrl that is https://meet.jit.si/
    String? serverUrl = (serverText.trim().isEmpty ? null : serverText);

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      //uncomment to modify video resolution
      //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      // Define meetings options here
      var options = JitsiMeetingOptions(room: roomText)
        ..serverURL = serverUrl
        ..subject = subjectText
        ..userDisplayName = nameText
        ..userEmail = emailText
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      // Joining meet
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(
            onConferenceWillJoin: (Map<dynamic, dynamic> message) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: (Map<dynamic, dynamic> message) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: (Map<dynamic, dynamic> message) {
          debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: (Map<dynamic, dynamic> message) {
          debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: (Map<dynamic, dynamic> message) {
          debugPrint("${options.room} exited PIP mode with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
      // I added a 50 minutes time limit, you can remove it if you want.
      Future.delayed(const Duration(minutes: 50))
          .then((value) => JitsiMeet.closeMeeting());
    } catch (error) {
      debugPrint("error: $error");
    }
  }

// Define your own constraints
  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin(Map<dynamic, dynamic> message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(Map<dynamic, dynamic> message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(Map<dynamic, dynamic> message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  void _onPictureInPictureWillEnter(Map<dynamic, dynamic> message) {
    debugPrint(
        "_onPictureInPictureWillEnter broadcasted with message: $message");
  }

  void _onPictureInPictureTerminated(Map<dynamic, dynamic> message) {
    debugPrint(
        "_onPictureInPictureTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
