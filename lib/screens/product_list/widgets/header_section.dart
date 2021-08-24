import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/category.dart';

import '../../../constants.dart';
import 'category_list.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

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
            selectedCategory: category,
          ),
          // SizedBox(height: kDefaultPadding / 2),
          // FilterSection(), TODO: Implement filter
        ],
      ),
    );
  }
}
