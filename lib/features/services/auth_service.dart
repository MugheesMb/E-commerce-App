import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:last/models/usermodel.dart';
import 'package:last/utils/errorhandle.dart';
import 'package:last/utils/snak.dart';


String uri = 'http://localhost:3000';

class AuthService {

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      //it will help us to make a request to api URL
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        //client data
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Account Created! Now you can Login..!');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()),
              ModalRoute.withName('/'));
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }


}
