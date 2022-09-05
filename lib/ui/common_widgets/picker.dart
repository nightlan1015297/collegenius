import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatelessWidget {
  /// [currentItem] storages the index of the item that [Picker] is selected
  /// [Picker] will show the selected item in item list, makes user know what
  /// is the current state of picker.
  final int currentItem;

  /// Item list storage avalible item that user can select.
  /// When user want to change the selected item, A [ModalBottomSheet]
  /// which contains a [CupertinoPicker] will shows up. This variable, [itemlist]
  /// will be the options in [CupertinoPicker].
  final List<String> itemlist;

  /// [title] indicates the title of the picker, this provide user information that
  /// what they are going to pick.
  final String title;

  /// [onSelectedItemChanged] is the callback function that user has chaned the
  /// selected function, [Picker] will pass the new index of selected item to
  /// this function.
  final Function(int index) onSelectedItemChanged;

  const Picker({
    Key? key,
    required this.currentItem,
    required this.itemlist,
    required this.title,
    required this.onSelectedItemChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    int? selectedItem;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title + ' :'),
          SizedBox(height: 5),
          StatefulBuilder(builder: (context, setState) {
            return PhysicalModel(
              color: Colors.white,
              elevation: 5,
              shadowColor: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                    color: _theme.primaryColor,
                    border:
                        Border.all(color: _theme.textTheme.bodyLarge!.color!),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: InkWell(
                  child: SizedBox(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Spacer(),
                        Text(itemlist[currentItem],
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
                                  initialItem: currentItem);
                          return LayoutBuilder(builder: (context, constraints) {
                            final double height;
                            if (constraints.maxHeight < 250) {
                              height = constraints.maxHeight - 150;
                            } else {
                              height = 250;
                            }

                            return SizedBox(
                                height: height,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CupertinoPicker(
                                      scrollController: scrollController,
                                      looping: false,
                                      children: itemlist
                                          .map((item) => Center(
                                                  child: Text(
                                                item,
                                                style:
                                                    _theme.textTheme.headline5,
                                              )))
                                          .toList(),
                                      itemExtent: 50,
                                      onSelectedItemChanged: (index) =>
                                          selectedItem = index),
                                ));
                          });
                        }).whenComplete(() {
                      setState(() => FixedExtentScrollController(
                          initialItem: selectedItem ?? currentItem));
                      onSelectedItemChanged(selectedItem ?? currentItem);
                    })
                  },
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
