import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design_system/components/qb_bottom_nav_bar.dart';

/// Hosts the two persistent tabs (Perso/Tables) from the mockup's bottom
/// tab bar, driven by go_router's StatefulShellRoute.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: QBBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
