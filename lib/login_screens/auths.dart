import 'package:aves/login_screens/signin.dart';
import 'package:aves/login_screens/signup.dart';
import 'package:flutter/material.dart';

class auth_page extends StatefulWidget {
  const auth_page({Key? key}) : super(key: key);

  @override
  State<auth_page> createState() => _auth_pageState();
}

class _auth_pageState extends State<auth_page> {
  bool log=true;
  @override
  Widget build(BuildContext context) => log
      ? signin(chSignup:toggle)
      : signup(chSignin:toggle);

  void toggle()=>setState(() => log=!log);
}
