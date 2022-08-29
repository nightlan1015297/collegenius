import 'package:collegenius/ui/pages/eeclass_page/EeclassAttachmentTile.dart';
import 'package:collegenius/ui/scaffolds/HeroDialogScaffold.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collegenius/constants/Constants.dart';

import 'package:collegenius/logic/cubit/eeclass_bullitin_detail_cubit.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EeclassBullitinPopupDetailCard extends StatefulWidget {
  const EeclassBullitinPopupDetailCard({
    Key? key,
    required this.bullitinBrief,
  }) : super(key: key);
  final EeclassBullitinBrief bullitinBrief;
  @override
  State<EeclassBullitinPopupDetailCard> createState() =>
      _EeclassBullitinPopupDetailCardState();
}

class _EeclassBullitinPopupDetailCardState
    extends State<EeclassBullitinPopupDetailCard> {
  late EeclassBullitinDetailCubit eeclassBullitinDetailCubit;

  @override
  void initState() {
    eeclassBullitinDetailCubit = EeclassBullitinDetailCubit(
      eeclassRepository: context.read<EeclassRepository>(),
    );
    eeclassBullitinDetailCubit.onOpenPopupBullitinCardRequest(
      bullitinUrl: widget.bullitinBrief.url,
    );
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => eeclassBullitinDetailCubit,
      child:
          BlocBuilder<EeclassBullitinDetailCubit, EeclassBullitinDetailState>(
        builder: (context, state) {
          switch (state.detailCardStatus) {
            case EeclassBullitinDetailCardStatus.loading:
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
            case EeclassBullitinDetailCardStatus.success:
              return EeclassBullitinDetailedSuccessCard(
                bullitinBrief: widget.bullitinBrief,
                bullitinDetail: state.bullitinCardData!,
              );
            case EeclassBullitinDetailCardStatus.failed:
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

class EeclassBullitinDetailedSuccessCard extends StatelessWidget {
  const EeclassBullitinDetailedSuccessCard({
    Key? key,
    required this.bullitinBrief,
    required this.bullitinDetail,
  }) : super(key: key);

  final EeclassBullitinBrief bullitinBrief;
  final EeclassBullitin bullitinDetail;

  Widget _bullitinBriefBuilder({
    required EeclassBullitinBrief bullitinBrief,
    required BuildContext context,
  }) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    var _widgetList = <Widget>[];
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
            informationTextOverFlow: TextOverflow.visible,
            informationTexttheme: _theme.textTheme.bodyLarge,
            label: _locale.bullitinTitle,
            information: bullitinBrief.title),
      ),
    );
    _widgetList.add(Divider());
    _widgetList.add(
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
                informationTextOverFlow: TextOverflow.visible,
                informationTexttheme: _theme.textTheme.bodyLarge,
                label: _locale.publicationDate,
                information: bullitinBrief.date),
          ),
          VerticalSeperater(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInformationProvider(
                informationTextOverFlow: TextOverflow.visible,
                informationTexttheme: _theme.textTheme.bodyLarge,
                label: _locale.readCount,
                information: bullitinBrief.readCount),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _widgetList,
    );
  }

  Widget _bullitinBuilder({
    required EeclassBullitin bullitinDetail,
    required BuildContext context,
  }) {
    final _locale = AppLocalizations.of(context)!;
    var _widgetList = <Widget>[];
    _widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextInformationProvider(
            informationTextOverFlow: TextOverflow.visible,
            informationTexttheme: Theme.of(context).textTheme.bodyLarge,
            selectable: true,
            label: _locale.content,
            information: bullitinDetail.content.join("")),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _widgetList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return HeroDialogScaffold(
      child: Center(
        child: GestureDetector(
          onTap: () {
            /// Do nothing to cancel Navigator pop in HeroDialogScaffold
            /// prevent un neccesary pop when touch the pop up content
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                              child: Text(_locale.bullitinInformation,
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
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              _bullitinBriefBuilder(
                                bullitinBrief: bullitinBrief,
                                context: context,
                              ),
                              Divider(),
                              _bullitinBuilder(
                                context: context,
                                bullitinDetail: bullitinDetail,
                              ),
                              Divider(),
                              EeclassAttachmentTile(
                                fileList: bullitinDetail.fileList,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
