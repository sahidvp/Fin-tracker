//import 'package:finance_tracker/screens/privacypolicy.dart';
import 'package:finance_tracker/screens/privacypolicy.dart';
import 'package:finance_tracker/screens/termscondition.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';


class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  Color mycolor =const Color.fromARGB(255, 18, 54, 52);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
          centerTitle: true,
          backgroundColor: mycolor,
          title: const Text(
            "Help",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const TermsConditionsScreen();
                }));
              },
              leading: Icon(
                Icons.description,
                color: mycolor,
                size: 30,
              ),
              title: const Text("Terms and condition",style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  
                ),),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const PrivacyPolicyScreen();
                }));
              },
              leading: Icon(
                Icons.policy_sharp,
                color: mycolor,
                size: 30,
              ),
              title: const Text("privacy policy",style: 
               TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  
                ),),
            ),
            
           
          ],
          
        ),
        bottomSheet: Padding(padding: const EdgeInsets.all(0),
          child: FutureBuilder<String>(
          future: getAppVersion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(), 
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                child: Text(
                  'App Version: ${snapshot.data}',
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14, color: Colors.black),
                ),
              );
            }
          },
              ),
        ),
      ),
    );
  }
  Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
}
