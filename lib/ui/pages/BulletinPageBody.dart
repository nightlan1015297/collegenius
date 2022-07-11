import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collegenius/logic/cubit/school_events_cubit.dart';
import 'package:collegenius/ui/widgets/information_provider.dart';
import 'package:collegenius/ui/widgets/tag_widget.dart';

Map<String, Color> eventCategoryToColor = {
  '行政': Colors.blueAccent,
  '活動': Colors.orangeAccent,
  '徵才': Colors.greenAccent,
  '演講': Colors.amber,
  '施工': Colors.deepPurpleAccent
};

class BulletinPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Builder(builder: (context) {
        var _schoolEventsState = context.watch<SchoolEventsCubit>().state;
        switch (_schoolEventsState.status) {
          case SchoolEventsStatus.initial:
            context.read<SchoolEventsCubit>().fetchInitEvents();
            return Center(
              child: Text('Loading'),
            );
          case SchoolEventsStatus.loading:
            return Center(
              child: Text('Loading'),
            );
          case SchoolEventsStatus.success:
            return Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () =>
                      context.read<SchoolEventsCubit>().fetchInitEvents(),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: _schoolEventsState.events.length + 1,
                      itemExtent: 145,
                      itemBuilder: (context, index) {
                        if (index == _schoolEventsState.events.length) {
                          context.read<SchoolEventsCubit>().fetchMoreEvents();
                          return Center(
                            child: Text('Loading'),
                          );
                        }
                        var item = _schoolEventsState.events[index];

                        return Container(
                          margin: EdgeInsets.all(4),
                          child: EventCard(
                            category: item.category ?? 'Load Failed',
                            group: item.group ?? 'Load Failed',
                            time: item.time ?? 'Load Failed',
                            title: item.title ?? 'Load Failed',
                          ),
                        );
                      }),
                )),
              ],
            );
          case SchoolEventsStatus.failure:
            return Center(
              child: Text('Loading'),
            );
          case SchoolEventsStatus.loadedend:
            return Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  displacement: 30,
                  onRefresh: () =>
                      context.read<SchoolEventsCubit>().fetchInitEvents(),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: _schoolEventsState.events.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _schoolEventsState.events.length) {
                          context.read<SchoolEventsCubit>().fetchMoreEvents();
                          return SizedBox(
                              height: 30,
                              child: Center(child: Text('End of bulletin')));
                        }
                        var item = _schoolEventsState.events[index];

                        return SizedBox(
                          child: Container(
                            height: 145,
                            margin: EdgeInsets.all(4),
                            child: EventCard(
                              category: item.category ?? 'Load Failed',
                              group: item.group ?? 'Load Failed',
                              time: item.time ?? 'Load Failed',
                              title: item.title ?? 'Load Failed',
                            ),
                          ),
                        );
                      }),
                )),
              ],
            );
        }
      }),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String category;
  final String group;
  final String time;
  const EventCard({
    Key? key,
    required this.title,
    required this.category,
    required this.group,
    required this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Card(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(title,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _theme.textTheme.headline6),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Tag(
                        color: eventCategoryToColor[category] ?? Colors.grey,
                        tagText: category,
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 0,
                            minWidth: 0,
                            maxHeight: double.infinity,
                            maxWidth: 150,
                          ),
                          child: Tag(
                            color: Colors.grey,
                            tagText: group,
                          )),
                      Expanded(child: SizedBox()),
                      InformationProvider(
                        mainAxisAlignment: MainAxisAlignment.end,
                        information: time,
                        label: '發布日期',
                        informationTexttheme: _theme.textTheme.subtitle2,
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    ));
  }
}
