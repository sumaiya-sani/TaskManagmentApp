import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import 'addTask.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
   int _selectedIndex=0;
   static final List<Widget>_widgetOptions=<Widget>[
     const AddPage(),
  
   ];

   void _onTapItem(int index){
     print('${_selectedIndex}');
     setState(() {
       _selectedIndex=index;
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap:_onTapItem ,
          elevation: 10,
          unselectedItemColor: Colors.brown,
          showSelectedLabels:false ,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled),

                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_note_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_note_filled),
                label: "Search"),
          ],
        ),

    );
  }
}
