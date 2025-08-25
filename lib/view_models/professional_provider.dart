import 'package:bookify/core/services/professionals_repository.dart';
import 'package:bookify/models/filter_state.dart';
import 'package:bookify/models/professional_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

//this future provider store the data of obtained professionals
final professionalsProvider = Provider<ProfessionalRepository>((ref) {
  return ProfessionalRepository();
});

//
final filterStateProvider =
    StateNotifierProvider<FilterStateNotifier, FilterState>((ref) {
      return FilterStateNotifier();
    });

class FilterStateNotifier extends StateNotifier<FilterState> {
  FilterStateNotifier() : super(FilterState.initial());

  void setCategory(String category) {
    state = state.copyWith(category: category);
  }

  void setMaxPrice(double maxPrice) {
    state = state.copyWith(maxPrice: maxPrice);
  }

  void setCanTravel(bool canTravel) {
    state = state.copyWith(canTravel: canTravel);
  }

  void reset() {
    state = FilterState.initial();
  }
}

// Provider that fetches the list of professionals (handles loading/error states)
final professionalsListProvider = FutureProvider<List<Professional>>((
  ref,
) async {
  final repository = ref.read(professionalsProvider);
  return await repository.fetchProfessionals();
});

// Provider that combines the raw list with filters to produce the final UI list
final filteredProfessionalsProvider = Provider<List<Professional>>((ref) {
  final filterState = ref.watch(filterStateProvider);
  final professionalsAsync = ref.watch(professionalsListProvider);

  return professionalsAsync.maybeWhen(
    data: (professionals) {
      // Apply filters to the entire LIST of professionals
      return professionals.where(
        (professional) {
          // Filter by category
          final categoryMatch =
              filterState.category == 'All' ||
              professional.category == filterState.category;
          // Filter by max price (check if ANY service is below the max price)
          final priceMatch = professional.services.any(
            (service) => service.price <= filterState.maxPrice,
          );
          // Filter by travel mode
          final travelMatch =
              !filterState.canTravel || professional.canTravel == 'can_travel';

          return categoryMatch && priceMatch && travelMatch;
        },
      ).toList(); // This .toList() converts the filtered Iterable back to a List
    },
    orElse: () => [], // Return empty list if still loading or in error state
  );
});
