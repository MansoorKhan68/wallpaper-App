import 'package:flutter/material.dart';
import 'package:panel_app/pages/accounts_page/accounts_page.dart';
import 'package:panel_app/pages/explore_page/explore_page.dart';
import 'package:panel_app/pages/home_page/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // create a variable to controll the nav bar visibility
  bool isVissible = true;
  // create a variaable to hold current state of the page
  int _currentIndex = 0;
  // create a list to store all pages
  List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      MyHomePage(afterScrollResult: afterScrollResultFunction),
     const ExplorePage(),
      const AccountsPage()];
  }
// function to handle after scroll result value
afterScrollResultFunction(bool visibility){
  setState(() {
    isVissible = visibility;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // ANIMATED CONTAINER TO CONTROLL THE BOTTOM NAV BAR
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        height: isVissible ? 80 : 0,
     child:   BottomNavigationBar(
      elevation: 0,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        iconSize: 32,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (value) {
         setState(() {
            _currentIndex = value;
         });
        },
        items: const [
        BottomNavigationBarItem(
          label: "Home",
            icon: Icon(
          Icons.home,
        )),
        BottomNavigationBarItem(
          label: "Explore",
          icon: Icon(Icons.card_giftcard)),
          BottomNavigationBarItem(
          label: "Account",
          icon: Icon(Icons.account_box_outlined)),
      ]),
    ));
  }
}
