import 'package:flutter/material.dart';
import 'package:todo_app/db/user_database.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/page/login.dart';
import 'package:todo_app/widget/signup_form_widget.dart';

class SignupPage extends StatefulWidget {
  SignupPage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
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
            print('Singup button clicked');
            final isValid = _formKey.currentState!.validate();
            if (isValid) {
              final User user =
                  new User(name: name, emailId: emailId, password: password);

              final resUser = await UsersDatabase.instance.create(user);
              if (resUser.id! > 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                print('Signup failed');
              }
            }
          },
          child: Text(
            'Singup',
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
            titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            titleTextStyle: TextStyle(color: Colors.white60, fontSize: 16),
            content: Text(errorMessage),
            contentTextStyle: TextStyle(color: Colors.white60, fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          );
        });
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
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Login',
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
    name = '';
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
                  child: SignupFormWidget(
                      onChangedName: (name) =>
                          setState(() => this.name = name.trim()),
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
