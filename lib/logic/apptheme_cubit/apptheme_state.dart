part of 'apptheme_cubit.dart';

class AppthemeState extends Equatable {
  final ThemeOption cuurrentOption;

  AppthemeState({
    required this.cuurrentOption,
  });

  @override
  List<Object?> get props => [this.cuurrentOption];
}
