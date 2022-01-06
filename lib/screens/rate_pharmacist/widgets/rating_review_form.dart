import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/services/rating_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class RatingReviewForm extends StatefulWidget {
  const RatingReviewForm({
    Key? key,
    required this.pharmacistId,
  }) : super(key: key);

  final int pharmacistId;

  @override
  _RatingReviewFormState createState() => _RatingReviewFormState();
}

class _RatingReviewFormState extends State<RatingReviewForm> {
  int _rating = 5;
  String _feedback = '';
  FormFields _formFields = new FormFields();
  RatingService _ratingService = new RatingService();

  void _onSubmit() async {
    bool isRate = await _ratingService.ratePharmacist(
      pharmacistId: widget.pharmacistId,
      score: _rating,
      feedback: _feedback,
    );

    if (isRate) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomeScreen(),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    } else {
      CustomSnackBar.buildSnackbar(context, kGeneralError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rating
        RatingBar.builder(
          initialRating: 5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating.toInt());
            setState(() => _rating = rating.toInt());
          },
        ),
        SizedBox(height: kDefaultPadding),

        // Comment
        _formFields.buildTextField(
          "Comment",
          _feedback,
          (value) => setState(() {
            if (value != null) {
              setState(() => _feedback = value);
            }
          }),
        ),
        SizedBox(height: kDefaultPadding * 1.5),

        // Submit Button
        CustomBtn(
          text: "SUBMIT",
          boxColor: kSuccessColor,
          onPressed: _onSubmit,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
