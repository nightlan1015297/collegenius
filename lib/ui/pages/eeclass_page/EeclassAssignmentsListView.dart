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
                final assignmentInfoBrief = assignmentList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EeclassAssignmentCard(
                      assignmentTitle: assignmentInfoBrief.title,
                      assignmentScore:
                          assignmentInfoBrief.score?.round().toString() ?? "-",
                      assignmentDeadline: assignmentInfoBrief.deadline,
                      assignmentIsHandedOn: assignmentInfoBrief.isHandedOn,
                      assignmentUrl: assignmentInfoBrief.url),
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
  final String assignmentTitle;
  final String assignmentScore;
  final String assignmentUrl;
  final String assignmentDeadline;
  final bool assignmentIsHandedOn;
  EeclassAssignmentCard({
    required this.assignmentTitle,
    required this.assignmentScore,
    required this.assignmentDeadline,
    required this.assignmentUrl,
    required this.assignmentIsHandedOn,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constrains) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.all(10),
              width: constrains.maxWidth - 20,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          assignmentTitle,
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
                            information: assignmentDeadline),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 80,
                        child: IconInformationProvider(
                            label: "繳交狀態",
                            informationIcon: assignmentIsHandedOn
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
                            information: assignmentScore),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            elevation: 5.0,
          ),
        );
      },
    );
  }
}
