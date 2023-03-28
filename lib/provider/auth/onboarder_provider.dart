import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final onboardingStatusProvider = Provider.family<bool, String>((ref, userId) {
  final onboardingBox = Hive.box('onboarding_status');
  return onboardingBox.get('hasOnboarded') ?? false;
  // return onboardingBox.get(userId) ?? false;
});