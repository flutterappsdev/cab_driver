
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/main_page.dart';
import './screens/registration.dart';
import './screens/vehicleinfo.dart';
import './screens/loginpage.dart';
import './constants/globalvariables.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: 'BoltSemi',
         primarySwatch: Colors.blue,
         visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: FirebaseAuth.instance.currentUser.uid != null ? MainPage.id : LoginPage.id,
      routes: {
        MainPage.id : (context)=>MainPage(),
        LoginPage.id : (context)=>LoginPage(),
        RegistrationPage.id : (context)=>RegistrationPage(),
        VehicleInfo.Id : (context)=>VehicleInfo(),

      },
    );
  }
}

