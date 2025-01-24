import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_button_styles.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_text_styles.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text('Login to your account'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
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
    return Column(
      spacing: 16,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.auth,
            children: [
              TextSpan(
                text:
                    'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
              ),
              TextSpan(
                text: 'Click here ',
                style: AppTextStyles.authlink,
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
            style: AppTextStyles.auth,
            children: [
              TextSpan(
                  text:
                      'If you signed up but didn\'t get your verification email, '),
              TextSpan(
                text: 'click here ',
                style: AppTextStyles.authlink,
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
    final model = context.read<AuthModel>();

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
        const Text('Username', style: AppTextStyles.auth),
        TextField(
          decoration: inputDecoration,
          controller: model.usernameTextController,
        ),
        const SizedBox(height: 16),
        const Text('Password', style: AppTextStyles.auth),
        TextField(
          decoration: inputDecoration,
          controller: model.passwordTextController,
          // obscureText: true,
        ),
        const SizedBox(height: 30),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            _LoginButtonWidget(),
            _ResetButtonWidget(),
          ],
        )
      ],
    );
  }
}

class _ResetButtonWidget extends StatelessWidget {
  const _ResetButtonWidget();

  @override
  Widget build(BuildContext context) {
    return const TextButton(
      onPressed: null,
      style: AppButtonStyles.auth,
      child: Text(
        'Reset password',
        style: AppTextStyles.reset,
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();

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
            style: AppTextStyles.login,
          );

    return ElevatedButton(
      onPressed: onPressed,
      style: AppButtonStyles.auth.copyWith(
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
    final errorMessage = context.select((AuthModel m) => m.errorMessage);
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        errorMessage,
        style: AppTextStyles.error,
      ),
    );
  }
}
