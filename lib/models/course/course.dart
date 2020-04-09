import 'dart:convert';
import 'dart:async' show Future;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eadicv/models/lesson/lesson.dart';
import 'package:eadicv/models/user/user.dart';
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
class Course {
  final String title;
  final String description;
  final String instructor;
  final String docID;
  List<Lesson> lessons = new List<Lesson>();
  List<User> users = new List<User>();

  Course(this.title, this.description, this.instructor,
      {this.docID, this.lessons, this.users});

  Map<String, dynamic> toJson() => {
        'title': title,
        //'videoLink': videoLink,
        'description': description,
        'instructor': instructor,
        'lessons': lessons,
        'users': users
      };

  List<Lesson> getLessons() {
    return lessons;
  }

  factory Course.fromJson(Map<String, dynamic> parsedJson) {
    String title = parsedJson['title'];
    String description = parsedJson['description'];
    String instructor = parsedJson['instructor'];
    var listLessons = parsedJson['lessons'] as List;
    var listUsers = parsedJson['users'] as List;



    print("Mapping Lessons");
    List<Lesson> less = listLessons.map((i) => Lesson.fromJson(i)).toList();


    print("Mapping Users");
    List<User> usr = new List<User>();
    try {

      print("Mapping Users Try");
      usr = listUsers.map((i) => User.fromJson(i)).toList();

    } catch (e) {

      print("Mapping Users CATCH");
      usr = new List<User>();
    }


    print("Creating new course");
    Course newCourse =
        new Course(title, description, instructor, lessons: less, users: usr);

    return newCourse;
  }

  Future<bool> saveCourse() async {
    print('tentando Salvar!!');
    String newCourse = json.encode(this);
    print('codifiquei!!');
    //print("Copy from here:" + newCourse);
    Map<String, dynamic> map = jsonDecode(newCourse);
    print(newCourse);

    Firestore.instance.collection("Courses").add(map).then((_) {
      print('saved existing!!');
      return (true);
    });
  }
}
