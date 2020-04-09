import 'dart:convert';
import 'dart:async' show Future;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eadicv/models/question/question.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class LessonHome extends StatefulWidget {
  @override
  _LessonHomeState createState() => _LessonHomeState();
}

class _LessonHomeState extends State<LessonHome> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

@JsonSerializable(explicitToJson: true)
class Lesson{

  String title;
  String description;
  String videoURL;
  String docID;
  List<Question> questions;


  Lesson({this.title, this.description,  this.videoURL, this.docID, this.questions}){
    if(questions == null){
      this.questions = new List<Question> ();
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        //'videoLink': videoLink,
        'description': description,
        'videoURL': videoURL,
        'questions': questions
      };



  factory Lesson.fromJson(Map<String, dynamic> parsedJson){
    String title = parsedJson['title'];
    String description = parsedJson['description'];
    String videoURL = parsedJson['videoURL'];

    print("parsing questions list");
    var listQuestions = parsedJson['questions'] as List;
    List<Question> qst = listQuestions.map((i) => Question.fromJson(i)).toList();


    print("creating new lesson");

    Lesson newLesson = new Lesson(title: title, description: description,
                              videoURL: videoURL, questions: qst);

    print("I found this new lesson" + title );
    return newLesson;

  }


  Future<bool> saveLesson() async{

    String newLesson = json.encode(this);
    //print("Copy from here:" + newLesson);
    Map<String, dynamic> map = jsonDecode(newLesson);


    Firestore.instance.collection("Lessons").document("newLesson").setData(map)
        .then((_) {
      print('saved existing!!');
      return (true);
    });
  }

}
