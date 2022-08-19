part of 'eeclass_material_detail_cubit.dart';

class EeclassMaterialDetailState extends Equatable {
  const EeclassMaterialDetailState({
    EeclassMaterialDetailCardStatus? detailCardStatus,
    EeclassMaterial? materialCardData,
  })  : detailCardStatus =
            detailCardStatus ?? EeclassMaterialDetailCardStatus.loading,
        materialCardData = materialCardData;
  final EeclassMaterialDetailCardStatus detailCardStatus;
  final EeclassMaterial? materialCardData;

  EeclassMaterialDetailState copyWith({
    EeclassMaterialDetailCardStatus? detailCardStatus,
    EeclassMaterial? materialCardData,
  }) {
    return EeclassMaterialDetailState(
      detailCardStatus: detailCardStatus ?? this.detailCardStatus,
      materialCardData: materialCardData ?? this.materialCardData,
    );
  }

  @override
  List<Object?> get props => [
        detailCardStatus,
        materialCardData,
      ];
}
