library TodoThemes;

import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
part 'themes/midnight_theme.dart';
part 'themes/greens_theme.dart';
part 'themes/red_and_blue_theme.dart';
part 'themes/material_default_theme.dart';
part 'themes/material_high_contract_theme.dart';
part 'themes/blue_delight_theme.dart';
part 'themes/indigo_nights_theme.dart';

class ThemeManager {
  static final _LightTheme LightTheme = _LightTheme();
  static final _DarkTheme DarkTheme = _DarkTheme();
}

class _LightTheme {
  final ThemeData midnight = _midnightLightTheme;
  final ThemeData greens = _greensLightTheme;
  final ThemeData blue_delight = _blueDelightLightTheme;
  final ThemeData indigo_nights = _indigoNightsLightTheme;
  final ThemeData material_default = _defaultMaterialLightTheme;
  final ThemeData material_high_contract = _materialHighContractLightTheme;
  final ThemeData red_and_blue = _redAndBlueLightTheme;
}

class _DarkTheme {
  final ThemeData midnight = _midnightDarkTheme;
  final ThemeData greens = _greensDarkTheme;
  final ThemeData blue_delight = _blueDelightDarkTheme;
  final ThemeData indigo_nights = _indigoNightsDarkTheme;
  final ThemeData material_default = _defaultMaterialDarkTheme;
  final ThemeData material_high_contract = _materialHighContractDarkTheme;
  final ThemeData red_and_blue = _redAndBlueDarkTheme;
}
