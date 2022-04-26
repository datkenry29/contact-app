
import 'dart:developer';

import 'package:contact_app/screens/add_screen/add_screen.dart';
import 'package:contact_app/screens/main_screen/my_search.dart';
import 'package:contact_app/screens/main_screen/widgets/list_contact/list_contact.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ListContactState> _listContactState = GlobalKey<ListContactState>();

  void updateListContact() {
    _listContactState.currentState!.refreshListContact();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearch());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: ListContact(key: _listContactState, searchText: "",),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddScreen(notifyChangeData: updateListContact,))
          );
        },
        tooltip: "Add new contact",
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          log(index.toString());
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
