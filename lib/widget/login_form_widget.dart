import 'package:flutter/material.dart';
import 'package:todo_app/utils/utils.dart';

class LoginFormWidget extends StatelessWidget {
  final String? email;
  final String? password;
  final ValueChanged<String> onChangedEmail;
  final ValueChanged<String> onChangedPassword;

  const LoginFormWidget({
    Key? key,
    this.email = '',
    this.password = '',
    required this.onChangedEmail,
    required this.onChangedPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildEmail(),
              SizedBox(height: 16),
              buildPassword(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildEmail() => TextFormField(
        maxLines: 1,
        initialValue: email,
        style: TextStyle(
          color: Colors.white60,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple.shade400,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade400,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple.shade400,
              style: BorderStyle.solid,
            ),
          ),
          hintText: 'Enter Email id',
          hintStyle: TextStyle(color: Colors.white60, fontSize: 16),
        ),
        validator: (emailId) =>
            emailId != null && emailId.isEmpty && emailId.isValidEmail()
                ? 'Enter valid email id'
                : null,
        onChanged: (text) {
          onChangedEmail(text);
        },
      );

  Widget buildPassword() => TextFormField(
        maxLines: 1,
        initialValue: password,
        obscureText: true,
        style: TextStyle(color: Colors.white60, fontSize: 16),
        decoration: InputDecoration(
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple.shade400,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple.shade400,
              style: BorderStyle.solid,
            ),
          ),
          hintText: 'Enter Password',
          hintStyle: TextStyle(color: Colors.white60, fontSize: 16),
        ),
        validator: (password) =>
            password != null && password.isEmpty && (password.length >= 7)
                ? 'Enter valid password'
                : null,
        onChanged: onChangedPassword,
      );
}
