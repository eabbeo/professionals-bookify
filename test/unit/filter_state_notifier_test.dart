import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookify/models/filter_state.dart';
import 'package:bookify/view_models/professional_provider.dart';

void main() {
  group('FilterStateNotifier', () {
    // Create a provider container for testing
    late ProviderContainer container;
    late FilterStateNotifier notifier;

    setUp(() {
      container = ProviderContainer(overrides: []);
      // Get the notifier instance from the provider
      notifier = container.read(filterStateProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      // Read the initial state from the provider
      final state = container.read(filterStateProvider);
      expect(
        state,
        const FilterState(category: 'All', maxPrice: 3000, canTravel: false),
      );
    });

    test('setCategory updates state correctly', () {
      // Act
      notifier.setCategory('Hair Stylist');

      // Read the updated state
      final state = container.read(filterStateProvider);

      // Assert
      expect(state.category, 'Hair Stylist');
      expect(state.maxPrice, 3000);
      expect(state.canTravel, false);
    });

    test('setMaxPrice updates state correctly', () {
      // Act
      notifier.setMaxPrice(1500);

      // Read the updated state
      final state = container.read(filterStateProvider);

      // Assert
      expect(state.maxPrice, 1500);
      expect(state.category, 'All');
      expect(state.canTravel, false);
    });

    test('setCanTravel updates state correctly', () {
      // Act
      notifier.setCanTravel(true);

      // Read the updated state
      final state = container.read(filterStateProvider);

      // Assert
      expect(state.canTravel, true);
      expect(state.category, 'All');
      expect(state.maxPrice, 3000);
    });

    test('reset returns state to initial values', () {
      // Arrange - change some values first
      notifier.setCategory('Barber');
      notifier.setMaxPrice(2000);
      notifier.setCanTravel(true);

      // Act
      notifier.reset();

      // Read the reset state
      final state = container.read(filterStateProvider);

      // Assert
      expect(
        state,
        const FilterState(category: 'All', maxPrice: 3000, canTravel: false),
      );
    });
  });
}
