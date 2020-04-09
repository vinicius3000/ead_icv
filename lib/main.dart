import 'package:eadicv/screens/lesson_screen/lesson_screen.dart';
import 'package:eadicv/screens/login_screen/login_screen.dart';
import 'package:eadicv/screens/student_screen/student_screen.dart';
import 'package:flutter/material.dart';
import 'helpers/login_helper.dart';
import 'models/user/user.dart';

import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set default home.
  Widget _defaultHome = new LoginScreen();


  //print("${LoginHelper.internal().getUserNow().displayName} oi" );

  bool isLoggedIn = false;

   isLoggedIn = await LoginHelper.internal().isLoggedIn();


     // Get result of the login function.
     if (isLoggedIn) {
       print("To logado manhe!!!!!!!" + LoginHelper.internal().myUser().email);
       _defaultHome = new StudentScreen();
     }

     // Run app!
     runApp(new MaterialApp(
       title: 'App',
       home: _defaultHome,
       routes: <String, WidgetBuilder>{
         // Set routes for using the Navigator.
         '/home': (BuildContext context) => new StudentScreen(),
         '/login': (BuildContext context) => new LoginScreen()
       },
     ));
   }



//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//
//  User loginUser = new User(" ", " ");
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      //home: LessonScreen(title: 'EAD ICV'),
//      home: StudentScreen(),
//
//
//      //home: LoginScreen(user: loginUser),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//
//  @override
//  void initState() {
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Text("hi");
//  }
//  }


