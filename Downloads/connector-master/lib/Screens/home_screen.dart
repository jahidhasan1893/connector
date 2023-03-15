import 'package:connector/Screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../Pages/home_page.dart';
import '../Pages/profile_page.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool is_message_page=true;

  final List<Widget> _pages = [    PageOne(),    PageTwo(),    PageThree(),  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Connector'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black87,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if(_currentIndex!=0) is_message_page=false;
            else is_message_page=true;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messsges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Stories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton:Visibility(
        visible: is_message_page,
        child: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>SearchScreen(),
            ),
          );
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),

      )
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No stories available',style: TextStyle(
        fontSize: 15,
      )),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfilePage();
  }
}


