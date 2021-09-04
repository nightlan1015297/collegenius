part of 'bottomnav_cubit.dart';

class BottomnavState extends Equatable {
  final int index;

  BottomnavState({required this.index});

  @override
  List<Object> get props => [this.index];
}
