part of 'apptheme_cubit.dart';

abstract class _Appthemeclass {
  bool get darkTheme;
}

class AppthemeState extends Equatable with _Appthemeclass {
  final bool darkTheme;

  AppthemeState({required this.darkTheme});

  @override
  List<Object?> get props => [this.darkTheme];
}
