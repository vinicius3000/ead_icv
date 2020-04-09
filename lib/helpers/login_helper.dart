import 'dart:async';
import 'package:eadicv/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginHelper {

  static final LoginHelper _instance = LoginHelper.internal();

  factory LoginHelper()  {


    return _instance;
  }
  //=> _instance ;

  LoginHelper.internal();


  final GoogleSignIn googleSignIn = GoogleSignIn();
  final User me = new User("","");
  FirebaseUser _currentUser;
  bool isSignedIn = false;
  //LoginHelper.internal(this._currentUser);

  //static final LoginHelper _instance = LoginHelper.internal();
  //factory LoginHelper() => _instance;

  FirebaseUser getUserNow(){
    return _currentUser;
  }

  User myUser(){
    return me;
  }

  Future<FirebaseUser> getUser() async {

    if(_currentUser !=null) return _currentUser;

    try {
      final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken

      );

      final AuthResult authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      //final FirebaseUser user = authResult.user;
      _currentUser = authResult.user;
      me.name = _currentUser.displayName;
      me.email = _currentUser.email;
      print("Setei meu email para ${_currentUser.email}");
      print("Setei meu nome para ${_currentUser.displayName}");

      return _currentUser;

    } catch (error){

    }
  }

  bool isLoggedIn()  {

      return isSignedIn;
    }


 Future<bool> isLoggedInFuture() async {
   if(googleSignIn.isSignedIn() != null){
     if(await googleSignIn.isSignedIn() == true) {return true;};
   }
   else{
     return false;
   }

 }
  void logout() async {

    if(googleSignIn.isSignedIn() != null){
      googleSignIn.signOut();
      print("Vazei");
    }

    try {

      //final FirebaseUser user = authResult.user;
      _currentUser = null;
      me.name = "John Doe";
      me.email = "jdoe@gmail.com";
      print("Setei meu email para ${me.email}");
      print("Setei meu nome para ${me.name}");


    } catch (error){

    }
  }


}
