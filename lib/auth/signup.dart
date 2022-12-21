// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace


import 'package:flutter/material.dart';
import 'package:last/auth/login.dart';
import 'package:last/features/services/auth_service.dart';

class Signup extends StatefulWidget {
  static const routeName = "/signup";
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Container(
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height > 550 ? 60 : 10,
                  ),
                  Center(
                    child: Text(
                      " Sign Up",
                      style: TextStyle(
                          fontSize: size.height > 540 ? 40 : 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: size.height > 550 ? 20 : 10,
                  ),
                  Center(
                      child: Text(
                    "Add your details to signup",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            label: Text("Name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter your Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            label: Text("Email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter your Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          prefixIcon: Icon(Icons.password),
                          label: Text("Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            prefixIcon: Icon(Icons.password),
                            label: Text("Confirm Password"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          child: Container(
                            width: 250,
                            height: 20,
                            child: Text("Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15)),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(108, 202, 244, 1),
                              side: BorderSide(
                                  width: 6,
                                  color: Color.fromRGBO(108, 202, 244, 1)),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 20)),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have a account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Center(
                            child: GestureDetector(
                              //add this gesturedetector for linking signup screen with a login screen
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    ));
  }
}
