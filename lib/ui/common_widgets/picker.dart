import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  final int currentItem;

  final List<String> itemlist;
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
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    int? selectedItem;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title + ' :'),
          SizedBox(height: 5),
          StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: _theme.textTheme.bodyLarge!.color!),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: InkWell(
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Spacer(),
                      Text(widget.itemlist[widget.currentItem].toString(),
                          style: _theme.textTheme.titleLarge),
                      Spacer(),
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
                ),
                onTap: () => {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: _theme.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      context: context,
                      builder: (context) {
                        FixedExtentScrollController scrollController =
                            FixedExtentScrollController(
                                initialItem: widget.currentItem);

                        return SizedBox(
                            height: 320,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CupertinoPicker(
                                  scrollController: scrollController,
                                  looping: false,
                                  children: widget.itemlist
                                      .map((item) => Center(
                                              child: Text(
                                            item,
                                            style: _theme.textTheme.headline5,
                                          )))
                                      .toList(),
                                  itemExtent: 50,
                                  onSelectedItemChanged: (index) =>
                                      selectedItem = index),
                            ));
                      }).whenComplete(() {
                    setState(() => FixedExtentScrollController(
                        initialItem: selectedItem ?? widget.currentItem));
                    widget.onSelectedItemChanged(
                        selectedItem ?? widget.currentItem);
                  })
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
