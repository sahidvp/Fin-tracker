import 'package:finance_tracker/db/db.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  void _saveSignupDetails(
      String username, String email, String password) async {
    final signupBox = await Hive.openBox<User>('User');
    final signupDetails = User(name: '', email: '', password: '')
      ..name = username
      ..email = email
      ..password = password;
    await signupBox.put('user', signupDetails);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: BottomOvalClipper(),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: const Color.fromARGB(255, 18, 54, 52),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Sign up',
                style: TextStyle(
                    color: Color.fromARGB(255, 18, 54, 52),
                    fontSize: 50,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your name',
                            filled: true,
                            fillColor: Color(0xFFCBCBCB),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Email',
                          filled: true,
                          fillColor: Color(0xFFCBCBCB),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          } else if (!RegExp(
                                  r'^[A-Za-z][A-Za-z0-9._%+-]*@(gmail\.com|outlook\.com|company\.com)$')
                              .hasMatch(value)) {
                            return 'Invalid email format or domain';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'create password',
                          filled: true,
                          fillColor: Color(0xFFCBCBCB),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          }

                          // Check for at least one special character
                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }

                          // Check for minimum length of 6 characters
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }

                          // Check for at least one number
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  const StadiumBorder(),
                                ),
                                elevation: const MaterialStatePropertyAll(30.0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(mycolor)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final username = _nameController.text;
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                _saveSignupDetails(username, email, password);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (ctx) {
                                  return const LoginPage();
                                }));
                              }
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 23,color:Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

 
}
