import 'package:flutter/material.dart';
import 'package:new_project/signup.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  
  final Map<String, dynamic> _formData = {
    'email' : null,
    'password' : null,
  };

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

  Widget _buildEmailTextField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email', filled: true, fillColor: Colors.white
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value){
        if(value.isEmpty || 
          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)){
              return 'Enter a valid email';
            }
            return '';
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
        if(value.isEmpty){
          return 'Enter Password';
        }
        return "";
      },
      onSaved: (String value){
        _formData['password'] = value;
      },
    );
  }

  Widget _buildLoginButtton(){
    return RaisedButton(
      onPressed: (){},
      child: Text('Login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                    // Email 
                    _buildEmailTextField(),
                    SizedBox(height: 10.0),
                    // Password
                    _buildPasswordTextField(),
                    SizedBox(height: 10.0),
                    _buildLoginButtton(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                            new MaterialPageRoute(
                              builder: (context) => SignUp()
                            )
                          );
                        },
                        child: Text(
                          'Create new Account',
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
              )
            ),
          ),
        ),
      ),
    );
  }
}