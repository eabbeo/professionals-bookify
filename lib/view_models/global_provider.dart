// Holds an int (0 or 1, etc.)
import 'package:flutter_riverpod/legacy.dart';

final selectedProfessionalProvider = StateProvider<int>((ref) => 0);
final selectedSeriveceProvider = StateProvider<int>((ref) => 0);
final selectedTimeProvider = StateProvider<String>((ref) => '');
