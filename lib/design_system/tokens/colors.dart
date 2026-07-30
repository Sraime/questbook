// Ported from the imported Questbook design system: tokens/colors.css
import 'package:flutter/widgets.dart';

/// Raw palette + semantic aliases from the Questbook design system.
abstract final class QBColors {
  // Paper
  static const paper50 = Color(0xFFFAF4E6);
  static const paper100 = Color(0xFFF4E9D1);
  static const paper200 = Color(0xFFEAD6AB);
  static const paper300 = Color(0xFFDCC086);
  static const paper400 = Color(0xFFC9A668);

  // Ink
  static const ink900 = Color(0xFF241A12);
  static const ink800 = Color(0xFF33241A);
  static const ink700 = Color(0xFF4A3626);
  static const ink600 = Color(0xFF5F4735);
  static const ink500 = Color(0xFF7A6046);
  static const ink300 = Color(0xFFA08B74);

  // Leather
  static const leather900 = Color(0xFF2E1C10);
  static const leather800 = Color(0xFF4A2C17);
  static const leather700 = Color(0xFF623A1F);
  static const leather600 = Color(0xFF7A4A28);
  static const leather500 = Color(0xFF96633B);
  static const leather300 = Color(0xFFC99E6F);

  // Wax
  static const wax700 = Color(0xFF5E2020);
  static const wax600 = Color(0xFF7D2B28);
  static const wax500 = Color(0xFF9C3A32);
  static const wax100 = Color(0xFFF0DAD2);

  // Arcane
  static const arcane700 = Color(0xFF20323F);
  static const arcane600 = Color(0xFF2F4B5C);
  static const arcane500 = Color(0xFF3F6478);
  static const arcane100 = Color(0xFFDBE6E9);

  // Gold
  static const gold700 = Color(0xFF7D5F22);
  static const gold600 = Color(0xFF9C7A2E);
  static const gold500 = Color(0xFFB8923E);
  static const gold100 = Color(0xFFF3E6C4);

  // Moss
  static const moss600 = Color(0xFF4C6438);
  static const moss500 = Color(0xFF5C7A44);
  static const moss100 = Color(0xFFE1E8D5);

  static const white = Color(0xFFFFFAF0);

  // Juicy gradient pairs (top -> bottom) reserved for interactive game chrome.
  static const juicyGreenTop = Color(0xFF8BC34A);
  static const juicyGreenBottom = Color(0xFF4F7A1F);
  static const juicyGoldTop = Color(0xFFFFD75E);
  static const juicyGoldBottom = Color(0xFFC17F0E);
  static const juicyRedTop = Color(0xFFEF5350);
  static const juicyRedBottom = Color(0xFFA3231F);
  static const juicyBlueTop = Color(0xFF4FB3E8);
  static const juicyBlueBottom = Color(0xFF1F6F9C);

  // Gems
  static const gemRuby = Color(0xFFE0457B);
  static const gemSapphire = Color(0xFF3EA8E0);
  static const gemTopaz = Color(0xFFF6C945);

  // Inventory slots
  static const slotEmpty = Color(0xFF3A2717);
  static const slotBorder = Color(0xFF1C1108);

  // Semantic surfaces
  static const bgPage = paper100;
  static const bgCanvas = paper50;
  static const surfaceCard = paper50;
  static const surfaceRaised = white;
  static const surfaceSunken = paper200;
  static const surfaceInverse = leather900;

  // Text
  static const textBody = ink800;
  static const textStrong = ink900;
  static const textMuted = ink500;
  static const textInverse = paper50;
  static const textLink = arcane600;
  static const textLinkHover = arcane700;

  // Borders
  static const borderDefault = ink300;
  static const borderStrong = leather700;
  static const borderHairline = Color(0x29332419); // rgba(51,36,26,.16)

  // Accent
  static const accentPrimary = leather700;
  static const accentPrimaryHover = leather800;
  static const accentPrimaryPress = leather900;
  static const accentFocus = arcane500;

  static const buttonBevelLight = Color(0x8CFFFFFF); // rgba(255,255,255,.55)
  static const buttonBevelDark = Color(0x66000000); // rgba(0,0,0,.4)

  // Semantic tones
  static const semanticDanger = wax600;
  static const semanticDangerBg = wax100;
  static const semanticSuccess = moss500;
  static const semanticSuccessBg = moss100;
  static const semanticWarning = gold600;
  static const semanticWarningBg = gold100;
  static const semanticInfo = arcane600;
  static const semanticInfoBg = arcane100;
}

/// Tone keywords used across Badge/Toast/Tag-like components.
enum QBTone { neutral, danger, success, warning, info }

extension QBToneGradient on QBTone {
  /// Top/bottom gradient stops matching the "juicy" component treatment.
  (Color top, Color bottom) get juicyGradient => switch (this) {
        QBTone.neutral => (const Color(0xFF5A4632), const Color(0xFF3A2C1C)),
        QBTone.danger => (QBColors.juicyRedTop, QBColors.juicyRedBottom),
        QBTone.success => (QBColors.juicyGreenTop, QBColors.juicyGreenBottom),
        QBTone.warning => (QBColors.juicyGoldTop, QBColors.juicyGoldBottom),
        QBTone.info => (QBColors.juicyBlueTop, QBColors.juicyBlueBottom),
      };

  Color get foreground =>
      this == QBTone.warning ? QBColors.ink900 : QBColors.paper50;
}
