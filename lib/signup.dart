import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_project/api/api.dart';
import 'package:new_project/home.dart';
import 'package:new_project/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget{
  @override 
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'firstname' : null,
    'lastname' : null,
    'phone' : null,
    'email' : null,
    'password' : null,
  };

  bool _isLoading = false;

  DecorationImage _buildBackgroundImage(){
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/background.jpg'),
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop
      )
    );
  }

    Widget _buildFirstNameTextField(){
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Firstname', filled: true, fillColor: Colors.white
        ),
        keyboardType: TextInputType.text,
        validator: (String value){
          if(value.isEmpty) 
          return 'Enter Firstname';
        },
        onSaved: (String value){
          _formData['firstname'] = value;
        },
      );
    }

    Widget _buildLastNameTextField(){
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Lastname', filled: true, fillColor: Colors.white
        ),
        keyboardType: TextInputType.text,
        validator: (String value){
          if(value.isEmpty) return 'Enter Lastname';
        },
        onSaved: (String value){
          _formData['lastname'] = value;
        },
      );
    }
    Widget _buildPhoneTextField(){
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Phone', filled: true, fillColor: Colors.white
        ),
        keyboardType: TextInputType.text,
        validator: (String value){
          if(value.isEmpty) return 'Enter Phone';
        },
        onSaved: (String value){
          _formData['phone'] = value;
        },
      );
    }

    Widget _buildEmailTextField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email', filled: true, fillColor: Colors.white
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value){
        if(value.isEmpty || 
          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) return 'Enter a valid email';
      },
      onSaved: (String value){
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password', filled: true, fillColor: Colors.white
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (String value){
        if(value.isEmpty) return 'Enter Password';
      },
      onSaved: (String value){
        _formData['password'] = value;
      },
    );
  }

  Widget _buildLoginButtton(){
    return RaisedButton(
      onPressed: _isLoading ? null : _submitForm,
      child: Text('SignUp'),
    );
  }

  void _submitForm() async{
    if(!_formKey.currentState.validate() ){
      return;
    }
    _formKey.currentState.save();
    // print(_formData);

    setState(() {
      _isLoading = true;
    });

      var res = await CallApi().postData(_formData, 'register');
      var body = json.decode(res.body);
      // print(body);
      if(body['success']){
        SharedPreferences localStorage = await SharedPreferences.getInstance(); 
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));
        var userJson = localStorage.getString('user');
        print(userJson);

      }
    // Navigator.pushReplacementNamed(context, routeName)
    Navigator.push(context,
      new MaterialPageRoute(
        builder: (context) => Home()
      )
    );

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // firstname
                    _buildFirstNameTextField(),
                      SizedBox(height: 10.0),
                    // lastname
                    _buildLastNameTextField(),
                      SizedBox(height: 10.0),
                    // phone
                    _buildPhoneTextField(),
                      SizedBox(height: 10.0),
                    // email
                    _buildEmailTextField(),
                      SizedBox(height: 10.0),
                    // password
                    _buildPasswordTextField(),
                      SizedBox(height: 10.0),
                      _buildLoginButtton(),
                      Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                            new MaterialPageRoute(
                              builder: (context) => Login()
                            )
                          );
                        },
                        child: Text(
                          'Already Have Account',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}