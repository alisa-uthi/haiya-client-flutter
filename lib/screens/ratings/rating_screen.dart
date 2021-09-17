import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/rating.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/widgets/rating_card.dart';

class RatingScreen extends StatelessWidget {
  static final routeName = '/ratings';

  final List<Rating> ratings;
  final String pharmacyName;

  const RatingScreen({
    Key? key,
    required this.ratings,
    required this.pharmacyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(text: pharmacyName),
              Text(
                "Rating and Reviews",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: kDefaultPadding),
              if (ratings.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      var rating = ratings[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: kDefaultPadding / 2),
                        child: RatingCard(rating: rating),
                      );
                    })
              else
                Loader()
            ],
          ),
        ),
      ),
    );
  }
}
