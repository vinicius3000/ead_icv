import 'dart:convert';
import 'dart:async' show Future;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eadicv/models/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class CourseHome extends StatefulWidget {
  @override
  _CourseHomeState createState() => _CourseHomeState();
}

class _CourseHomeState extends State<CourseHome> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

@JsonSerializable(explicitToJson: true)
class Course{

  final String title;
  final String description;
  final String instructor;
  final String docID;
  final List<Lesson> lessons;

  Course(this.title, this.description,  this.instructor, {this.docID, this.lessons});



  Map<String, dynamic> toJson() =>
      {
        'title': title,
        //'videoLink': videoLink,
        'description': description,
        'instructor': instructor
      };



  factory Course.fromJson(Map<String, dynamic> parsedJson){
    String title = parsedJson['title'];
    String description = parsedJson['description'];
    String instructor = parsedJson['instructor'];

    Course newCourse = new Course(title,description, instructor);

    return newCourse;

  }


  Future<bool> saveCourse() async{

    String newCourse = json.encode(this);
    //print("Copy from here:" + newCourse);
    Map<String, dynamic> map = jsonDecode(newCourse);


      Firestore.instance.collection("Courses").document("newcourse").setData(map)
          .then((_) {
        print('saved existing!!');
        return (true);
      });
  }

}
