import 'package:collegenius/logic/cubit/eeclass_bullitin_list_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EeclassBullitinListView extends StatefulWidget {
  const EeclassBullitinListView({
    Key? key,
    required this.courseSerial,
  }) : super(key: key);

  final String courseSerial;

  @override
  State<EeclassBullitinListView> createState() =>
      _EeclassBullitinListViewState();
}

class _EeclassBullitinListViewState extends State<EeclassBullitinListView> {
  late EeclassBullitinListCubit eeclassBullitinListCubit;
  @override
  void initState() {
    eeclassBullitinListCubit = EeclassBullitinListCubit(
      courseSerial: widget.courseSerial,
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassBullitinListCubit.fetchInitBullitin();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return BlocProvider(
      create: (context) => eeclassBullitinListCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Course bullitins",
            style: _theme.textTheme.titleLarge,
          ),
          elevation: 0,
          iconTheme: _theme.iconTheme,
          backgroundColor: _theme.scaffoldBackgroundColor,
        ),
        body: BlocBuilder<EeclassBullitinListCubit, EeclassBullitinListState>(
          builder: (context, state) {
            switch (state.status) {
              case EeclassBullitinListStatus.initial:
              case EeclassBullitinListStatus.loading:
                return Center(child: Loading());
              case EeclassBullitinListStatus.success:
                return EeclassBullitinListViewSuccess();

              case EeclassBullitinListStatus.failure:
                return Center(
                  child: Text('Loaded Failed'),
                );
            }
          },
        ),
      ),
    );
  }
}

class EeclassBullitinListViewSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EeclassBullitinListCubit, EeclassBullitinListState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
                child: RefreshIndicator(
              onRefresh: () =>
                  context.read<EeclassBullitinListCubit>().fetchInitBullitin(),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.bullitins.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.bullitins.length) {
                      if (!state.isLoadedEnd) {
                        context
                            .read<EeclassBullitinListCubit>()
                            .fetchMoreBullitin();
                        return Center(child: Loading(size: 120));
                      } else {
                        return Card(
                          child: SizedBox(
                            height: 120,
                            child: Text("End"),
                          ),
                        );
                      }
                    }
                    var item = state.bullitins[index];

                    return EeclassBullitinCard(
                      bullitinBrief: item,
                    );
                  }),
            )),
          ],
        );
      },
    );
  }
}

class EeclassBullitinCard extends StatelessWidget {
  EeclassBullitinCard({
    Key? key,
    required this.bullitinBrief,
  }) : super(key: key);
  final EeclassBullitinBrief bullitinBrief;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: EdgeInsets.zero,
          child: SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          bullitinBrief.title,
                          style: _theme.textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: _theme.iconTheme.color,
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(children: [
                      SizedBox(
                        width: 130,
                        child: TextInformationProvider(
                            informationTextOverFlow: TextOverflow.ellipsis,
                            label: "發布時間",
                            information: bullitinBrief.date),
                      ),
                      VerticalSeperater(),
                      SizedBox(
                        width: 70,
                        child: TextInformationProvider(
                            informationTextOverFlow: TextOverflow.ellipsis,
                            label: "閱讀人數",
                            information: bullitinBrief.readCount),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 100,
                        child: TextInformationProvider(
                            informationTextOverFlow: TextOverflow.ellipsis,
                            label: "發布者",
                            information: bullitinBrief.auther),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
          elevation: 5.0,
        ),
      ),
    );
  }
}
