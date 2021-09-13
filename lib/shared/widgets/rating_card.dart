import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/rating.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/user_service.dart';

import 'custom_card.dart';
import 'loader.dart';

class RatingCard extends StatefulWidget {
  const RatingCard({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final Rating rating;

  @override
  _RatingCardState createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  UserService _userService = new UserService();
  UserDetail? _userDetail = null;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserDetail();
  }

  Future<void> _getUserDetail() async {
    UserDetail? result =
        await _userService.getUserById(widget.rating.patientId);

    if (mounted) {
      if (result != null) {
        setState(() => _userDetail = result);
      }
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ratingDetail = CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User name and profile image
            Row(
              children: [
                _builProfileImage(),
                SizedBox(width: kDefaultPadding / 2),
                Text(
                  '${_userDetail!.firstname} ${_userDetail!.lastname}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding / 1.5),

            // Feedback
            if (widget.rating.pharmacyFeedback! != '')
              Text(
                widget.rating.pharmacyFeedback!,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.clip,
                maxLines: 8,
              ),
            if (widget.rating.pharmacyFeedback! != '')
              SizedBox(height: kDefaultPadding / 2),

            // Rating score and timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRatingScore(),
                Text(
                  widget.rating.timestamp,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return !_isLoading
        ? _userDetail == null
            ? Center(child: Text("No Result Found."))
            : ratingDetail
        : Loader();
  }

  Widget _buildRatingScore() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber),
        SizedBox(width: 5),
        Text(
          '${widget.rating.pharmacyScore}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _builProfileImage() {
    return ClipOval(
      child: CachedNetworkImage(
        width: 35,
        height: 35,
        imageUrl: _userDetail!.image,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
