part of 'apptheme_cubit.dart';

class AppthemeState extends Equatable {
  final bool darkTheme;

  AppthemeState({required this.darkTheme});

  @override
  List<Object?> get props => [this.darkTheme];
}
