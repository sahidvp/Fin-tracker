import 'package:finance_tracker/db/add_date.dart';
import 'package:finance_tracker/screens/addtrans/pages/addtransaction.dart';
import 'package:finance_tracker/screens/detailsoftransaction.dart';
import 'package:finance_tracker/screens/homepage.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  final TextEditingController _searchController = TextEditingController();
  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'Friday',
    'Saturday',
    'Sunday'
  ];

  late String _searchTerm = '';
  late String _filterOption = 'All';

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) {
                  return const HomePage();
                }),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: mycolor,
          title: const Text(
            'Transactions',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              // height: sh,
              color: mycolor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.black,
                            hintText: "Search",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(130, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchTerm = value.toLowerCase();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _showFilterOptions,
                        icon: const Icon(Icons.filter_list),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: sh * .68,
                child: _buildTransactionList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Add_data>('data').listenable(),
      builder: (context, Box<Add_data> box, _) {
        List<Add_data> filteredTransactions = box.values
            .where((transaction) =>
                transaction.name.toLowerCase().contains(_searchTerm) &&
                (_filterOption == 'All' ||
                    (transaction.iN == _filterOption) ||
                    (_filterOption == 'Day' &&
                        transaction.datetime.day == DateTime.now().day) ||
                    (_filterOption == 'Month' &&
                        transaction.datetime.month == DateTime.now().month) ||
                    (_filterOption == 'Year' &&
                        transaction.datetime.year == DateTime.now().year)))
            .toList();

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: filteredTransactions.length,
          itemBuilder: (context, index) {
            final transaction = filteredTransactions[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerLeft,
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  bool isConfirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text(
                            'Are you sure you want to delete this transaction?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );

                  return isConfirmed;
                } else {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) {
                    return AddTransaction(transaction: transaction);
                  })); // Don't show alert for other dismiss directions
                }
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  box.delete(transaction.key);
                } else if (direction == DismissDirection.startToEnd) {}
              },
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return DetailedTransaction(transaction: transaction);
                  }));
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset('asset/image/${transaction.name}.png'),
                ),
                title: Text(transaction.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Text(
                  ' ${day[transaction.datetime.weekday - 1]} , ${transaction.datetime.day} -${transaction.datetime.month}-${transaction.datetime.year} ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                trailing: Text("₹ ${transaction.amount}",
                    style: TextStyle(
                        color: transaction.iN == 'Income'
                            ? Colors.green
                            : Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            );
          },
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildFilterOption('All'),
              _buildFilterOption('Expense'),
              _buildFilterOption('Income'),
              _buildFilterOption('Day'),
              _buildFilterOption('Month'),
              _buildFilterOption('Year'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          _filterOption = option;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          option,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: _filterOption == option ? Colors.blue : mycolor,
          ),
        ),
      ),
    );
  }
}
