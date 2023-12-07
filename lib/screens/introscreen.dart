import 'package:finance_tracker/screens/intromodel.dart';
import 'package:finance_tracker/screens/loginpage.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentindex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var _controller ;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (int index) {
              setState(() {
                currentindex = index;
              });
            },
            itemCount: contents.length,
            itemBuilder: (context, i) {
              if (i == 2) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 500,
                        width: 490,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 18, 54, 52),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 290,
                      ),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 18, 54, 52),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        contents[i].description,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(contents.length, (index) {
              return buildDot(index, context);
            })),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color.fromARGB(255, 30, 82, 79),
          ),
          height: 60,
          width: 350,
          margin: const EdgeInsets.all(40),
          child: TextButton(
              onPressed: () {
                if (currentindex == contents.length - 1) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const LoginPage();
                  }));
                }
                _controller.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              child: Text(
                currentindex == contents.length - 1 ? "Get started " : "Next",
                style: const TextStyle(fontSize: 22, color: Colors.white),
              )),
        )
      ]),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: currentindex == index ? 20 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 30, 82, 79),
      ),
    );
  }
}
