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
  String title;
  String description;
  User instructor;
  String docID;
  List<Lesson> lessons = new List<Lesson>();
  List<User> users = new List<User>();

  Course(this.title, this.description, this.instructor,
      {this.docID, this.lessons, this.users});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'instructor': instructor,
        'lessons': lessons,
        'users': users,
        'docID' : docID
      };

  List<Lesson> getLessons() {
    return lessons;
  }

  factory Course.fromJson(Map<String, dynamic> parsedJson) {
    String title = parsedJson['title'];
    String description = parsedJson['description'];
    String docID = parsedJson['docID'];
    var listLessons = parsedJson['lessons'] as List;
    var listUsers = parsedJson['users'] as List;
    User instructor = new User("","");


    print("Erro aqui?");

    try {instructor = User.fromJson(parsedJson['instructor']);}
    catch (e){
      print("Nao consegui converter do banco para instrutor");
    }


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
      new Course(title, description, instructor, lessons: less, users: usr, docID: docID);

      return newCourse;
    }


  Future<bool> saveCourse() async {

    if (docID == null){
      print('tentando Salvar novo!!');
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
    else {
      print('tentando Salvar existente!!');
      String newCourse = json.encode(this);
      print('codifiquei!!');
      //print("Copy from here:" + newCourse);
      Map<String, dynamic> map = jsonDecode(newCourse);
      print(newCourse);

      Firestore.instance.collection("Courses").document(docID).setData(map).then((_) {
        print('saved existing!!');
        return (true);
      });
    }

  }
}
