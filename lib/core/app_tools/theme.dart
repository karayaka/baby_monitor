import "package:flutter/material.dart";

class MaterialTheme {
  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0c6780),
      surfaceTint: Color(0xff0c6780),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbaeaff),
      onPrimaryContainer: Color(0xff004d62),
      secondary: Color(0xff8d4959),
      onSecondary: Color(0xFFE1DCC7),
      secondaryContainer: Color(0xffffd9df),
      onSecondaryContainer: Color(0xff713342),
      tertiary: Color(0xff585992),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1dfff),
      onTertiaryContainer: Color(0xff404178),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787d),
      outlineVariant: Color(0xffc0c8cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff89d0ed),
      primaryFixed: Color(0xffbaeaff),
      onPrimaryFixed: Color(0xff001f29),
      primaryFixedDim: Color(0xff89d0ed),
      onPrimaryFixedVariant: Color(0xff004d62),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff3a0718),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff713342),
      tertiaryFixed: Color(0xffe1dfff),
      onTertiaryFixed: Color(0xff14134a),
      tertiaryFixedDim: Color(0xffc1c1ff),
      onTertiaryFixedVariant: Color(0xff404178),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f7),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003b4c),
      surfaceTint: Color(0xff0c6780),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff267590),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5d2232),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff9f5868),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2f3066),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6767a2),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff0d1214),
      onSurfaceVariant: Color(0xff2f373b),
      outline: Color(0xff4c5458),
      outlineVariant: Color(0xff666e72),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff89d0ed),
      primaryFixed: Color(0xff267590),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005c75),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff9f5868),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff824050),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6767a2),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4e4f87),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7ca),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f7),
      surfaceContainer: Color(0xffe4e9ec),
      surfaceContainerHigh: Color(0xffd9dde1),
      surfaceContainerHighest: Color(0xffcdd2d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00313f),
      surfaceTint: Color(0xff0c6780),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005065),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff501828),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff743544),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff25265c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff43437b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252d31),
      outlineVariant: Color(0xff424a4e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff89d0ed),
      primaryFixed: Color(0xff005065),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003847),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff743544),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff581f2e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff43437b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2c2c63),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4b9bd),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf1f5),
      surfaceContainer: Color(0xffdee3e6),
      surfaceContainerHigh: Color(0xffd0d5d8),
      surfaceContainerHighest: Color(0xffc2c7ca),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff89d0ed),
      surfaceTint: Color(0xff89d0ed),
      onPrimary: Color(0xff003544),
      primaryContainer: Color(0xff004d62),
      onPrimaryContainer: Color(0xffbaeaff),
      secondary: Color(0xffffb1c0),
      onSecondary: Color(0xff551d2c),
      secondaryContainer: Color(0xff713342),
      onSecondaryContainer: Color(0xffffd9df),
      tertiary: Color(0xffc1c1ff),
      onTertiary: Color(0xff2a2a60),
      tertiaryContainer: Color(0xff404178),
      onTertiaryContainer: Color(0xffe1dfff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdee3e6),
      onSurfaceVariant: Color(0xffc0c8cc),
      outline: Color(0xff8a9296),
      outlineVariant: Color(0xff40484c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff0c6780),
      primaryFixed: Color(0xffbaeaff),
      onPrimaryFixed: Color(0xff001f29),
      primaryFixedDim: Color(0xff89d0ed),
      onPrimaryFixedVariant: Color(0xff004d62),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff3a0718),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff713342),
      tertiaryFixed: Color(0xffe1dfff),
      onTertiaryFixed: Color(0xff14134a),
      tertiaryFixedDim: Color(0xffc1c1ff),
      onTertiaryFixedVariant: Color(0xff404178),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa9e5ff),
      surfaceTint: Color(0xff89d0ed),
      onPrimary: Color(0xff002a36),
      primaryContainer: Color(0xff519ab5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd1d8),
      onSecondary: Color(0xff481221),
      secondaryContainer: Color(0xffc87a8b),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdad9ff),
      onTertiary: Color(0xff1e1f55),
      tertiaryContainer: Color(0xff8b8bc8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5dde2),
      outline: Color(0xffabb3b8),
      outlineVariant: Color(0xff899296),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004f64),
      primaryFixed: Color(0xffbaeaff),
      onPrimaryFixed: Color(0xff00141b),
      primaryFixedDim: Color(0xff89d0ed),
      onPrimaryFixedVariant: Color(0xff003b4c),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff2c000d),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff5d2232),
      tertiaryFixed: Color(0xffe1dfff),
      onTertiaryFixed: Color(0xff080641),
      tertiaryFixedDim: Color(0xffc1c1ff),
      onTertiaryFixedVariant: Color(0xff2f3066),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff404548),
      surfaceContainerLowest: Color(0xff04080a),
      surfaceContainerLow: Color(0xff191e21),
      surfaceContainer: Color(0xff23292b),
      surfaceContainerHigh: Color(0xff2e3336),
      surfaceContainerHighest: Color(0xff393e41),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffddf4ff),
      surfaceTint: Color(0xff89d0ed),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff85cce9),
      onPrimaryContainer: Color(0xff000d13),
      secondary: Color(0xffffebed),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffacbc),
      onSecondaryContainer: Color(0xff210008),
      tertiary: Color(0xfff1eeff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbdbdfd),
      onTertiaryContainer: Color(0xff03003c),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f1f6),
      outlineVariant: Color(0xffbcc4c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004f64),
      primaryFixed: Color(0xffbaeaff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff89d0ed),
      onPrimaryFixedVariant: Color(0xff00141b),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff2c000d),
      tertiaryFixed: Color(0xffe1dfff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc1c1ff),
      onTertiaryFixedVariant: Color(0xff080641),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff4c5154),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2023),
      surfaceContainer: Color(0xff2c3134),
      surfaceContainerHigh: Color(0xff373c3f),
      surfaceContainerHighest: Color(0xff42484a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        fontFamily: "ComicNeue",
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
