import 'package:daily_expenses/screens/balance.dart';
import 'package:flutter/material.dart';
import 'package:daily_expenses/authentication.dart';

import '../functions.dart';
import 'expenses.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Expenses(),
        'title': 'Dialy Expenses',
      },
      {
        'page': WalletScreen(),
        'title': 'Balance',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authentication(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Daily Expenses'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Balance'),
          ),
        ],
      ),
    );
  }
}
