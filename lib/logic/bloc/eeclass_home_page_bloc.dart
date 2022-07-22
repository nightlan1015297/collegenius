import 'package:bloc/bloc.dart';
import 'package:collegenius/models/eeclass_model/EeclassCourse.dart';
import 'package:equatable/equatable.dart';

import '../../models/semester_model/semester_model.dart';

part 'eeclass_home_page_event.dart';
part 'eeclass_home_page_state.dart';

class EeclassHomePageBloc
    extends Bloc<EeclassHomePageEvent, EeclassHomePageState> {
  EeclassHomePageBloc() : super(EeclassHomePageInitial()) {
    on<EeclassHomePageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
