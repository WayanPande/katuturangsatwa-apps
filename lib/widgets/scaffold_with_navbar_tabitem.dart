import 'package:flutter/material.dart';

class ScaffoldWithNavBarTabItem extends NavigationDestination {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, required String label, Widget? selectedIcon})
      : super(icon: icon, label: label, selectedIcon: selectedIcon);

  /// The initial location/path
  final String initialLocation;
}