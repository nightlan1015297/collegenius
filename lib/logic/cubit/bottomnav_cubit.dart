import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnav_state.dart';

class BottomnavCubit extends Cubit<BottomnavState> {
  BottomnavCubit() : super(BottomnavState(index: 0));

  void changeIndex(int index) => emit(BottomnavState(index: index));
}
