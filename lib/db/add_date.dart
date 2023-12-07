import 'package:hive_flutter/hive_flutter.dart';
part 'add_date.g.dart';

@HiveType(typeId: 1)
class Add_data extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String iN;
  @HiveField(4)
  DateTime datetime;
  Add_data(this.iN, this.amount, this.datetime, this.description, this.name);
}
