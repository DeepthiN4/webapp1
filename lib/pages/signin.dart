import 'package:flutter/material.dart';
import 'package:webapp/services/auth.dart';
import 'package:webapp/widget/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: Widgets().mainAppar() ,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Image.asset("assets/images/todos.png", height: 300,),
          SizedBox(height: 8,),
          Text("Notes App for you!",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold
          )
          ),
          SizedBox(height:16,),
          GestureDetector(
            onTap: (){
              authService.signInWithGoogle(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xffff59464),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Text("Sign In with Google",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                
              ),
              ),
              ),
          )
        
        
        ],
        ),
      )
    );
  }
}