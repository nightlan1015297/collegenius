import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> instance, Change<dynamic> change) {
    print("=======[On change]=======");
    print("instance : ");
    print(instance);
    print("change : ");
    print(change);
    return super.onChange(instance, change);
  }

  @override
  void onCreate(BlocBase<dynamic> instance) {
    print("=======[On create]=======");
    print("instance : ");
    print(instance);
    return super.onCreate(instance);
  }

  @override
  void onClose(BlocBase<dynamic> instance) {
    print("=======[On close]=======");
    print("instance : ");
    print(instance);
    return super.onClose(instance);
  }
}
