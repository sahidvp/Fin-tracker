


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../db/db.dart';

class EditPersonalDetails extends StatefulWidget {
  final Box<User> userBox;

  // ignore: use_key_in_widget_constructors
  const EditPersonalDetails({Key? key, required this.userBox});

  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
   Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = widget.userBox.get('user');
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';
  }

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
          title: const Text('Edit Personal Details',style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: 
         
            
             Container(
             width: double.infinity,
             height: double.infinity,
             color: Colors.white,
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  Text(
                   'Edit Username',
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: mycolor),
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                 TextFormField(
                   controller: _nameController,
                   decoration: const InputDecoration(
                     hintText: 'Enter your name',
                     filled: true,
                     fillColor: Color(0xFFCBCBCB),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(15)),
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                  Text(
                   'Edit Email Address',
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: mycolor),
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                 TextFormField(
                   controller: _emailController,
                   decoration: const InputDecoration(
                     hintText: 'Enter your Email',
                     filled: true,
                     fillColor: Color(0xFFCBCBCB),
                     border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                        width: 5
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15),
                     
                       ),
                     ),
                   ),
                   
                 ),
                 const SizedBox(
                   height: 50,
                 ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children:[ ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all<Color>(mycolor),
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(25.0),
                         ),
                       ),
                     ),
                     onPressed: () {
                       final name = _nameController.text;
                       final email = _emailController.text;
                       // Update the user details in Hive
                       final user = widget.userBox.get('user');
                       user?.name = name;
                       user?.email = email;
                       widget.userBox.put('user', user!);
                       Navigator.of(context).pop();
                     },
                     child: const Text(
                       'Save',
                       style: TextStyle(fontSize: 23,color: Colors.white),
                     ),
                   ),]
                 ),
               ],
             ),
                  ),
          
           
        
      ),
    );
  }
}
