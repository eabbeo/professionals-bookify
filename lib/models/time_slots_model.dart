import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slots_model.freezed.dart';
part 'time_slots_model.g.dart';

@freezed
abstract class TimeSlots with _$TimeSlots {
  const factory TimeSlots({
    required List<Slot> timeSlots,
  }) = _TimeSlots;

  factory TimeSlots.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotsFromJson(json);
}

@freezed
abstract class Slot with _$Slot {
  const factory Slot({required String time}) = _Slot;

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
}
