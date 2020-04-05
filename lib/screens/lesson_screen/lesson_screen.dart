import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const mainColor = Colors.black45;

class LessonScreen extends StatefulWidget {


  //User user;  // = new Event("", _leadUser,_participantList);

  LessonScreen();

  @override
  _LessonScreenState createState() => _LessonScreenState();
}


class _LessonScreenState extends State<LessonScreen> {

  //UserHelper userHelper = UserHelper();
  //final leadUser = new User("John Doe", "jdoe@gmail.com");
  //User me ;
  static FirebaseUser currentUser;
  //LessonHelper Lesson = new LessonHelper();
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

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Lesson"),
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

                     // getLogoff();

                      //userText = me.name + "\n" + me.email;
                    });
                    //_showLessonPage(user: me);
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
                    //getData();

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


}