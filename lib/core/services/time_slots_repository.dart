import 'dart:convert';

import 'package:bookify/models/time_slots_model.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:bookify/models/time_slots_model.dart';
import 'package:flutter/services.dart';

class TimeSlotsRepository {
  Future<List<Slot>> fetchTimeSlots() async {
    final jsonString = await rootBundle.loadString(
      'assetss/data/time_slots.json',
    );
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final timeSlotList = jsonMap['timeSlots'] as List<dynamic>;
    return timeSlotList
        .map((slotJson) => Slot.fromJson(slotJson as Map<String, dynamic>))
        .toList();
  }
}
