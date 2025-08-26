import 'package:bookify/core/services/professionals_repository.dart';
import 'package:bookify/models/professional_model.dart';
import 'package:bookify/view_models/professional_provider.dart';
import 'package:bookify/views/professionals/professionals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockProfessionalRepository extends Mock
    implements ProfessionalRepository {}

void main() {
  late MockProfessionalRepository mockRepository;

  // Sample test data
  final testProfessionals = [
    Professional(
      id: '1',
      name: 'Test Hair Stylist',
      category: 'Hair Stylist',
      canTravel: 'can_travel',
      services: [Service(id: '1', name: 'Haircut', duration: 30, price: 500)],
      profileImageUrl: '',
      bio: '',
    ),
    Professional(
      id: '2',
      name: 'Test Barber',
      category: 'Barber',
      canTravel: 'cannot_travel',
      services: [Service(id: '2', name: 'Shave', duration: 20, price: 300)],
      profileImageUrl: '',
      bio: '',
    ),
  ];

  setUp(() {
    mockRepository = MockProfessionalRepository();
    // Stub the repository method
    when(
      () => mockRepository.fetchProfessionals(),
    ).thenAnswer((_) async => testProfessionals);
  });

  testWidgets('filtering by category updates the list', (tester) async {
    // Build our app with overridden repository
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the repository provider, not the future provider
          professionalsProvider.overrideWithValue(mockRepository),
        ],
        child: const MaterialApp(home: ProfessionalsScreen()),
      ),
    );

    // Wait for initial load to complete
    await tester.pumpAndSettle();

    // Verify both professionals are initially visible
    expect(find.text('Test Hair Stylist'), findsOneWidget);
    expect(find.text('Test Barber'), findsOneWidget);

    // Find and tap the category filter chip
    await tester.tap(find.textContaining('Category:')); // Use textContaining for more flexibility
    await tester.pumpAndSettle();

    // Tap on 'Hair Stylist' category
    await tester.tap(find.text('Hair Stylist'));
    await tester.pumpAndSettle();

    // Verify only the hair stylist is visible now
    expect(find.text('Test Hair Stylist'), findsOneWidget);
    expect(find.text('Test Barber'), findsNothing);
  });
}