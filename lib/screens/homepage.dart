import 'package:finance_tracker/screens/addtrans/pages/addtransaction.dart';
import 'package:finance_tracker/screens/graphicalpage.dart';
import 'package:finance_tracker/screens/homescreen.dart';
import 'package:finance_tracker/screens/profilepage.dart';
import 'package:finance_tracker/screens/transactionpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentselectindex = 0;
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  final _pages = [
    const HomeScreen(),
    const GraphicalPage(),
    const TransactionPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
     shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const AddTransaction();
          }));
        },
        backgroundColor: mycolor,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation:
      
          FloatingActionButtonLocation.centerDocked,
      body: _pages[_currentselectindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
          currentIndex: _currentselectindex,
          onTap: (newindex) {
            setState(() {
              _currentselectindex = newindex;
            });
          },
       type: BottomNavigationBarType.fixed,

          selectedItemColor: mycolor,
          unselectedItemColor: Colors.grey,
           showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bar_chart_sharp,
                  size: 30,
                ),
                label: 'Statistics'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.swap_horiz,
                  size: 30,
                ),
                label: 'transaction'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 30,
                ),
                label: 'profile')
          ]),
    );
  }
}
