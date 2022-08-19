part of 'apptheme_cubit.dart';

@JsonSerializable()
class AppthemeState extends Equatable {
  final ThemeMode themeMode;

  AppthemeState({required this.themeMode});

  AppthemeState copyWith({ThemeMode? option}) {
    return AppthemeState(themeMode: option ?? this.themeMode);
  }

  factory AppthemeState.fromJson(Map<String, dynamic> json) =>
      _$AppthemeStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppthemeStateToJson(this);

  @override
  List<Object?> get props => [this.themeMode];
}
