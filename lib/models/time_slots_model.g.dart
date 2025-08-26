// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slots_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeSlots _$TimeSlotsFromJson(Map<String, dynamic> json) => _TimeSlots(
  timeSlots: (json['timeSlots'] as List<dynamic>)
      .map((e) => Slot.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TimeSlotsToJson(_TimeSlots instance) =>
    <String, dynamic>{'timeSlots': instance.timeSlots};

_Slot _$SlotFromJson(Map<String, dynamic> json) =>
    _Slot(time: json['time'] as String);

Map<String, dynamic> _$SlotToJson(_Slot instance) => <String, dynamic>{
  'time': instance.time,
};
