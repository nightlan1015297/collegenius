import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../constants/Constants.dart';
part 'bottomnav_state.dart';

class BottomnavCubit extends Cubit<BottomnavState> {
  BottomnavCubit() : super(BottomnavState(index: 0));
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void changeIndex(int index) {
    emit(BottomnavState(index: index));
    analytics.logScreenView(
        screenName: '/${mapBottomNavIndexToScreenName[index]}');
  }
}
