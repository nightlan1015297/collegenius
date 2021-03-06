import 'package:collegenius/models/semester_model/semester_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatelessWidget {
  final int currentItem;

  final List<dynamic> itemlist;
  final String title;
  final Function onSelectedItemChanged;
  const Picker({
    Key? key,
    required this.currentItem,
    required this.itemlist,
    required this.title,
    required this.onSelectedItemChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: currentItem);
    final _theme = Theme.of(context);
    int? selectedItem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title + ' :'),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: _theme.textTheme.bodyLarge!.color!),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: InkWell(
            child: Row(
              children: [
                SizedBox(width: 15),
                Text(itemlist[currentItem].value,
                    style: _theme.textTheme.titleLarge),
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(1),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: _theme.iconTheme.color,
                    size: 30,
                  ),
                ),
              ],
            ),
            onTap: () => {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: _theme.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  context: context,
                  builder: (context) => SizedBox(
                      height: 320,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: CupertinoPicker(
                            scrollController: scrollController,
                            looping: false,
                            children: itemlist
                                .map((item) => Center(
                                        child: Text(
                                      item.value,
                                      style: _theme.textTheme.headline5,
                                    )))
                                .toList(),
                            itemExtent: 50,
                            onSelectedItemChanged: (index) =>
                                selectedItem = index),
                      ))).whenComplete(
                  () => {onSelectedItemChanged(selectedItem ?? currentItem)})
            },
          ),
        ),
      ],
    );
  }
}
