import 'package:hive/hive.dart';

class HiveParamter {

  String path;
  HiveInterface hive = Hive;

  HiveParamter(
      {required this.path, required this.hive});
}
