import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';
import 'widgets/rating_review_form.dart';

class RateDriverScreen extends StatefulWidget {
  static final routeName = '/rate-driver';

  final int driverId;

  const RateDriverScreen({
    Key? key,
    required this.driverId,
  }) : super(key: key);

  @override
  _RateDriverScreenState createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  UserService _userService = new UserService();
  UserDetail? _driver;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDriverData();
  }

  Future<void> _fetchDriverData() async {
    if (!mounted) return;

    UserDetail? result = await _userService.getUserById(widget.driverId);

    if (result != null) {
      setState(() => _driver = result);
    } else {
      CustomSnackBar.buildSnackbar(context, kGeneralError);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: !_isLoading && _driver != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: kDefaultPadding * 2),
                    Icon(
                      Icons.directions_bike,
                      size: 100,
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    HeaderText(text: "Driver"),
                    HeaderText(
                        text: "${_driver!.firstname} ${_driver!.lastname}"),
                    SizedBox(height: kDefaultPadding * 2),
                    RatingReviewForm(driverId: _driver!.id),
                  ],
                )
              : Loader(),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Rate Driver",
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
    );
  }
}
