import 'package:doorcode_nfc/components/eventsList.dart';
import 'package:doorcode_nfc/screens/profile.dart';
import 'package:doorcode_nfc/screens/ticketsList.dart';
import 'package:flutter/material.dart';
import 'package:doorcode_nfc/screens/events.dart';
import 'package:doorcode_nfc/components/customIcon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Events(),
    TicketsPage(),
    Profile(),
    // Use Page2 widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 14, left: 15),
              child: _selectedIndex == 0
                  ? CustomIcon(imagePath: 'assets/home (4).png')
                  : CustomIcon(imagePath: 'assets/home new.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 14),
              child: _selectedIndex == 1
                  ? CustomIcon(imagePath: 'assets/ticket new.png')
                  : CustomIcon(imagePath: 'assets/ticket (1) 1.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 14, right: 14),
              child: _selectedIndex == 2
                  ? CustomIcon(imagePath: 'assets/user.png')
                  : CustomIcon(imagePath: 'assets/user (3) 1.png'),
            ),
            label: '',
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 24,
        iconSize: 25,
        selectedIconTheme:
            IconThemeData(color: Colors.black), // Set selected icon color
        unselectedIconTheme:
            IconThemeData(color: Colors.grey), // Set unselected icon color
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
