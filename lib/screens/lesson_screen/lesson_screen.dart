import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eadicv/models/course/course.dart';
import 'package:eadicv/models/lesson/lesson.dart';
import 'package:eadicv/models/question/question.dart';
import 'package:eadicv/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
bool isInstructor = true;
bool isNew = false;


class LessonScreen extends StatefulWidget {
  LessonScreen({Key key, this.title, this.lesson, this.course,
                                this.isThisNew = false}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // t has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Lesson lesson;
  final Course course;
  final bool isThisNew;// = false;


  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _counter = 0;

  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  TextEditingController _titleController = new TextEditingController() ;
  TextEditingController _descriptionController ;
  TextEditingController _videoURLController ;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    //FIREBASE
    print("test");

    Lesson myLesson = new Lesson(
        title: "Lesson title",
        description: "Minha liçao",
        videoURL: "youtubil.com/aoisd");
    Course myCourse = new Course("Title", "Description", loginHelper.me);
    isNew = widget.isThisNew;
    _titleController.text = widget.lesson.title;
    //_videoURLController.text = widget.lesson.videoURL;
    //_descriptionController.text = widget.lesson.description;
    //myCourse.saveCourse();

    //Firestore.instance.collection("test").add();

    //YOUTUBE
    super.initState();

    //String videoURL = 'dQw4w9WgXcQ';
    if(isNew){
      widget.lesson.videoURL = 'dQw4w9WgXcQ';
    }
    else{

      _controller = YoutubePlayerController(
        //initialVideoId: _ids.first,
        initialVideoId: widget.lesson.videoURL,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHideAnnotation: true,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _idController = TextEditingController();
      _seekToController = TextEditingController();
    }

//    _videoMetaData = YoutubeMetaData();
//    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    if(!isNew){
      _controller.pause();

    }
    super.deactivate();
  }

  @override
  void dispose() {

    if(!isNew)
    {
      _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();

    }
    super.dispose();

  }

  void _saveLesson() {
    setState(() {

      //widget.lesson.videoURL = _videoURLController.text;
      widget.lesson.title = _titleController.text;

      if(isNew){
        widget.course.lessons.add(widget.lesson);
      }

      widget.course.saveCourse();
      print("salvei!!");
      Navigator.pop(context);

    });
  }


  void _addQuestion() {
    setState(() {

      widget.lesson.videoURL = _videoURLController.text;
      widget.lesson.title = _videoURLController.text;
      widget.course.saveCourse;

    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the LessonScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            (isInstructor == false) ?
            (Text(widget.lesson.title,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center))
            :
            (                        Container(
              width: 250,
              child: TextField(
                //expands: true,
                // expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                controller: _titleController,
                onChanged: (text) {
                  setState(() {
                    //saveColor = mainColor;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Titulo da Aula",
                    labelStyle:
                    TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ))

          ]),

          Row(children: <Widget>[
            (isInstructor == false) ?
            (Divider())
                :
            (Container(
              width: 250,
              child: TextField(
                //expands: true,
                // expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                controller: _videoURLController,
                onChanged: (text) {
                  setState(() {
                    //saveColor = mainColor;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Youtube URL",
                    labelStyle:
                    TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ))

          ]),
          Row(children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                child:
                isNew ? (Divider()) : (YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  topActions: <Widget>[
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        _controller.metadata.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                  onReady: () {
                    _isPlayerReady = true;
                  },
                  onEnded: (data) {
                    //_controller
                    //    .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                  },
                )
                ),

                )
          ]),
          Flexible(
            //height: 200.0,
            child: ListView.builder(
                //controller: listViewController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(10.0),
                itemCount: widget.lesson.questions.length,
                itemBuilder: (context, index) {
                  return _questionCard(context, index);
                }),
          ),
        ],
      ),

      floatingActionButton:
      (isInstructor == false) ? (FloatingActionButton(
        onPressed: _addQuestion,
        tooltip: 'Increment',
        child: Icon(Icons.add_comment),
      )) : (FloatingActionButton(
        onPressed: _saveLesson,
        tooltip: 'Increment',
        child: Icon(Icons.save),
      ))

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _questionCard(BuildContext context, int index) {
    int questionIndex = index;

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
                    Icon(Icons.question_answer),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 300,//(MediaQuery.of(context).size.width),
                      //height: 160,
                      child: Row(

                        children: <Widget>[
                          Flexible(
                            child:
                            Text(
                              widget.lesson.questions[questionIndex].question ?? "",
                              softWrap: true,overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(children: <Widget>[
                      SizedBox(
                          width: 200,
                          //height: 40,
                          child: ListView.builder(
                              //controller: listViewController,
                              //scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10.0),
                              itemCount:
                                  widget.lesson.questions[index].answers.length,
                              itemBuilder: (context, index) {
                                return _answerCard(context, index,
                                    widget.lesson.questions[questionIndex]);
                              })),
                      //height: 200.0,
                    ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }

  Widget _answerCard(BuildContext context, int index, Question question) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        question.answers[index].answer ?? "",
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    //onTap: () {},
  }
}
