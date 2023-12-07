import 'package:finance_tracker/db/add_date.dart';
import 'package:finance_tracker/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'db/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AdddataAdapter());
  await Hive.initFlutter();
  await Hive.openBox<User>('User');
  await Hive.openBox<Add_data>("data");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF63B5AF),
      ),
      home: const SplashScreen(),
    );
  }
}
