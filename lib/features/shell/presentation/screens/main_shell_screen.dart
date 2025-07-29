// lib/features/shell/presentation/screens/main_shell_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main shell screen that contains the bottom navigation bar
/// This screen wraps all main sections of the app
class MainShellScreen extends StatefulWidget {
  final Widget child;

  const MainShellScreen({
    super.key,
    required this.child,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  // Define the navigation items
  static const List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.description_outlined,
      activeIcon: Icons.description,
      label: 'Documents',
      route: '/',
    ),
    NavigationItem(
      icon: Icons.folder_copy_outlined,
      activeIcon: Icons.folder_copy,
      label: 'Bundles',
      route: '/bundles',
    ),
    NavigationItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'Reminders',
      route: '/reminders',
    ),
    NavigationItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final location = GoRouterState.of(context).uri.path;
    
    // Find the matching navigation item based on current route
    for (int i = 0; i < _navigationItems.length; i++) {
      if (location == _navigationItems[i].route) {
        if (_currentIndex != i) {
          setState(() {
            _currentIndex = i;
          });
        }
        break;
      }
    }
  }

  void _onItemTapped(int index) {
    if (index != _currentIndex) {
      final route = _navigationItems[index].route;
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorScheme.outline.withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
          selectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 0,
          items: _navigationItems.map((item) {
            final isSelected = _navigationItems[_currentIndex] == item;
            return BottomNavigationBarItem(
              icon: _NavigationIcon(
                icon: item.icon,
                activeIcon: item.activeIcon,
                isSelected: isSelected,
              ),
              label: item.label,
              tooltip: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Navigation icon with smooth animation between states
class _NavigationIcon extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;

  const _NavigationIcon({
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: Icon(
        isSelected ? activeIcon : icon,
        key: ValueKey(isSelected),
        size: 24,
      ),
    );
  }
}

/// Data class for navigation items
class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationItem &&
          runtimeType == other.runtimeType &&
          route == other.route;

  @override
  int get hashCode => route.hashCode;
}
