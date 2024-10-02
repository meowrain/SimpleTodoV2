part of '../theme_manager.dart';

ThemeData _midnightLightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff00296b),
    primaryContainer: Color(0xffa0c2ed),
    secondary: Color(0xffd26900),
    secondaryContainer: Color(0xffffd270),
    tertiary: Color(0xff5c5c95),
    tertiaryContainer: Color(0xffc8dbf8),
    appBarColor: Color(0xffc8dcf8),
    error: null,
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
ThemeData _midnightDarkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xffb1cff5),
    primaryContainer: Color(0xff3873ba),
    secondary: Color(0xffffd270),
    secondaryContainer: Color(0xffd26900),
    tertiary: Color(0xffc9cbfc),
    tertiaryContainer: Color(0xff535393),
    appBarColor: Color(0xff00102b),
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
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
