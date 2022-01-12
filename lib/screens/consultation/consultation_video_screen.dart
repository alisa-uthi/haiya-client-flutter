import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/provider/request_consult_provider.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:provider/src/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
  List<QueryDocumentSnapshot> listRequest = [];

  // Self-explainable bools
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  late RequestConsulProvider requestConsulProvider;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

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
    requestConsulProvider = context.read<RequestConsulProvider>();
  }

  @override
  void dispose() async {
    super.dispose();
    JitsiMeet.removeAllListeners();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Consult with pharmacist",
            style: TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: requestConsulProvider.getConsultRoomStream(currentUser.id),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              listRequest = snapshot.data!.docs;
              if (listRequest.length > 0) {
                var request = listRequest[listRequest.length - 1];
                var requestStatus = request.get("requestStatus");
                if (request.get("requestStatus") == "requested") {
                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);

                  return Center(
                    child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          children: [
                            Spacer(),
                            CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: kPrimaryColor,
                              color: kBackgroundColor,
                            ),
                            SizedBox(height: kDefaultPadding),
                            Text(
                              "Waiting for request acceptance...",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            StreamBuilder<int>(
                              stream: _stopWatchTimer.rawTime,
                              initialData: 0,
                              builder: (context, snap) {
                                final value = snap.data;
                                final displayTime =
                                    StopWatchTimer.getDisplayTime(value!);
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding),
                                  child: Text(
                                    "Time: $displayTime",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Spacer(),
                            CustomBtn(
                              text: "Cancel Request",
                              boxColor: kErrorColor,
                              onPressed: () {
                                requestConsulProvider.updateDataFirestore(
                                  request.id,
                                  {"requestStatus": "cancelled"},
                                );

                                CustomSnackBar.buildSnackbar(
                                  context,
                                  "The request has been cancelled",
                                );

                                Navigator.pop(context);
                              },
                              textColor: Colors.white,
                            ),
                            SizedBox(height: kDefaultPadding),
                          ],
                        )),
                  );
                }
                if (requestStatus == "accepted") {
                  roomText = request.get("room");
                  return SingleChildScrollView(
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 8, 0, 0),
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon:
                                    Icon(Icons.person, color: Colors.black),
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.06),
                                                offset: Offset(0, 4)),
                                          ]),
                                      width: 72,
                                      height: 72,
                                      child: Icon(
                                        isAudioMuted
                                            ? Icons.mic_off_sharp
                                            : Icons.mic_none_sharp,
                                        color: isAudioMuted
                                            ? Colors.white
                                            : Colors.black,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.06),
                                                offset: Offset(0, 4)),
                                          ]),
                                      width: 72,
                                      height: 72,
                                      child: Icon(
                                        isVideoMuted
                                            ? Icons.videocam_off_sharp
                                            : Icons.videocam,
                                        color: isVideoMuted
                                            ? Colors.white
                                            : Colors.black,
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
                                              color: Colors.black
                                                  .withOpacity(0.06),
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
                  );
                }
                if (requestStatus == "cancelled")
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            "You have already cancelled the request.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          CustomBtn(
                            text: "Go Back to Home",
                            boxColor: kPrimaryColor,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          HomeScreen(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                            },
                            textColor: Colors.white,
                          ),
                          SizedBox(height: kDefaultPadding),
                        ],
                      ),
                    ),
                  );
                if (requestStatus == "declined")
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            "The request has been declined.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: kErrorColor,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 2),
                          if (request.get("remark") != null &&
                              request.get("remark") != "")
                            Padding(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              child: Text("Remark: ${request.get("remark")}"),
                            ),
                          Spacer(),
                          CustomBtn(
                            text: "Go Back to Home",
                            boxColor: kPrimaryColor,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          HomeScreen(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                            },
                            textColor: Colors.white,
                          ),
                          SizedBox(height: kDefaultPadding),
                        ],
                      ),
                    ),
                  );
                else
                  return Loader();
              } else {
                return Container();
              }
            } else {
              return Center(child: Loader());
            }
          },
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
      Future.delayed(const Duration(minutes: 50)).then((value) => {
            JitsiMeet.closeMeeting(),
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    ProductListScreen(
                  category: allCategories[0],
                  pharmacyName: widget.pharmacyName,
                ),
                transitionDuration: Duration(seconds: 0),
              ),
            )
          });
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
    Navigator.pop(context);
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
