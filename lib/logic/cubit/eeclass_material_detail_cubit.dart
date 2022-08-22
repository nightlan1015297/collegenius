import 'package:bloc/bloc.dart';
import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/models/eeclass_model/EeclassModel.dart';
import 'package:collegenius/repositories/eeclass_repository.dart';
import 'package:collegenius/utilties/ColorfulPrintFunction.dart';
import 'package:equatable/equatable.dart';

part 'eeclass_material_detail_state.dart';

class EeclassMaterialDetailCubit extends Cubit<EeclassMaterialDetailState> {
  EeclassMaterialDetailCubit({
    required this.eeclassRepository,
  }) : super(EeclassMaterialDetailState());
  final EeclassRepository eeclassRepository;

  Future<void> onOpenPopupMaterialCardRequest({
    required String type,
    required String materialUrl,
  }) async {
    if (!isClosed) {
      emit(state.copyWith(
          detailCardStatus: EeclassMaterialDetailCardStatus.loading));
    }
    try {
      final materialInfo =
          await eeclassRepository.getMaterial(type: type, url: materialUrl);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassMaterialDetailCardStatus.success,
            materialCardData: materialInfo));
      }
    } catch (e, stacktrace) {
      print(e);
      printHighlight(stacktrace);
      if (!isClosed) {
        emit(state.copyWith(
            detailCardStatus: EeclassMaterialDetailCardStatus.failed));
      }
    }
  }
}
