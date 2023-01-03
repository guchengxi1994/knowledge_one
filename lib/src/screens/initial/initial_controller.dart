import 'package:flutter/material.dart';

class InitialController extends ChangeNotifier {
  String? selectedDbType;
  TextEditingController linkNameController = TextEditingController();
  TextEditingController hostNameController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dbNameController = TextEditingController();

  changeSelectedDbType(String? s) {
    selectedDbType = s;
    notifyListeners();
  }

  String generateMysql() {
    return """
  ```toml
  title = "mysql config"

  db_type = "mysql"

  [database]
  name = "${linkNameController.text}"
  address = "${hostNameController.text}"
  port = ${portController.text}
  username = "${usernameController.text}"
  password = "${passwordController.text}"
  database = "${dbNameController.text}"
  ```
          """;
  }

  String generateMysqlConfig() {
    return """
title = "mysql config"

db_type = "mysql"

[database]
name = "${linkNameController.text}"
address = "${hostNameController.text}"
port = ${portController.text}
username = "${usernameController.text}"
password = "${passwordController.text}"
database = "${dbNameController.text}"
          """;
  }
}
