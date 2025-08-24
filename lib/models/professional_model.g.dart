// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Service _$ServiceFromJson(Map<String, dynamic> json) => _Service(
  id: json['id'] as String,
  name: json['name'] as String,
  duration: (json['durationMinutes'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$ServiceToJson(_Service instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'durationMinutes': instance.duration,
  'price': instance.price,
};

_Professional _$ProfessionalFromJson(Map<String, dynamic> json) =>
    _Professional(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      canTravel: json['travelMode'] as String,
      services: (json['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$ProfessionalToJson(_Professional instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'profileImageUrl': instance.profileImageUrl,
      'travelMode': instance.canTravel,
      'services': instance.services,
      'bio': instance.bio,
    };
