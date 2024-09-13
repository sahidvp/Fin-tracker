import 'package:finance_tracker/db/add_date.dart';

import 'package:finance_tracker/data/utility.dart';
import 'package:finance_tracker/screens/profilepage.dart';
import 'package:finance_tracker/screens/transactionpage.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../db/db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ContainerStackExample(),
      ),
    );
  }
}

class ContainerStackExample extends StatefulWidget {
  const ContainerStackExample({super.key});

  @override
  State<ContainerStackExample> createState() => _ContainerStackExampleState();
}

class _ContainerStackExampleState extends State<ContainerStackExample> {
  // ignore: prefer_typing_uninitialized_variables
  var history;
  final box = Hive.box<Add_data>('data');

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 350,
                    ),
                    ClipPath(
                      clipper: BottomOvalClipper(),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        color: const Color.fromARGB(255, 18, 54, 52),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 150,
                      child: Container(
                        width: sw * .9,
                        height: sh * .5,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(
                                  255, 16, 95, 92), // Shadow color
                              blurRadius: 5, // Spread radius
                              offset: Offset(1,
                                  5), // Shadow position (in this case, below the box)
                            )
                          ],
                          color: const Color.fromARGB(255, 5, 80, 78),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Toatal Balance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '₹ ${total()}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 18, 54, 52),
                                        radius: 12,
                                        child: Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      )
                                    ]),
                                    Row(children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 18, 54, 52),
                                        radius: 12,
                                        child: Icon(Icons.arrow_upward,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Expenses',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      )
                                    ]),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹ ${income()}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                  Text(
                                    '₹ ${expenses()}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      width: 110,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const ProfilePage();
                          }));
                        },
                        child: Container(
                          height: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('asset/image/user avatar.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: 30,
                      child: Text(_username(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transaction History',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return const TransactionPage();
                              }));
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    history = box.values.toList()[index];
                    return getlist(history, index);
                  },
                  childCount: box.length,
                ),
              ),
            ],
          );
        });
  }

  Widget getlist(Add_data history, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get(index, history));
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.asset('asset/image/${history.name}.png')),
      title: Text(
        history.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(
        ' ${history.datetime.day} -${history.datetime.month}-${history.datetime.year}',
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      trailing: Text(
        '₹${history.amount}',
        style: TextStyle(
            color: history.iN == 'Income' ? Colors.green : Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  String _username() {
    final username = Hive.box<User>("User");
    final namebox = username.get("user");
    var ans = namebox!.name;
    return ans;
  }
}

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
