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

  final String question;
  final List<Answer> answers ;

  Question(this.question,  {this.answers});



  Map<String, dynamic> toJson() =>
      {
        'question': question,
        //'videoLink': videoLink,
        'answers': answers,
      };



  factory Question.fromJson(Map<String, dynamic> parsedJson){
    String question = parsedJson['question'];
    //List<String> answers = parsedJson['answers'];


//
    var listAnswers = parsedJson['answers'] as List;
    List<Answer> ans = listAnswers.map((i) => Answer.fromJson(i)).toList();


    Question newQuestion = new Question( question, answers: ans);

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



@JsonSerializable(explicitToJson: true)
class Answer{

  final String answer;

  Answer(this.answer);


  Map<String, dynamic> toJson() =>
      {
        'answer': answer,
        //'videoLink': videoLink,
      };



  factory Answer.fromJson(Map<String, dynamic> parsedJson){
    String answer = parsedJson['answer'];
    //List<String> answers = parsedJson['answers'];


//
//    var listAnswers = parsedJson['answers'] as List;
//    List<String> ans = listAnswers.map((i) => Question.fromJson(i)).cast<String>().toList();


    Answer newAnswer = new Answer( answer);

    return newAnswer;

  }


}

