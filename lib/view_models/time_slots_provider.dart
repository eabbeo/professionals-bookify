import 'package:bookify/core/services/time_slots_repository.dart';
import 'package:bookify/models/time_slots_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeSlotProvider = Provider<TimeSlotsRepository>((ref) {
  return TimeSlotsRepository();
});

final timeSlotListProvider = FutureProvider<List<Slot>>((ref) async {
  final repository = ref.read(timeSlotProvider);
  return await repository.fetchTimeSlots();
});
