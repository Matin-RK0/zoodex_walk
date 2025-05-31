import 'package:flutter/material.dart';
import 'app_palette.dart';
import 'app_text_styles.dart';

final customLightTheme = ThemeData.light().copyWith(
  primaryColor:        AppPalette.primary,
  scaffoldBackgroundColor: AppPalette.bgLight,
  colorScheme:         ThemeData.light().colorScheme.copyWith(
    secondary: AppPalette.secondary,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppPalette.primary,
    foregroundColor: Colors.white,
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
    headlineMedium: AppTextStyles.headline,
    bodyMedium:     AppTextStyles.body,
    bodySmall:      AppTextStyles.caption,
  ),
);