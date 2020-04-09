import 'dart:ffi';

import 'package:eadicv/helpers/login_helper.dart';
import 'package:eadicv/screens/student_screen/student_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eadicv/models/user/user.dart';

const mainColor = Colors.black45;

class LoginScreen extends StatefulWidget {


  User user;  // = new Event("", _leadUser,_participantList);

  LoginScreen({this.user});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  //UserHelper userHelper = UserHelper();
  //final leadUser = new User("John Doe", "jdoe@gmail.com");
  User me ;
  static FirebaseUser currentUser;
  LoginHelper login = new LoginHelper();
  final listViewController = ScrollController();
  String userText = "";
  //TextEditingController userTextController;
  bool isLoading = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    //me = new User("John Doe", "jdoe@gmail.com");
    //me = widget.user;
    //userText = widget.user.name + "\n" + widget.user.email;
    //me.email = "viniciusandreatta@gmail.com";
    //me.email = currentUser.email;
    //me.name = currentUser.displayName;


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        floatingActionButton:

        Stack(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left:31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  heroTag: "leftButton",
                  onPressed: (){

                    setState(() {
                      userText = "Reloading, please wait...";

                      getLogoff();

                      //userText = me.name + "\n" + me.email;
                    });
                    //_showLoginPage(user: me);
                    //print("new user email!!!!!!!!!!!!!"+ me.email);
                    //me = user;

                  },
                  child: Icon(Icons.exit_to_app),),
              ),),

            Align(
              alignment: Alignment.bottomRight,
              child:
              FloatingActionButton(
                onPressed: (){

                  setState(() {
                    userText = "Reloading, please wait...";
                    isLoading = false;
                    getData();

                    //userText = me.name + "\n" + me.email;
                  });

                },
                child: Icon(Icons.person_outline),
                backgroundColor: mainColor,
              ),
            ),
            isLoading ? (Center ())
                : Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),

        body:
        SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: mainColor),
                  Text(userText,
                    //controller: userTextController,
                    style: TextStyle(fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                ],
              ),
            ) )

    );
  }

  Future getLogoff() async {
    //await new Future.delayed(const Duration(seconds: 5));

    login.logout();
    //User me = login.myUser();

    //widget.user.name = "John Doe";
    //widget.user.email = "jdoe@gmail.com";


    //userText = widget.user.name + "\n" + widget.user.email;
    print("NewUserText:" + userText);
    //build(context);

    setState(() {
      userText = widget.user.name + "\n" + widget.user.email;
      print("Widget user name: " + widget.user.name);
    });
  }


  Future getData() async {
    //await new Future.delayed(const Duration(seconds: 5));

    await login.getUser();
    me = login.myUser();

    //widget.user.name = me.name;
    //widget.user.email = me.email;


    userText = me.name + "\n" + me.email;
    print("NewUserText:" + userText);
    //build(context);

    setState(() {
      userText = me.name + "\n" + me.email;
      //print("Widget user name: " + widget.user.name);
      isLoading = true;
      _showStudentPage(context, me);
      //Navigator.pop(context);

    });
  }

  Future<void> _showStudentPage
      (context, User user) async {

    print('Clicado');
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            StudentScreen(user: me, title: "Meus Cursos"))
    );
    if (recContact != null) {
      print('not Null');
      if (null != null) {
      } else {
      }
    }
    else{
      //_refresh();
      //When comming back to this page
    }

  }

}