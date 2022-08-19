part of 'eeclass_bullitin_list_cubit.dart';

enum EeclassBullitinListStatus { initial, loading, success, failure }

class EeclassBullitinListState extends Equatable {
  EeclassBullitinListState({
    EeclassBullitinListStatus? status,
    bool? isLoadedEnd,
    int? loadedPage,
    List<EeclassBullitinBrief>? bullitins,
  })  : status = status ?? EeclassBullitinListStatus.initial,
        isLoadedEnd = isLoadedEnd ?? false,
        loadedPage = loadedPage ?? 1,
        bullitins = bullitins ?? [];

  final EeclassBullitinListStatus status;
  final bool isLoadedEnd;
  final int loadedPage;
  final List<EeclassBullitinBrief> bullitins;

  EeclassBullitinListState copyWith({
    EeclassBullitinListStatus? status,
    bool? isLoadedEnd,
    int? loadedPage,
    List<EeclassBullitinBrief>? bullitins,
  }) {
    return EeclassBullitinListState(
      status: status ?? this.status,
      isLoadedEnd: isLoadedEnd ?? this.isLoadedEnd,
      loadedPage: loadedPage ?? this.loadedPage,
      bullitins: bullitins ?? this.bullitins,
    );
  }

  @override
  List<Object> get props => [status, loadedPage, bullitins, isLoadedEnd];
}
