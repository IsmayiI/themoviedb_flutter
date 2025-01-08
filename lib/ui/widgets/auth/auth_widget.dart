import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';

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
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
    );

    final linkStyle = textStyle.copyWith(
      color: AppColors.lightBlue,
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

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context);

    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );

    const borderRadius = BorderRadius.all(Radius.circular(6));

    const buttonStyle = ButtonStyle(
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: borderRadius)),
      minimumSize: WidgetStatePropertyAll(Size(0, 0)),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );

    const inputDecoration = InputDecoration(
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const Text('Username', style: textStyle),
        TextField(
          decoration: inputDecoration,
          controller: model?.usernameTextController,
        ),
        const SizedBox(height: 16),
        const Text('Password', style: textStyle),
        TextField(
          decoration: inputDecoration,
          controller: model?.passwordTextController,
          // obscureText: true,
        ),
        const SizedBox(height: 30),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            _LoginButtonWidget(buttonStyle: buttonStyle),
            TextButton(
              onPressed: null,
              style: buttonStyle,
              child: Text(
                'Reset password',
                style: TextStyle(
                    color: AppColors.lightBlue, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  final ButtonStyle buttonStyle;

  const _LoginButtonWidget({required this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context);

    final onPressed =
        model.canStartAuth == true ? () => model.auth(context) : null;

    final child = model.isAuthProgress == true
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 1.5,
            ))
        : const Text(
            'Login',
            style: TextStyle(
                color: Color(0xFF212529), fontWeight: FontWeight.w400),
          );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle.copyWith(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFFdee2e6)),
      ),
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context).errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
