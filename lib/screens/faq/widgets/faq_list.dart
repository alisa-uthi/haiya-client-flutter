import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/faq_item.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

class FaqList extends StatefulWidget {
  const FaqList({Key? key}) : super(key: key);

  @override
  _FaqListState createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  List<FaqItem> _faqList = [];

  @override
  void initState() {
    super.initState();
    // if (!mounted) return;

    setState(() {
      _faqList = ConstantService.dummyFaqList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _faqList.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _faqList.length,
            itemBuilder: (context, index) {
              var item = _faqList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: kDefaultPadding / 1.5),
                child: ExpansionPanelList(
                  elevation: 0,
                  children: [_buildFaqItem(item)],
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      item.expanded = !item.expanded;
                    });
                  },
                ),
              );
            },
          )
        : Loader();
  }

  ExpansionPanel _buildFaqItem(FaqItem item) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            item.headerItem,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.clip,
            maxLines: 3,
          ),
        );
      },
      body: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(
          kDefaultPadding,
          0,
          kDefaultPadding,
          kDefaultPadding,
        ),
        title: Text(
          item.discription,
          overflow: TextOverflow.clip,
          maxLines: 5,
        ),
      ),
      canTapOnHeader: true,
      isExpanded: item.expanded,
    );
  }
}
