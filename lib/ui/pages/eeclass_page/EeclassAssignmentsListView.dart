import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';

class EeclassAssignmentsListView extends StatelessWidget {
  final List<EeclassAssignmentBrief> assignmentList;
  const EeclassAssignmentsListView({
    Key? key,
    required this.assignmentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assignment overview",
          style: _theme.textTheme.titleLarge,
        ),
        elevation: 0,
        iconTheme: _theme.iconTheme,
        backgroundColor: _theme.scaffoldBackgroundColor,
      ),
      body: Builder(builder: (context) {
        if (assignmentList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: assignmentList.length,
              itemBuilder: (context, index) {
                final assignmentBrief = assignmentList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      EeclassAssignmentCard(assignmentBrief: assignmentBrief),
                );
              },
            ),
          );
        } else
          return Center(child: Text("沒有資料"));
      }),
    );
  }
}

class EeclassAssignmentCard extends StatelessWidget {
  final EeclassAssignmentBrief assignmentBrief;
  EeclassAssignmentCard({
    required this.assignmentBrief,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/eeclassCourse/assignments/popup',
            arguments: EeclassAssignmentsPopupArguments(
              assignmentBrief: assignmentBrief,
            ));
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      assignmentBrief.title,
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
                    width: 140,
                    child: TextInformationProvider(
                        informationTextOverFlow: TextOverflow.ellipsis,
                        label: "繳交期限",
                        information: assignmentBrief.deadline),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 80,
                    child: IconInformationProvider(
                        label: "繳交狀態",
                        informationIcon: assignmentBrief.isHandedOn
                            ? Icon(
                                Icons.check_circle_outline,
                                size: 22,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.cancel_outlined,
                                size: 22,
                                color: Colors.red,
                              )),
                  ),
                  VerticalSeperater(),
                  SizedBox(
                    width: 40,
                    child: TextInformationProvider(
                        informationTextOverFlow: TextOverflow.ellipsis,
                        label: "分數",
                        information:
                            assignmentBrief.score?.round().toString() ?? ""),
                  ),
                ]),
              )
            ],
          ),
        ),
        elevation: 5.0,
      ),
    );
  }
}
