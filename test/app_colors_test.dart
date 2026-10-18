import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go2point/theme/app_colors.dart';

void main() {
  test('Changing the seed recolors accents, containers and text', () {
    final purple = AppColors.light();
    final green = AppColors.light(seed: const Color(0xFF008577));

    expect(green.primary, isNot(purple.primary));
    expect(green.primaryContainer, isNot(purple.primaryContainer));
    expect(
      green.surfaceContainerHighest,
      isNot(purple.surfaceContainerHighest),
    );
    expect(green.onSurface, isNot(purple.onSurface));
    expect(green.onSurfaceVariant, isNot(purple.onSurfaceVariant));
    expect(green.outlineVariant, isNot(purple.outlineVariant));
  });

  test('Pastel button and container text have readable contrast', () {
    for (final seed in [AppColors.seedColor, const Color(0xFF008577)]) {
      final scheme = AppColors.light(seed: seed);
      expect(_contrast(scheme.primary, scheme.onPrimary), greaterThan(4.5));
      expect(
        _contrast(scheme.primaryContainer, scheme.onPrimaryContainer),
        greaterThan(4.5),
      );
    }
  });
}

double _contrast(Color a, Color b) {
  final first = a.computeLuminance();
  final second = b.computeLuminance();
  final lighter = first > second ? first : second;
  final darker = first > second ? second : first;
  return (lighter + 0.05) / (darker + 0.05);
}
