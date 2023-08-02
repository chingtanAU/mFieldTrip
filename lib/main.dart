import 'package:mfieldtrip/Login.dart';
import 'package:mfieldtrip/Signup.dart';
import 'package:mfieldtrip/Start.dart';
import 'package:flutter/material.dart';
import 'package:mfieldtrip/ss.dart';
import 'Home.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(

      theme: ThemeData(
          primaryColor: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>const Login(),
        "SignUp":(BuildContext context)=>const SignUp(),
        "start":(BuildContext context)=>const Start(),
        "createFieldTrip":(BuildContext context)=>const CreateFieldTrip(),
      },

    );
  }

}
