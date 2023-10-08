import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/controlles/LogInController.dart';
import 'Notes.dart';
import 'package:notes/reusable/NavBar.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  bool? _passwordVisible = false;
  void initState() {
    _passwordVisible = false;
  }
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xffE7EDFD),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(20),
                    child: Image.asset('assets/images/login.jpg'),
                  ),
                ],
              ),
              Text(
                'login',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),


              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('email:',
                        style: TextStyle(
                          fontSize: 20,
                        )).tr(),
                  ],
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('password:',
                        style: TextStyle(
                          fontSize: 20,
                        )).tr(),
                  ],
                ),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.015,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password,
                obscureText: !_passwordVisible!,
                decoration: InputDecoration(
                  prefixIcon:IconButton(
                    icon: Icon(
                      _passwordVisible! ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: ()
                    {
                      setState(() {
                        _passwordVisible = !_passwordVisible!;
                      });
                    },
                  ),

                  border: OutlineInputBorder(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await LogInController()
                      .login(_email.text, _password.text, context);

                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 10.0,
                  shadowColor: Colors.blue,
                ),
                child: Text(
                  'login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ).tr(),
              ),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.45,
                      child: Divider(
                        color: Colors.black,
                      ),),
                  Text(
                    'or',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Divider(
                      color: Colors.black,
                    ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/facebook.jpg'),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/google.jpg'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
