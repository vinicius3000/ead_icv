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

  final String title;
  final String description;
  final String videoURL;
  final String docID;
  final List<Question> questions;


  Lesson({this.title, this.description,  this.videoURL, this.docID, this.questions});

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        //'videoLink': videoLink,
        'description': description,
        'videoURL': videoURL
      };



  factory Lesson.fromJson(Map<String, dynamic> parsedJson){
    String title = parsedJson['title'];
    String description = parsedJson['description'];
    String videoURL = parsedJson['videoURL'];

    Lesson newLesson = new Lesson(title: title, description: description,videoURL: videoURL);

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
