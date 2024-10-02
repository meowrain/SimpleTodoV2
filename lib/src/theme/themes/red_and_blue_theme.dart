part of '../theme_manager.dart';

ThemeData _redAndBlueLightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff1145a4),
    primaryContainer: Color(0xffacc7f6),
    secondary: Color(0xffb61d1d),
    secondaryContainer: Color(0xffec9f9f),
    tertiary: Color(0xff376bca),
    tertiaryContainer: Color(0xffcfdbf2),
    appBarColor: Color(0xffcfdbf2),
    error: Color(0xffb00020),
  ),
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useM2StyleDividerInM3: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
ThemeData _redAndBlueDarkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xffc4d7f8),
    primaryContainer: Color(0xff577cbf),
    secondary: Color(0xfff1bbbb),
    secondaryContainer: Color(0xffcb6060),
    tertiary: Color(0xffdde5f5),
    tertiaryContainer: Color(0xff7297d9),
    appBarColor: Color(0xffdde5f5),
    error: null,
  ),
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useM2StyleDividerInM3: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
