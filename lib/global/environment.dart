import 'dart:io';

class Environment {
  static String apiURL =
      Platform.isAndroid ? '192.168.0.4:3000' : 'localhost:3000';

  static String socketURL =
      Platform.isAndroid ? 'http://192.168.0.4:3000' : 'http://localhost:3000';
}
