import 'package:eadicv/helpers/login_helper.dart';
import 'package:eadicv/screens/student_screen/student_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eadicv/models/user/user.dart';

const mainColor = Colors.black45;

class LoginScreen extends StatefulWidget {

  User user;
  LoginScreen({this.user});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  User me ;
  static FirebaseUser currentUser;
  LoginHelper loginHelper = new LoginHelper();
  final listViewController = ScrollController();
  String userText = "";
  bool isLoading = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

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

                    });

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

    loginHelper.logout();

    print("NewUserText:" + userText);

    setState(() {
      userText = widget.user.name + "\n" + widget.user.email;
      print("Widget user name: " + widget.user.name);
    });
  }


  Future getData() async {
    //await new Future.delayed(const Duration(seconds: 5));

    await loginHelper.getUser();
    me = loginHelper.myUser();

    userText = me.name + "\n" + me.email;
    print("NewUserText:" + userText);

    await getUserCourses();

    setState(() {
      userText = me.name + "\n" + me.email;
      //print("Widget user name: " + widget.user.name);
      isLoading = true;
      _showStudentPage(context, me);
      //Navigator.pop(context);
    });


  }


  Future<void> getUserCourses() async {

    print("retrieving list of courses for " + loginHelper.me.email);
    await loginHelper.me.retrieveCourses().whenComplete((){
      print(loginHelper.me.email);

      print("retrieved list of courses for " + loginHelper.me.email);
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
    }

  }

}