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

final professionalsListProvider = FutureProvider<List<Professional>>((
  ref,
) async {
  final repository = ref.read(professionalsProvider);
  return await repository.fetchProfessionals();
});

final filteredProfessionalsProvider = Provider<List<Professional>>((ref) {
  final filterState = ref.watch(filterStateProvider);
  final professionalsAsync = ref.watch(professionalsListProvider);

  return professionalsAsync.maybeWhen(
    data: (professionals) {
      return professionals.where((professional) {
        final categoryMatch =
            filterState.category == 'All' ||
            professional.category == filterState.category;
        final priceMatch = professional.services.any(
          (service) => service.price <= filterState.maxPrice,
        );
        // Filter by travel mode
        final travelMatch =
            !filterState.canTravel || professional.canTravel == 'can_travel';

        return categoryMatch && priceMatch && travelMatch;
      }).toList();
    },
    orElse: () => [],
  );
});
