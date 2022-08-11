import 'package:flutter_bloc/flutter_bloc.dart';

import 'ColorfulPrintFunction.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> instance, Change<dynamic> change) {
    printUnimportant("=======[On change]=======");
    printUnimportant("instance : $instance  state has updated.");
    printUnimportant("=========================");
    return super.onChange(instance, change);
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
