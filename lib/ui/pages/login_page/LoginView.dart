import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
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
                    _locale.appDescription,
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
    final _locale = AppLocalizations.of(context)!;
    final _theme = Theme.of(context);
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.studentId != current.studentId,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (id) =>
                context.read<LoginPageBloc>().add(LoginStudentIdChanged(id)),
            decoration: InputDecoration(
              labelText: _locale.idTextflieldText,
              labelStyle: _theme.textTheme.bodyMedium,
              errorText:
                  state.studentId.invalid ? _locale.idTextErrorText : null,
            ),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;
    final _theme = Theme.of(context);
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) => context
                .read<LoginPageBloc>()
                .add(LoginPasswordChanged(password)),
            obscureText: true,
            decoration: InputDecoration(
              labelText: _locale.passwordTextflieldText,
              labelStyle: _theme.textTheme.bodyMedium,
              errorText:
                  state.password.invalid ? _locale.passwordTextErrorText : null,
            ),
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _locale = AppLocalizations.of(context)!;
    final _theme = Theme.of(context);
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
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
                  _locale.login,
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
