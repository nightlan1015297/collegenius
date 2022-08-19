part of 'eeclass_bullitin_detail_cubit.dart';

enum EeclassBullitinDetailCardStatus {
  loading,
  success,
  failed,
}

class EeclassBullitinDetailState extends Equatable {
  const EeclassBullitinDetailState({
    EeclassBullitinDetailCardStatus? detailCardStatus,
    EeclassBullitin? bullitinCardData,
  })  : detailCardStatus =
            detailCardStatus ?? EeclassBullitinDetailCardStatus.loading,
        bullitinCardData = bullitinCardData;
  final EeclassBullitinDetailCardStatus detailCardStatus;
  final EeclassBullitin? bullitinCardData;

  EeclassBullitinDetailState copyWith({
    EeclassBullitinDetailCardStatus? detailCardStatus,
    EeclassBullitin? bullitinCardData,
  }) {
    return EeclassBullitinDetailState(
      detailCardStatus: detailCardStatus ?? this.detailCardStatus,
      bullitinCardData: bullitinCardData ?? this.bullitinCardData,
    );
  }

  @override
  List<Object?> get props => [
        detailCardStatus,
        bullitinCardData,
      ];
}
