import 'package:ecart/_util/common_function.dart';
import 'package:ecart/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  "Firebase Sucessfully connected".logIt;
  runApp(const MyApp());
}
