import 'package:flutter/material.dart';

abstract final class AppColors {
  // Change this seed and hot reload to recolor the application.
  static const seedColor = Color(0xFFB8A1FF);

  static ColorScheme light({Color seed = seedColor}) {
    final generated = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );

    // Keep the original pastel style using tones generated from the seed.
    return generated.copyWith(
      primary: generated.primaryContainer,
      onPrimary: generated.onPrimaryContainer,
      primaryContainer: Color.alphaBlend(
        generated.primary.withValues(alpha: 0.08),
        generated.surfaceContainerLowest,
      ),
      onPrimaryContainer: generated.onSurface,
      surface: generated.surfaceContainerLowest,
      surfaceContainerHighest: generated.surfaceContainerLow,
      onSurfaceVariant: generated.outline,
      outlineVariant: Color.lerp(
        generated.outline,
        generated.outlineVariant,
        0.6,
      ),
    );
  }
}

// Status colors keep their meaning independently of the brand seed.
@immutable
class AppStatusColors extends ThemeExtension<AppStatusColors> {
  final Color success;
  final Color warning;
  final Color onSuccess;
  final Color onWarning;

  const AppStatusColors({
    this.success = const Color(0xFF4CAF50),
    this.warning = const Color(0xFFFFC107),
    this.onSuccess = const Color(0xFF002204),
    this.onWarning = const Color(0xFF241A00),
  });

  @override
  AppStatusColors copyWith({
    Color? success,
    Color? warning,
    Color? onSuccess,
    Color? onWarning,
  }) => AppStatusColors(
    success: success ?? this.success,
    warning: warning ?? this.warning,
    onSuccess: onSuccess ?? this.onSuccess,
    onWarning: onWarning ?? this.onWarning,
  );

  @override
  AppStatusColors lerp(AppStatusColors? other, double t) {
    if (other == null) return this;
    return AppStatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
    );
  }
}
