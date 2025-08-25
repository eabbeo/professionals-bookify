import 'dart:convert';

import 'package:bookify/models/professional_model.dart';
import 'package:flutter/services.dart';

//this repo is to make and get the list professionals data
class ProfessionalRepository {
  Future<List<Professional>> fetchProfessionals() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 5));
    final jsonString = await rootBundle.loadString(
      'assets/data/professionals.json',
    );
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final professionalsList = jsonMap['professionals'] as List<dynamic>;
    return professionalsList
        .map((professionalJson) => Professional.fromJson(professionalJson))
        .toList();
  }
}
