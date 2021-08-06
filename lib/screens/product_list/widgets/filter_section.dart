import 'package:flutter/material.dart';

import '../../../constants.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({
    Key? key,
  }) : super(key: key);

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.price_change,
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  Text(
                    "Product: Sort By A to Z",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.price_change,
                ),
                SizedBox(width: kDefaultPadding / 2),
                Text(
                  "Price: Lowest to Highest",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
