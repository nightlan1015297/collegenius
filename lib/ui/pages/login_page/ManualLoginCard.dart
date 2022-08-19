import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_card_bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSelectManualLoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCardBloc(),
      child: BlocBuilder<LoginCardBloc, LoginCardState>(
        builder: (context, state) {
          return Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("手動登入 (選課系統)",
                                style: _theme.textTheme.titleLarge,
                                textAlign: TextAlign.start),
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          child: IconButton(
                            icon: Icon(Icons.close, size: 30),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            key: const Key('loginForm_usernameInput_textField'),
                            onChanged: (id) => context
                                .read<LoginCardBloc>()
                                .add(LoginStudentIdChanged(id)),
                            decoration: InputDecoration(
                              labelText: 'Student id or username',
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.studentId.invalid
                                  ? 'Student id or username can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            key: const Key('loginForm_passwordInput_textField'),
                            onChanged: (password) => context
                                .read<LoginCardBloc>()
                                .add(LoginPasswordChanged(password)),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.password.invalid
                                  ? 'Password can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: state.status.isValidated
                                ? MaterialStateProperty.all(Colors.blue)
                                : MaterialStateProperty.all(
                                    _theme.primaryColor),
                          ),
                          key: const Key('loginForm_continue_raisedButton'),
                          child: Text(
                            'Login',
                            style: _theme.textTheme.bodyMedium,
                          ),
                          onPressed: state.status.isValidated
                              ? () {
                                  context.read<AuthenticationBloc>().add(
                                        CourseSelectAuthenticateRequest(
                                            user: User(
                                                id: state.studentId.value,
                                                password:
                                                    state.password.value)),
                                      );
                                  Navigator.of(context).pop();
                                }
                              : null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EeclassManualLoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCardBloc(),
      child: BlocBuilder<LoginCardBloc, LoginCardState>(
        builder: (context, state) {
          return Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("手動登入 (Eeclass)",
                                style: _theme.textTheme.titleLarge,
                                textAlign: TextAlign.start),
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          child: IconButton(
                            icon: Icon(Icons.close, size: 30),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            key: const Key('loginForm_usernameInput_textField'),
                            onChanged: (id) => context
                                .read<LoginCardBloc>()
                                .add(LoginStudentIdChanged(id)),
                            decoration: InputDecoration(
                              labelText: 'Student id or username',
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.studentId.invalid
                                  ? 'Student id or username can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            key: const Key('loginForm_passwordInput_textField'),
                            onChanged: (password) => context
                                .read<LoginCardBloc>()
                                .add(LoginPasswordChanged(password)),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.password.invalid
                                  ? 'Password can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: state.status.isValidated
                                ? MaterialStateProperty.all(Colors.blue)
                                : MaterialStateProperty.all(
                                    _theme.primaryColor),
                          ),
                          key: const Key('loginForm_continue_raisedButton'),
                          child: Text(
                            'Login',
                            style: _theme.textTheme.bodyMedium,
                          ),
                          onPressed: state.status.isValidated
                              ? () {
                                  context.read<AuthenticationBloc>().add(
                                        EeclassAuthenticateRequest(
                                            user: User(
                                                id: state.studentId.value,
                                                password:
                                                    state.password.value)),
                                      );
                                  Navigator.of(context).pop();
                                }
                              : null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PortalManualLoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCardBloc(),
      child: BlocBuilder<LoginCardBloc, LoginCardState>(
        builder: (context, state) {
          return Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("手動登入 (Portal)",
                                style: _theme.textTheme.titleLarge,
                                textAlign: TextAlign.start),
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          child: IconButton(
                            icon: Icon(Icons.close, size: 30),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            key: const Key('loginForm_usernameInput_textField'),
                            onChanged: (id) => context
                                .read<LoginCardBloc>()
                                .add(LoginStudentIdChanged(id)),
                            decoration: InputDecoration(
                              labelText: 'Student id or username',
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.studentId.invalid
                                  ? 'Student id or username can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            key: const Key('loginForm_passwordInput_textField'),
                            onChanged: (password) => context
                                .read<LoginCardBloc>()
                                .add(LoginPasswordChanged(password)),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.password.invalid
                                  ? 'Password can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: state.status.isValidated
                                ? MaterialStateProperty.all(Colors.blue)
                                : MaterialStateProperty.all(
                                    _theme.primaryColor),
                          ),
                          key: const Key('loginForm_continue_raisedButton'),
                          child: Text(
                            'Login',
                            style: _theme.textTheme.bodyMedium,
                          ),
                          onPressed: state.status.isValidated
                              ? () {
                                  context.read<AuthenticationBloc>().add(
                                        PortalAuthenticateRequest(
                                            user: User(
                                                id: state.studentId.value,
                                                password:
                                                    state.password.value)),
                                      );
                                  Navigator.of(context).pop();
                                }
                              : null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
