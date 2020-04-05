

import 'package:eadicv/models/course/course.dart';
import 'package:eadicv/models/lesson/lesson.dart';
import 'package:eadicv/screens/lesson_screen/lesson_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const mainColor = Colors.black45;


class StudentScreen extends StatefulWidget {

  //User user;  // = new Event("", _leadUser,_participantList);

  //StudentScreen();

  @override
  _StudentScreenState createState() => _StudentScreenState();
}


class _StudentScreenState extends State<StudentScreen> {

  //UserHelper userHelper = UserHelper();
  //final leadUser = new User("John Doe", "jdoe@gmail.com");
  //User me ;
  static FirebaseUser currentUser;
  //StudentHelper Student = new StudentHelper();
  final listViewController = ScrollController();
  String userText = "";
  //TextEditingController userTextController;
  bool isLoading = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Lesson myLesson = new Lesson();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    //me = new User("John Doe", "jdoe@gmail.com");

    print("Aqui");

    //FIREBASE
    print("test");
    //Firestore.instance.collection("Courses").document("doc").setData({"instructor" : "Calleb"});
    List<Lesson> myLessons;

    Lesson myLesson = new Lesson(title: "title", description: "description", videoURL: "youtubeURL");
    Course myCourse = new Course("Title", "Description", "Calleb");

    myCourse.saveCourse();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(userText),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        floatingActionButton:
        FloatingActionButton(
          onPressed: (){
            print("here");
            setState(() {
              userText = "Reloading, please wait...";
              isLoading = false;
              //getData();
              _showLessonPage(context, myLesson);

              //userText = me.name + "\n" + me.email;
            });

          },
          child: Icon(Icons.person_outline),
          backgroundColor: mainColor,
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
                  Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.centerRight,

                      child: RawMaterialButton(
                        shape: CircleBorder(),
                        fillColor: Colors.green,
                        elevation: 0.0,
                        child: Icon(Icons.find_in_page,
                            color: Colors.white, size: 23),
                        onPressed: () {
                          setState(() {
                            userText = "";
                          });
                        },
                      ))
                ],
              ),
            ) )

    );
  }


  Future<void> _showLessonPage
      (context, Lesson lesson) async {

    print('Clicado');
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            LessonScreen(lesson: lesson, title: "Liçao de casa"))
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