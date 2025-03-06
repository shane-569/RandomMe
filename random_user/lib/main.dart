import 'package:flutter/material.dart';
import 'package:random_user/core/di/injection_container.dart' as di;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
