// Ported from the imported Questbook design system: tokens/typography.css + tokens/fonts.css
//
// The source design system self-hosts Spectral/Silkscreen/Caveat/Space Mono woff2 files.
// Flutter can't load woff2 directly, so we resolve the same families through google_fonts
// (all four are published on Google Fonts) instead of hand-converting font files.
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class QBType {
  // Font families
  static TextStyle display() => GoogleFonts.silkscreen();
  static TextStyle body() => GoogleFonts.spectral();
  static TextStyle hand() => GoogleFonts.caveat();
  static TextStyle mono() => GoogleFonts.spaceMono();
  static TextStyle game() => GoogleFonts.silkscreen();

  // Text scale (design tokens are px at a 1x web viewport; used as logical px here)
  static const double xs = 13;
  static const double sm = 15;
  static const double base = 17;
  static const double md = 19;
  static const double lg = 23;
  static const double xl = 28;
  static const double xl2 = 36;
  static const double xl3 = 48;
  static const double xl4 = 64;

  // Line heights (as height multipliers for TextStyle.height)
  static const double leadingTight = 1.15;
  static const double leadingSnug = 1.35;
  static const double leadingNormal = 1.6;
  static const double leadingLoose = 1.8;

  // Letter spacing (em -> approximate logical px multiplier is applied per font size by callers)
  static const double trackingTight = -0.01;
  static const double trackingWide = 0.04;
  static const double trackingWider = 0.12;

  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
}
