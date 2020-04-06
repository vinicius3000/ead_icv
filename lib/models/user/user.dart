import 'dart:convert';
import 'package:eadicv/models/course/course.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String name = "";
  String email = "";
  List<Course> myCourses = List();
  QuerySnapshot querySnapshotinstructor;
  QuerySnapshot querySnapshotParticipant;

  User(this.name, this.email);

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email
      };

  factory User.fromJson(Map<String, dynamic> parsedJson){
    //print("User from JSON");

    String a = parsedJson['name'];
    String b = parsedJson['email'];
    User nusr = User(a,b);

    print (nusr.email);

    return nusr;
  }

  Future<void> retrieveCourses() async {

    await listCourses();

         this.myCourses.clear();
    querySnapshotinstructor.documents.forEach((f){
         Map<String, dynamic> json = f.data;
         //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type

         Course newCourse = new Course.fromJson(f.data);
        
         });

         print("Terminei");
         print("Nro de Courseos ${myCourses.length}");


    querySnapshotParticipant.documents.forEach((f){
      Map<String, dynamic> json = f.data;
      //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type

      Course newCourseP = new Course.fromJson(f.data);
        List<User> ptc = newCourseP.users;

        ptc.forEach((pct) {

          if (pct.email == this.email) {


            if (pct.email != this.email){
              print("Found me in an Course");
              //newCourseP.docID = f.documentID;
              //newCourseP.saveCourse();
              myCourses.add(newCourseP);
              //print(newCourse.title + ' - ' + newCourse.instructor.email + ' - ${newCourse.userList.length} ');
            }



          }

        });


    });

    ;
  }

  Future<bool> listCourses() async{

    /*querySnapshotinstructor = await
    //Firestore.instance.collection('Courses').where('title', isEqualTo: 'Meu Courseo').getDocuments();
    Firestore.instance.collection('Courses').getDocuments();
*/

    querySnapshotinstructor = await
    Firestore.instance.collection('Courses').
    where("instructor.email", isEqualTo: this.email).getDocuments();

    querySnapshotParticipant = await
    Firestore.instance.collection('Courses').getDocuments();

    print("My New Query Returned This number of DOCUMENTS ${querySnapshotParticipant.documents.length}" );


    if (querySnapshotParticipant.documents.length > 0){
      print("TRUE!!!!");
      return true;

    }
    else{
      print("Retornando");
      return true;

    }
    //retrieveCourses();

    return true;

  }

}

class Instructor extends User{
  Instructor(String name, String email) : super(name, email);

}

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
