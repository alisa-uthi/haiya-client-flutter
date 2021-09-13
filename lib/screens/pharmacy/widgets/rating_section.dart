import 'package:flutter/material.dart';
import 'package:haiya_client/screens/ratings/rating_screen.dart';
import 'package:haiya_client/shared/models/rating.dart';
import 'package:haiya_client/shared/widgets/rating_card.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import '../../../constants.dart';

class RatingSection extends StatefulWidget {
  const RatingSection({
    Key? key,
    required this.ratings,
    required this.pharmacyName,
  }) : super(key: key);

  final List<Rating> ratings;
  final String pharmacyName;

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  bool _isLotsOfRatings() {
    return widget.ratings.length > 3;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: "Rating and Reviews",
          moreText: _isLotsOfRatings() ? "See more" : '',
          onMoreTap: _isLotsOfRatings()
              ? () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          RatingScreen(
                        ratings: widget.ratings,
                        pharmacyName: widget.pharmacyName,
                      ),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                }
              : () {},
        ),
        SizedBox(height: kDefaultPadding / 2),
        ...List.generate(_isLotsOfRatings() ? 3 : widget.ratings.length,
            (index) {
          var rating = widget.ratings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding / 1.5),
            child: RatingCard(rating: rating),
          );
        }),
        SizedBox(height: kDefaultPadding * 1.5),
      ],
    );
  }
}
