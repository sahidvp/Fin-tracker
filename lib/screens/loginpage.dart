import 'package:finance_tracker/screens/homepage.dart';
import 'package:finance_tracker/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailandnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          ClipPath(
            clipper: BottomOvalClipper(),
            child: Container(
              width: double.infinity,
              height: 160,
              color: const Color.fromARGB(255, 18, 54, 52),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Form(
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Text(
                    'Log in',
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 54, 52),
                        fontSize: sh * .05,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailandnameController,
                    decoration: const InputDecoration(
                      hintText: 'email address',
                      filled: true,
                      fillColor: Color(0xFFCBCBCB),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'password',
                      filled: true,
                      fillColor: Color(0xFFCBCBCB),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your password ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              const StadiumBorder(),
                            ),
                            elevation: const MaterialStatePropertyAll(30.0),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(mycolor)),
                        onPressed: () {
                          loginfunction();
                        },
                        child: const Text(
                          'login',
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        )),
                  ),

                  //row
                  const SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        color: Colors.black,
                        height: 1,
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 130,
                        color: Colors.black,
                        height: 1,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const SignupPage();
                          }));
                        },
                        child: Text(
                          "sign up",
                          style: TextStyle(color: mycolor),
                        ))
                  ])
                ])),
          ),
        ]),
      )),
    );
  }

  loginfunction() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailandnameController.text;
      final password = _passwordController.text;

      final signupBox = await Hive.openBox<User>('user');
      final signupDetails = signupBox.get('user',
          defaultValue: User(name: '', email: '', password: ''));

      if (signupDetails != null &&
          signupDetails.email == email &&
          signupDetails.password == password) {
        // Save the user's login status in shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: mycolor,
            content: const Center(
              child: Text('Welcome to FinTrack'),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
          ),
        );
      }
    }
  }
}

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30); // Start from the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 30); // Create a quadratic bezier curve
    path.lineTo(size.width, 0); // Line to the top-right corner
    path.close(); // Close the path to complete the shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
