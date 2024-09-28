import 'package:finance_tracker/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finance_tracker/db/add_date.dart';

class AddTransaction extends StatefulWidget {
  final Add_data? transaction;

  const AddTransaction({super.key, this.transaction});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final box = Hive.box<Add_data>('data');
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  DateTime date = DateTime.now();
  String? selectedItem;
  String? selectedItemi;
  final TextEditingController description = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController aamount = TextEditingController();
  FocusNode amountF = FocusNode();

  final List<String> _item = [
    "Transfer",
    'Deposite',
    'Transportation',
    'Food',
    'Other Expense',
    'Other Income'
  ];

  final List<String> _itemi = ['Income', "Expense"];

  @override
  void initState() {
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    amountF.addListener(() {
      setState(() {});
    });

    // Initialize the state with the provided transaction data if available
    if (widget.transaction != null) {
      selectedItemi = widget.transaction!.iN;
      aamount.text = widget.transaction!.amount;
      description.text = widget.transaction!.description;
      date = widget.transaction!.datetime;
      selectedItem = widget.transaction!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backgroundConainer(context),
            Positioned(
              top: 120,
              child: mainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          name(),
          const SizedBox(
            height: 30,
          ),
          ddescription(),
          const SizedBox(
            height: 30,
          ),
          amount(),
          const SizedBox(
            height: 30,
          ),
          how(),
          const SizedBox(
            height: 30,
          ),
          datetime(),
          const SizedBox(
            height: 30,
          ),
          const Spacer(),
          save(),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        if (validateFields()) {
          if (widget.transaction != null) {
            // Edit existing transaction
            widget.transaction!.iN = selectedItemi!;
            widget.transaction!.amount = aamount.text;
            widget.transaction!.description = description.text;
            widget.transaction!.datetime = date;
            widget.transaction!.name = selectedItem!;
            box.put(widget.transaction!.key, widget.transaction!);
          } else {
            // Add new transaction
            var add = Add_data(selectedItemi!, aamount.text, date,
                description.text, selectedItem!);
            box.add(add);
          }
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const HomePage()));
        } else {
          // Show an alert as fields are not filled
          showAlertDialog(context);
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: mycolor,
        ),
        width: 120,
        height: 50,
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  bool validateFields() {
    return selectedItem != null &&
        selectedItemi != null &&
        aamount.text.isNotEmpty;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Fields Required",
            style: TextStyle(color: mycolor),
          ),
          content: Text(
            "Please fill in all the required fields.",
            style: TextStyle(color: mycolor),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: mycolor),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Container datetime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: const Color(0xffC5C5C5)),
      ),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2023, 1, 1),
            lastDate: DateTime.now(),
          );
          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month}',
          style: TextStyle(fontSize: 15, color: mycolor),
        ),
      ),
    );
  }

  Padding how() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0xffC5C5C5)),
        ),
        child: DropdownButton<String>(
          value: selectedItemi,
          items: _itemi
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      Text(
                        e,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (context) {
            return _itemi
                .map(
                  (e) => Row(
                    children: [
                      Text(
                        e,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
                .toList();
          },
          hint: const Text(
            'Status',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: ((value) {
            setState(() {
              selectedItemi = value!;
            });
          }),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        maxLength: 7,
        keyboardType: TextInputType.number,
        focusNode: amountF,
        controller: aamount,
        decoration: InputDecoration(
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: "Amount",
          labelStyle: const TextStyle(
              fontSize: 17, color: Color.fromARGB(255, 176, 172, 172)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
        ),
      ),
    );
  }

  Padding ddescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: ex,
        controller: description,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: "Description",
          labelStyle: const TextStyle(
              fontSize: 17, color: Color.fromARGB(255, 176, 172, 172)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0xffC5C5C5)),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Image.asset('asset/image/$e.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        e,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (context) {
            return _item
                .map(
                  (e) => Row(
                    children: [
                      SizedBox(
                        width: 42,
                        child: Image.asset('asset/image/$e.png'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        e,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )
                .toList();
          },
          hint: const Text(
            'Category',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: ((value) {
            setState(() {
              selectedItem = value!;
            });
          }),
        ),
      ),
    );
  }

  Column backgroundConainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 18, 54, 52),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 7),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      'Add Transactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
