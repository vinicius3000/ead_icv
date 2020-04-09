import 'package:eadicv/models/course/course.dart';
import 'package:eadicv/models/lesson/lesson.dart';
import 'package:eadicv/models/question/question.dart';
import 'package:eadicv/models/user/user.dart';
import 'package:eadicv/screens/lesson_screen/lesson_screen.dart';
import 'package:eadicv/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

const mainColor = Colors.black45;

enum OrderOptions { orderaz, orderza }

final User user = new User("", "");

class StudentScreen extends StatefulWidget {

  StudentScreen({Key key, this.title, this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User user;

  @override
  _StudentScreenState createState() => _StudentScreenState();
}


class _StudentScreenState extends State<StudentScreen> {

  static FirebaseUser currentUser;
  final listViewController = ScrollController();
  String userText = "";
  bool isLoading = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Lesson myLesson = new Lesson();
  Question myQuestion = new Question("Qua?");
  Question myQuestion2 = new Question("Qua?");
  Question myQuestion3 = new Question("Qua?");
  List<Lesson> myLessons;
  List<Question> myQuestions;
  List<String> myAnswers;





  @override
  void initState() {

    //super.initState();


    WidgetsFlutterBinding.ensureInitialized();

    //_showLoginPage(context);

    //me = new User("John Doe", "jdoe@gmail.com");
    print("Aqui");
    //FIREBASE
    print("test");
    //Firestore.instance.collection("Courses").document("doc").setData({"instructor" : "Calleb"});

    myLessons = new List<Lesson> ();
    myQuestions = new List<Question> ();
    myAnswers = new List<String> ();
    myAnswers.add("Certamente!!");
    //myAnswers.add("Nao!!!!!");

    myQuestion = new Question("Tem que abrir bem as pernas e os bracos?", answers: myAnswers);
    myQuestion2 = new Question("Qual a chance de escorregar?", answers: myAnswers);
    myQuestion3 = new Question("Poderia fazer uma versao com o Calleb executando?", answers: myAnswers);


    myQuestions.add(myQuestion);
    myQuestions.add(myQuestion2);
    myQuestions.add(myQuestion3);


    Lesson myLesson = new Lesson(title: "Aula de Ioga",
                                description: "description",
                                videoURL: "aAWYyU8povw",
                                questions:  myQuestions);


    Lesson myLesson2 = new Lesson(title: "This is Home",
        description: "description",
        videoURL: "W6TSOymYmPU");

    Lesson myLesson3 = new Lesson(title: "CallebSon",
        description: "description",
        videoURL: "W6TSOymYmPU");

    //List<Lesson> myLessons = new List<Lesson>;
    myLessons.add(myLesson);
    myLessons.add(myLesson2);
    myLessons.add(myLesson3);


    Course myCourse = new Course("Title", "Description", "Calleb",
                                              docID: "", lessons: myLessons);

    //myCourse.lessons.add(myLesson);
    //myCourse.lessons.add(myLesson2);

    //List<Lesson> lessons = myCourse.lessons;

    myCourse.saveCourse();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Aulas do Curso de Ioga"),
        backgroundColor: mainColor,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                  child: Text("Eventos mais proximos primeiro"),
                  value: OrderOptions.orderaz,
                ),
                const PopupMenuItem<OrderOptions>(
                  child: Text("Eventos mais distantes primeiro"),
                  value: OrderOptions.orderza,
                ),
              ],
              onSelected: (context) {
                if (context == OrderOptions.orderaz) {
                  print("Ordenando lista" + context.toString());
                  setState(() {
                    //lessons.sort((a, b) => a.dateStart.compareTo(b.dateStart));
                  });
                } else {
                  print("Ordenando lista" + context.toString());
                  setState(() {
                    //events.sort((b, a) => a.dateStart.compareTo(b.dateStart));
                  });
                }

                //Aqui é onde estou chamando o orderList da classe no outro código
              })
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                backgroundColor: mainColor,
                heroTag: "leftButton",
                onPressed: () {
                  _showLoginPage(context);
                },
                child: Icon(Icons.person_outline),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                heroTag: "rightButton",
                onPressed: () {
                  //User leadUser = me;
                 // List<Participation> lp = List();
                 // _showEventPage(event: Event("", leadUser, lp));
                },
                child: Icon(Icons.add),
                backgroundColor: mainColor),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: RefreshIndicator(
                onRefresh: (){},//_refresh,
                child: ListView.builder(
                  //controller: listViewController,
                    padding: EdgeInsets.all(10.0),
                    itemCount: myLessons.length,
                    itemBuilder: (context, index) {
                      return _eventCard(context, index);
                    }),
              ))
        ],
      ),
    );
  }

  Widget _eventCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 80.0,
                child:

                //TODO image
                Icon(Icons
                    .ondemand_video),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      myLessons[index].title ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      myLessons[index].title ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showLessonPage(context, myLessons[index]);
      },
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


  Future<void> _showLoginPage
      (context) async {

    print('Clicado');
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            LoginScreen(user: user))
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