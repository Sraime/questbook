// Ported from the imported Questbook design system: tokens/effects.css
import 'package:flutter/widgets.dart';

/// Drop-shadow tokens. CSS `inset` shadows (worn/embossed/slot) have no direct
/// BoxShadow equivalent in Flutter — those are approximated in the widgets
/// that use them (QBInventoryRow, pressed QBButton) via borders/gradients
/// instead of listed here.
abstract final class QBShadows {
  static const List<BoxShadow> paperSm = [
    BoxShadow(color: Color(0x24241A12), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x14241A12), offset: Offset(0, 1), blurRadius: 1),
  ];

  static const List<BoxShadow> paperMd = [
    BoxShadow(color: Color(0x2E241A12), offset: Offset(0, 4), blurRadius: 10),
    BoxShadow(color: Color(0x1A241A12), offset: Offset(0, 1), blurRadius: 3),
  ];

  static const List<BoxShadow> paperLg = [
    BoxShadow(color: Color(0x42241A12), offset: Offset(0, 12), blurRadius: 28),
    BoxShadow(color: Color(0x24241A12), offset: Offset(0, 3), blurRadius: 8),
  ];

  /// The "juicy" 3D-bottom-edge look used by primary/secondary buttons at rest.
  static const List<BoxShadow> juicy = [
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 5)),
    BoxShadow(color: Color(0x47000000), offset: Offset(0, 8), blurRadius: 14),
  ];

  /// Same button, pressed down into its shadow.
  static const List<BoxShadow> juicyPress = [
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 2)),
    BoxShadow(color: Color(0x38000000), offset: Offset(0, 3), blurRadius: 6),
  ];
}

abstract final class QBMotion {
  static const Curve easeOut = Cubic(0.2, 0.7, 0.3, 1);
  static const Curve easeInOut = Cubic(0.45, 0, 0.15, 1);
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration base = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 360);
}
