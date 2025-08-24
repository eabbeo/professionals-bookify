import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_state.freezed.dart';

@freezed
abstract class FilterState with _$FilterState {
  const factory FilterState({
    required String category,
    required double maxPrice,
    required bool canTravel,
  }) = _FilterState;

  factory FilterState.initial() =>
      const FilterState(category: 'All', maxPrice: 3000, canTravel: false);
}
