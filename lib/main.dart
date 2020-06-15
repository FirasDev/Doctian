import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/MyHomePage.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/screens/widgets/_DoctorProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/_LabProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/_PatientRegister.dart';
import 'package:hello_world/ui/user/screens/widgets/_PharmacyProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserRegister.dart';
import 'package:hello_world/covid/ui/covidMain.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/services/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

// import 'ui/user/MyHomePage.dart';
// import 'ui/user/_UserHome.dart';
// import 'ui/user/_UserMedicalRecords.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Doctian',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(color: Colors.white),
        primarySwatch: Colors.lightBlue,
      ),
      home: AppConfig.MAIN_USER == null ? MyHomePage() : HomeScreen(),
      routes: {'Home': (_) => HomeNotes()},
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 400,
//               child: Stack(
//                 children: <Widget>[
//                   Positioned(
//                     top: -40,
//                     width: width,
//                     height: 400,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage('assets/images/background.png'),
//                               fit: BoxFit.fill)),
//                     ),
//                   ),
//                   Positioned(
//                     height: 400,
//                     width: width + 20,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image:
//                                   AssetImage('assets/images/background-2.png'),
//                               fit: BoxFit.fill)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Login",
//                     style: TextStyle(
//                         color: Color.fromRGBO(49, 39, 79, 1),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromRGBO(196, 139, 198, 0.3),
//                             blurRadius: 5,
//                             offset: Offset(0, 0),
//                           )
//                         ]),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               border: Border(
//                                   bottom: BorderSide(color: Colors.grey[300]))),
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Username",
//                                 hintStyle: TextStyle(color: Colors.grey)),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               border: Border(
//                                   bottom: BorderSide(color: Colors.grey[300]))),
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Password",
//                                 hintStyle: TextStyle(color: Colors.grey)),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Center(
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: Color.fromRGBO(49, 39, 79, 1),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     height: 50,
//                     margin: EdgeInsets.symmetric(horizontal: 60),
//                     decoration: BoxDecoration(
//                         color: Color.fromRGBO(49, 39, 79, 1),
//                         borderRadius: BorderRadius.circular(50)),
//                     child: Center(
//                       child: Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                    Center(
//                     child: Text(
//                       "Create Account",
//                       style: TextStyle(
//                         color: Color.fromRGBO(49, 39, 79, 1),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }



