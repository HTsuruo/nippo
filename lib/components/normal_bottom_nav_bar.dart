import 'package:flutter/material.dart';
import 'package:nippo/theme.dart';

class NormalBottomNavBar extends StatelessWidget {
  const NormalBottomNavBar({this.index, this.onTap});
  final int index;
  final Function(int) onTap;
  List<BottomNavigationBarItem> bottomItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.view_list), title: const Text('日報')),
      BottomNavigationBarItem(
          icon: Icon(Icons.people), title: const Text('登録者')),
      BottomNavigationBarItem(
          icon: Icon(Icons.person), title: const Text('マイページ')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      items: bottomItems(),
      currentIndex: index,
      selectedFontSize: 12,
      elevation: 5,
      backgroundColor: Colors.white,
      unselectedItemColor: VIC.navigationUnselected,
    );
  }
}
