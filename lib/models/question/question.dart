import 'dart:convert';
import 'dart:async' show Future;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eadicv/models/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class QuestionHome extends StatefulWidget {
  @override
  _QuestionHomeState createState() => _QuestionHomeState();
}

class _QuestionHomeState extends State<QuestionHome> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

@JsonSerializable(explicitToJson: true)
class Question{

  final String title;
  final String description;
  final String instructor;
  final String docID;
  final List<Lesson> lessons;

  Question(this.title, this.description,  this.instructor, {this.docID, this.lessons});



  Map<String, dynamic> toJson() =>
      {
        'title': title,
        //'videoLink': videoLink,
        'description': description,
        'instructor': instructor
      };



  factory Question.fromJson(Map<String, dynamic> parsedJson){
    String title = parsedJson['title'];
    String description = parsedJson['description'];
    String instructor = parsedJson['instructor'];

    Question newQuestion = new Question(title,description, instructor);

    return newQuestion;

  }


  Future<bool> saveQuestion() async{

    String newQuestion = json.encode(this);
    //print("Copy from here:" + newQuestion);
    Map<String, dynamic> map = jsonDecode(newQuestion);


    Firestore.instance.collection("Questions").document("newQuestion").setData(map)
        .then((_) {
      print('saved existing!!');
      return (true);
    });
  }

}
