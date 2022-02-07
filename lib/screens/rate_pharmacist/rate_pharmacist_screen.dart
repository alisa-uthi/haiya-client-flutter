import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';
import 'widgets/rating_review_form.dart';

class RatePharmacistScreen extends StatefulWidget {
  static final routeName = '/rate-pharmacist';

  final int pharmacistId;

  const RatePharmacistScreen({
    Key? key,
    required this.pharmacistId,
  }) : super(key: key);

  @override
  _RatePharmacistScreenState createState() => _RatePharmacistScreenState();
}

class _RatePharmacistScreenState extends State<RatePharmacistScreen> {
  UserService _userService = new UserService();
  UserDetail? _pharmacist;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPharmacistData();
  }

  Future<void> _fetchPharmacistData() async {
    if (!mounted) return;

    UserDetail? result = await _userService.getUserById(widget.pharmacistId);

    if (result != null) {
      setState(() => _pharmacist = result);
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
          child: !_isLoading && _pharmacist != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: kDefaultPadding * 2),
                    Icon(
                      Icons.house_rounded,
                      size: 100,
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    HeaderText(text: "Pharmacist"),
                    HeaderText(
                        text:
                            "${_pharmacist!.firstname} ${_pharmacist!.lastname}"),
                    SizedBox(height: kDefaultPadding * 2),
                    RatingReviewForm(pharmacistId: _pharmacist!.id),
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
        "Rate Pharmacist",
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
    );
  }
}
