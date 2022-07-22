import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPageView extends StatelessWidget {
  LoginPageView({Key? key}) : super(key: key);
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
    return Center(
      child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Text('COLLEGENIUS', style: _theme.textTheme.displaySmall),
                  Text(
                    'The application for college students in NCU',
                    style: _theme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            StudentIdInput(),
            PasswordInput(),
            SizedBox(height: 10),
            LoginButton(),
          ])),
    );
  }
}

class StudentIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.studentId != current.studentId,
      builder: (context, state) {
        final _theme = Theme.of(context);
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (id) =>
              context.read<LoginPageBloc>().add(LoginStudentIdChanged(id)),
          decoration: InputDecoration(
            labelText: 'Student id or username',
            labelStyle: _theme.textTheme.bodyMedium,
            errorText: state.studentId.invalid
                ? 'Student id or username can not be empty'
                : null,
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
        final _theme = Theme.of(context);
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginPageBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: _theme.textTheme.bodyMedium,
            errorText:
                state.password.invalid ? 'Password can not be empty' : null,
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
        final _theme = Theme.of(context);
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: state.status.isValidated
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(_theme.primaryColor),
                ),
                key: const Key('loginForm_continue_raisedButton'),
                child: Text(
                  'Login',
                  style: _theme.textTheme.bodyMedium,
                ),
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
