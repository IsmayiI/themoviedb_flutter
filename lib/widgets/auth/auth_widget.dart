import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        centerTitle: true,
        title: Text('Login to your account'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
    );

    final linkStyle = textStyle.copyWith(
      color: Color.fromRGBO(1, 180, 228, 1),
      decoration: TextDecoration.none,
    );

    return Column(
      spacing: 16,
      children: [
        RichText(
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(
                text:
                    'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
              ),
              TextSpan(
                text: 'Click here ',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Действие на клик по ссылке
                  },
              ),
              TextSpan(
                text: 'to get started.',
              )
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(
                  text:
                      'If you signed up but didn\'t get your verification email, '),
              TextSpan(
                text: 'click here ',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Действие на клик по ссылке
                  },
              ),
              TextSpan(text: 'to have it resent.')
            ],
          ),
        ),
        _FormWidget(),
      ],
    );
  }
}

class _FormWidget extends StatefulWidget {
  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String? errorMessage;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;

    if (login == 'admin' && password == '123') {
      errorMessage = null;
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      errorMessage = 'Неправильный логин или пароль';
    }
    setState(() {});
  }

  void _resetPassword() {
    _passwordTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );

    final buttonStyle = ButtonStyle(
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      minimumSize: WidgetStatePropertyAll(Size(0, 0)),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );

    final inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(33, 37, 41, 0.2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(1, 179, 228, 0.3), width: 1),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      isCollapsed: true,
    );

    final errorMessage = this.errorMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        Text('Username', style: textStyle),
        TextField(
          decoration: inputDecoration,
          controller: _loginTextController,
        ),
        SizedBox(height: 16),
        Text('Password', style: textStyle),
        TextField(
          decoration: inputDecoration,
          controller: _passwordTextController,
          obscureText: true,
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: _auth,
              style: buttonStyle.copyWith(
                backgroundColor: WidgetStatePropertyAll(Color(0xFFdee2e6)),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xFF212529), fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: _resetPassword,
              style: buttonStyle,
              child: Text(
                'Reset password',
                style: TextStyle(
                    color: Color.fromRGBO(1, 180, 228, 1),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        )
      ],
    );
  }
}
