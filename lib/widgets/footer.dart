import 'package:flutter/material.dart';

class _FooterMenuState extends State<FooterMenu> {
  int _selectedIndex = 0;

  _FooterMenuState(); //constructor

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.navItems,
      currentIndex: _selectedIndex,
      // selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}

// ignore: must_be_immutable
class FooterMenu extends StatefulWidget {
  final List<Map<String, dynamic>> menuItemsMap;
  List<BottomNavigationBarItem> navItems = [];

  FooterMenu({required Key key, required this.menuItemsMap}) : super(key: key) {
    this.buildNavItems();
  }

  void buildNavItems() {
    menuItemsMap.forEach((element) {
      navItems.add(BottomNavigationBarItem(
        icon: element['icon'],
        label: element['text'],
      ));
    });
  }

  @override
  _FooterMenuState createState() => _FooterMenuState();
}
