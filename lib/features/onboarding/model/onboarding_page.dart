import 'package:flutter/material.dart';

@immutable
class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
  });
}
