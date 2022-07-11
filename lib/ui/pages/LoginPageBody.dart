import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPageBody extends StatelessWidget {
  LoginPageBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _loginPageBloc = context.watch<LoginPageBloc>();
    switch (_loginPageBloc.state.status) {
      case FormzStatus.pure:
        return LoginView();
      case FormzStatus.submissionInProgress:
        return Center(child: Text("Loading"));
      case FormzStatus.submissionSuccess:
        return Center(child: Text("Success"));
      case FormzStatus.submissionFailure:
        return Center(child: Text("Failed"));
    }
    return LoginView();
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constrains) {
      final _vpwidth = constrains.maxWidth;
      // final _vpheight = constrains.maxHeight;
      var _boxWidth;
      if (_vpwidth > 600) {
        _boxWidth = 550;
      } else {
        _boxWidth = _vpwidth * 0.8;
      }
      return Center(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: <Widget>[
              Spacer(),
              Text('COLLEGENIUS', style: _theme.textTheme.headline3),
              Text('The application for college students in NCU',
                  style: _theme.textTheme.caption),
              StudentIdInput(),
              PasswordInput(),
              SizedBox(height: 10),
              LoginButton(),
              Spacer(),
            ])),
      );
    });
  }
}

class InputSection extends StatelessWidget {
  const InputSection({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.secureText,
    required this.onChanged,
  }) : super(key: key);

  final String labelText;
  final IconData icon;
  final bool secureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final _vpwidth = constrains.maxWidth;
      final _theme = Theme.of(context);
      var _boxWidth;
      if (_vpwidth > 600) {
        _boxWidth = 550;
      } else {
        _boxWidth = _vpwidth * 0.8;
      }
      return SizedBox(
          width: _boxWidth,
          child: TextField(
            decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: _theme.textTheme.bodyText1!.color!,
                ),
                labelText: labelText,
                labelStyle: _theme.textTheme.caption,
                focusedBorder: UnderlineInputBorder(
                    borderSide: (BorderSide(
                        color: _theme.textTheme.bodyText1!.color!)))),
            obscureText: secureText,
            onChanged: onChanged,
          ));
    });
  }
}

class StudentIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.studentId != current.studentId,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (id) =>
              context.read<LoginPageBloc>().add(LoginStudentIdChanged(id)),
          decoration: InputDecoration(
            labelText: 'student id or username',
            errorText: state.studentId.invalid ? 'invalid account' : null,
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginPageBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<LoginPageBloc>()
                            .add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
