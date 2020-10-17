import 'package:cab_driver/constants/branb_colour.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../tabs/hometab.dart';
import '../tabs/earningtab.dart';
import '../tabs/ratingtab.dart';
import '../tabs/profiletab.dart';

class MainPage extends StatefulWidget  {
  static const id = 'MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  int selectedIndex =0;

  void onitemClicked(int index){
    setState(() {
      selectedIndex = index;
      _tabController.index= selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            HomeTab(),
            Earning(),
            RatingTab(),
            ProfileTab(),
          ],

        ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card),title: Text('Earnings')),
          BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('Ratings')),
          BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('Account')),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: BrandColors.colorIcons,
        selectedItemColor: BrandColors.colorOrange,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 13),
        type: BottomNavigationBarType.fixed,
        onTap: onitemClicked,
      ),

    );
  }
}
