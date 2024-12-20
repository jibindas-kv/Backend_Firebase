import 'package:firebase_backend/Add_And_View/Product_add.dart';
import 'package:firebase_backend/Add_And_View/Product_view.dart';
import 'package:firebase_backend/Sorting/Add_product.dart';
import 'package:firebase_backend/Sorting/View_product.dart';
import 'package:firebase_backend/TO%20DO%20App/Home.dart';
import 'package:firebase_backend/TO%20DO%20App/Task_Add.dart';
import 'package:firebase_backend/TO%20DO%20App/Task_details.dart';
import 'package:firebase_backend/TO%20DO%20App/Task_update.dart';
import 'package:firebase_backend/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home()
    );
  }
}