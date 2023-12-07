 import 'package:hive/hive.dart';

import '../db/db.dart';

  final username = Hive.box<User>("User");

String getusername() {
  
    final namebox = username.get("user");
    var ans = namebox!.name;
    return ans;
  }
   String getemail() {
    
    final namebox = username.get("user");
    var ans = namebox!.email;
    return ans;
  }