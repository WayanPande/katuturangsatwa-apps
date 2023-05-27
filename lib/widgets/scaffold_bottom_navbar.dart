import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/widgets/scaffold_with_navbar_tabitem.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({
    Key? key,
    required this.tabs,
    required this.navigationShell,
  }) : super(key: key);
  final List<ScaffoldWithNavBarTabItem> tabs;
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    widget.navigationShell.goBranch(
      tabIndex,
      initialLocation: tabIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: List.generate(widget.tabs.length, (index) {
          return NavigationDestination(
            selectedIcon: widget.tabs[index].selectedIcon,
            icon: widget.tabs[index].icon,
            label: widget.tabs[index].label,
          );
        }),
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (index) => _onItemTapped(context, index),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}
