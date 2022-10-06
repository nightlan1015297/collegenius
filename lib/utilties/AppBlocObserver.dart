import 'package:flutter_bloc/flutter_bloc.dart';

import 'ColorfulPrintFunction.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> instance, Change<dynamic> change) {
    printUnimportant("=======[On change]=======");
    printUnimportant("instance : $instance  state has updated.");
    // printUnimportant(change.currentState);
    // printUnimportant(change.nextState);
    printUnimportant("=========================");
    return super.onChange(instance, change);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> instance, Object? event) {
    printUnimportant("=======[On enent]=======");
    printUnimportant("instance : $instance  has recieve new event.");
    printUnimportant("event : $event ");
    printUnimportant("=========================");
    return super.onEvent(instance, event);
  }

  @override
  void onCreate(BlocBase<dynamic> instance) {
    printSuccess("=======[On create]=======");
    printSuccess("instance : $instance");
    printSuccess("=========================");

    return super.onCreate(instance);
  }

  @override
  void onClose(BlocBase<dynamic> instance) {
    printFatel("========[On close]=======");
    printFatel("instance : $instance");
    printFatel("=========================");

    return super.onClose(instance);
  }
}
