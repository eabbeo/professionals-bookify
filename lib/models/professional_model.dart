// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'professional_model.freezed.dart';
part 'professional_model.g.dart';

@freezed
abstract class Service with _$Service {
  const factory Service({
    required String id,
    required String name,
    @JsonKey(name: 'durationMinutes') required int duration,
    required double price,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

@freezed
abstract class Professional with _$Professional {
  const factory Professional({
    required String id,
    required String name,
    required String category,
    required String profileImageUrl,
    @JsonKey(name: 'travelMode') required String canTravel,
    required List<Service> services,
    required String bio,
  }) = _Professional;

  factory Professional.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalFromJson(json);
}
