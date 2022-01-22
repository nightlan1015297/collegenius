part of 'apptheme_cubit.dart';

enum AppthemeOption { dark, light, system }

extension CoursepageStatusX on AppthemeOption {
  bool get isDark => this == AppthemeOption.dark;
  bool get isLight => this == AppthemeOption.light;
  bool get isSystem => this == AppthemeOption.system;
}

@JsonSerializable()
class AppthemeState extends Equatable {
  final AppthemeOption themeOption;

  AppthemeState({required this.themeOption});

  AppthemeState copywith({AppthemeOption? option}) {
    return AppthemeState(themeOption: option ?? this.themeOption);
  }

  factory AppthemeState.fromJson(Map<String, dynamic> json) =>
      _$AppthemeStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppthemeStateToJson(this);
  @override
  List<Object?> get props => [this.themeOption];
}
