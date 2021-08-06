import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'category_list.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kGreyColor.withOpacity(0.5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          CategoryList(
            selectedCategory: categoryName,
          ),
          // SizedBox(height: kDefaultPadding / 2),
          // FilterSection(), TODO: Implement filter
        ],
      ),
    );
  }
}
