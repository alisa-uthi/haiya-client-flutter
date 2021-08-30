import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String gender = currentUser.gender == 'M'
        ? "Male"
        : currentUser.gender == 'F'
            ? "Female"
            : "Other";

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Column(
          children: [
            _buildTitleText(['Name', 'Surname']),
            _buildSubtitleText([currentUser.firstname, currentUser.lastname]),
            _buildTitleText(['Date of Birth', 'Gender']),
            _buildSubtitleText([currentUser.dob, gender]),
            _buildTitleText(['Phone Number', 'Height(cm)', 'Weight(kg)']),
            _buildSubtitleText([
              currentUser.phone,
              currentUser.height.toString(),
              currentUser.weight.toString()
            ]),
            _buildTextList('Drug Allergies', currentUser.drugAllergy!),
            _buildTextList(
              'Congenital Disease',
              currentUser.congenitalDisease!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextList(String title, List<dynamic> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText([title]),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
          child: list.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentUser.drugAllergy!.length,
                  itemBuilder: (context, index) {
                    var item = list[index];
                    return _buildInfoText('- ${item.name!}');
                  },
                )
              : _buildInfoText('None'),
        ),
      ],
    );
  }

  Widget _buildTitleText(List<String> titles) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        children: [
          ...List.generate(titles.length, (index) {
            return Expanded(
              child: Text(
                titles[index],
                style: TextStyle(
                  color: kGreyColor,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubtitleText(List<String> subtitles) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Row(
        children: [
          ...List.generate(
            subtitles.length,
            (index) {
              return Expanded(
                child: _buildInfoText(subtitles[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
