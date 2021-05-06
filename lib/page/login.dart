import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/db/user_database.dart';
import 'package:todo_app/page/notes_page.dart';
import 'package:todo_app/page/singup.dart';
import 'package:todo_app/widget/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String emailId;
  late String password;

  Widget _submitButton() {
    final isFormValid = emailId.isNotEmpty && password.isNotEmpty;

    return Container(
      constraints: BoxConstraints.expand(height: 70),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: isFormValid ? null : Colors.grey.shade700,
          ),
          onPressed: () async {
            print('Login button clicked');
            final isValid = _formKey.currentState!.validate();
            if (isValid) {
              try {
                print('open try block');
                final user = await UsersDatabase.instance.readUser(emailId);
                print('open try block user $user');
                if (password != user.password) {
                  alertMessage("Wrong Password. Please enter valid password.");
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesPage(),
                    ),
                  );
                }
              } catch (e) {
                alertMessage(
                    "User not found. Please enter valid user credentials.");
              }
            }
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void alertMessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Exit'),
            ),
          ],
          title: Text(
            'Error',
          ),
          titlePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          titleTextStyle: TextStyle(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
          content: Text(errorMessage),
          contentTextStyle: TextStyle(color: Colors.white60, fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        );
      },
    );
  }

  Widget _createAccountLabel() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: Text('Register',
                  style: TextStyle(
                      color: Color(0xfff79c4f),
                      fontSize: 13,
                      fontWeight: FontWeight.w600)))
        ]));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'TO',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color(0xffe46b10),
        ),
        children: [
          TextSpan(
            text: ' DO',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    emailId = "";
    password = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                _title(),
                Form(
                  key: _formKey,
                  child: LoginFormWidget(
                      onChangedEmail: (emailid) =>
                          setState(() => this.emailId = emailid.trim()),
                      onChangedPassword: (password) =>
                          setState(() => this.password = password.trim())),
                ),
                _submitButton(),
                SizedBox(
                  height: 30,
                ),
                _createAccountLabel()
              ])),
        ]));
  }
}
