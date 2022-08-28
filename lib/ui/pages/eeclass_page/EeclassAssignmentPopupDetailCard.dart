import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/cubit/eeclass_assignment_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:collegenius/ui/pages/eeclass_page/EeclassAttachmentTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EeclassAssignmentPopupDetailCard extends StatefulWidget {
  const EeclassAssignmentPopupDetailCard({
    Key? key,
    required this.assignmentBrief,
  }) : super(key: key);

  final EeclassAssignmentBrief assignmentBrief;

  @override
  State<EeclassAssignmentPopupDetailCard> createState() =>
      _EeclassAssignmentPopupDetailCardState();
}

class _EeclassAssignmentPopupDetailCardState
    extends State<EeclassAssignmentPopupDetailCard> {
  late EeclassAssignmentDetailCubit eeclassAssignmentDetailCubit;
  @override
  void initState() {
    eeclassAssignmentDetailCubit = EeclassAssignmentDetailCubit(
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassAssignmentDetailCubit.onOpenPopupAssignmentCardRequest(
        assignmentUrl: widget.assignmentBrief.url);
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => eeclassAssignmentDetailCubit,
      child: BlocBuilder<EeclassAssignmentDetailCubit,
          EeclassAssignmentDetailState>(
        builder: (context, state) {
          switch (state.detailCardStatus) {
            case EeclassAssignmentDetailCardStatus.loading:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 450, maxHeight: 600),
                      child: Loading(),
                    ),
                  ),
                ),
              );

            case EeclassAssignmentDetailCardStatus.success:
              return EeclassPopUpAssignmentDetailSuccessCard(
                assignmentBrief: widget.assignmentBrief,
                assignmentDetail: state.assignmentCardData!,
              );
            case EeclassAssignmentDetailCardStatus.failed:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 450, maxHeight: 600),
                      child: Text("Failed"),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class EeclassPopUpAssignmentDetailSuccessCard extends StatelessWidget {
  const EeclassPopUpAssignmentDetailSuccessCard({
    Key? key,
    required this.assignmentBrief,
    required this.assignmentDetail,
  }) : super(key: key);

  final EeclassAssignmentBrief assignmentBrief;
  final EeclassAssignment assignmentDetail;
  Widget _assignmentInformationWidgetBuilder(
      {required EeclassAssignment assignInfo,
      required EeclassAssignmentBrief assignBrief,
      required BuildContext context}) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    var _widgetList = <Widget>[];
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.assignmentTitle,
          information: assignBrief.title,
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.avaliableToUploadTime,
          information: assignBrief.startHandInDate,
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: _locale.deadline,
          information: assignBrief.deadline,
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: _locale.scooringMethod,
              information: assignmentDetail.gradingMethod ?? "_",
              informationTexttheme: _theme.textTheme.bodyLarge,
              informationTextOverFlow: TextOverflow.visible,
            ),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
              label: _locale.score,
              information: assignmentBrief.score?.round().toString() ?? "-",
              informationTextOverFlow: TextOverflow.visible,
            ),
          )
        ],
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
          label: '內容',
          information: assignmentDetail.description ?? "-",
          informationTexttheme: _theme.textTheme.bodyLarge,
          informationTextOverFlow: TextOverflow.visible,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_locale.assignmentInformation,
                              style: _theme.textTheme.titleLarge,
                              textAlign: TextAlign.start),
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        child: IconButton(
                          icon: Icon(Icons.close, size: 30),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            _assignmentInformationWidgetBuilder(
                                assignInfo: assignmentDetail,
                                assignBrief: assignmentBrief,
                                context: context),
                            EeclassAttachmentTile(
                              fileList: assignmentDetail.fileList ?? [],
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
