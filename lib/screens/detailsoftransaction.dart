

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/add_date.dart';
import '../data/utility.dart';

class DetailedTransaction extends StatelessWidget {
  DetailedTransaction({super.key, required this.transaction});
  final Add_data transaction;
  final mycolor = const Color.fromARGB(255, 18, 54, 52);
  //final tbox = Hive.box<Add_data>('data');

  final List months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: mycolor,
          title: const Text('Transaction Details'),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 800,
              decoration: BoxDecoration(
                color: mycolor,
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 700,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                  child: Column(
                    
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(59, 184, 146, 146),
                          border: Border.all(
                            color: Colors.black, // Set the color of the border
                            width: 2.0, // Set the width of the border
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'asset/image/${transaction.name}.png',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            color: transaction.iN == 'Income'
                                ? const Color.fromARGB(255, 182, 239, 185)
                                : const Color.fromARGB(255, 227, 175, 172),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            transaction.iN,
                            style: TextStyle(
                                color: transaction.iN == 'Income'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "₹ ${transaction.amount}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 35,),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Transaction details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),const SizedBox(height:30 ,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                          Text(
                            transaction.iN,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: transaction.iN == 'Income'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          )
                        ],
                      ),const SizedBox(height:20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                        
                          Text(
                            DateFormat('h:mm a').format(transaction.datetime),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                          Text(
                            "${months[transaction.datetime.month-1]} ${transaction.datetime.day}, ${transaction.datetime.year} ",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),const SizedBox(height:30),
                      Container(height: 2,
                      color: Colors.grey,),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[ Text(transaction.iN=="Income" ?"Earnings":"Spending",
                      style: const TextStyle(
                        fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color:Colors.grey,
                      ),),Text(
                        "₹ ${transaction.amount}",style: const TextStyle(
                           fontSize: 18,
                              fontWeight: FontWeight.bold,
                        ),
                      )]),const SizedBox(height: 50,), Container(height: 2,
                      color: Colors.grey,),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",style: TextStyle(
                             fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color:mycolor,
                          ),),
                           Text("₹ ${total()}",style: const TextStyle(
                             fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color:Colors.black,
                          ),)

                        ],
                      )

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
