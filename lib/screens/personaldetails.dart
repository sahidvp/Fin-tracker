import 'package:finance_tracker/db/db.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'editpersonaldetails.dart';

class PersonalDetails extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const PersonalDetails({Key? key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final Color mycolor = const Color.fromARGB(255, 18, 54, 52);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon( Icons.arrow_back_ios,color: Colors.white,)),
          backgroundColor: mycolor,
          title: const Text(
            'Personal Details',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<void>(
          future: openUserBox(), // Use FutureBuilder to open the Hive box
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final userBox = Hive.box<User>('User');
              final user = userBox.get('user');
              final username = user?.name ?? '';
              final email = user?.email ?? '';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 250,
                      ),
                      Positioned(
                        width: 100,
                        left: 156,
                        top: 100,
                        child: Container(
                          height: 95,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('asset/image/user avatar.png'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 530,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            width: 350,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 84, 148, 109), // Border color
                                  width: 3, // Border width
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: mycolor),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Email Address',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            width: 350,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 84, 148, 109),
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(email,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: mycolor)),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(mycolor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return EditPersonalDetails(userBox: userBox);
                              }));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.border_color_sharp,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Edit personal details',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              );
            } else {
              // You can display a loading indicator or other feedback while the Future is running
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<void> openUserBox() async {
    await Hive.openBox<User>('User'); // Open the Hive box
  }
}
