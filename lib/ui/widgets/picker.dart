import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title + ' :'),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: InkWell(
            child: Row(
              children: [
                SizedBox(width: 15),
                Text(itemlist[currentItem], style: _theme.textTheme.headline6),
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
                  backgroundColor: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  context: context,
                  builder: (context) => PopOutPicker(
                      currentItem: currentItem,
                      itemlist: itemlist,
                      onSelectedItemChanged: onSelectedItemChanged))
            },
          ),
        ),
      ],
    );
  }
}

class PopOutPicker extends StatefulWidget {
  final int currentItem;
  final List<String> itemlist;
  final Function onSelectedItemChanged;

  PopOutPicker({
    Key? key,
    required this.currentItem,
    required this.itemlist,
    required this.onSelectedItemChanged,
  }) : super(key: key);

  @override
  State<PopOutPicker> createState() => _PopOutPickerState(currentItem);
}

class _PopOutPickerState extends State<PopOutPicker> {
  final int currentItem;
  late FixedExtentScrollController scrollController;

  _PopOutPickerState(this.currentItem);

  @override
  void initState() {
    scrollController = FixedExtentScrollController(initialItem: currentItem);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
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
                widget.onSelectedItemChanged(index)),
      ),
    );
  }
}
