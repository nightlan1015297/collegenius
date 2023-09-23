import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_card_bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSelectManualLoginCard extends ManualLoginCard {
  @override
  void login(BuildContext context, User user) {
    context.read<AuthenticationBloc>().add(
          CourseSelectAuthenticateRequest(user: user),
        );
  }
}

class EeclassManualLoginCard extends ManualLoginCard {
  @override
  void login(BuildContext context, User user) {
    context.read<AuthenticationBloc>().add(
          EeclassAuthenticateRequest(user: user),
        );
  }
}

class PortalManualLoginCard extends ManualLoginCard {
  @override
  void login(BuildContext context, User user) {
    context.read<AuthenticationBloc>().add(
          PortalAuthenticateRequest(user: user),
        );
  }
}

abstract class ManualLoginCard extends StatelessWidget {
  void login(BuildContext context, User user);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
    return Center(
      child: BlocProvider(
        create: (context) => LoginCardBloc(),
        child: BlocBuilder<LoginCardBloc, LoginCardState>(
          builder: (context, state) {
            return Card(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 450, maxHeight: 300),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Stack(
                        children: [
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${_locale.manualLogin}",
                                  style: _theme.textTheme.titleLarge,
                                  overflow: TextOverflow.ellipsis,
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
                              key: const Key(
                                  'loginForm_usernameInput_textField'),
                              onChanged: (id) => context
                                  .read<LoginCardBloc>()
                                  .add(LoginStudentIdChanged(id)),
                              decoration: InputDecoration(
                                labelText: _locale.idTextflieldText,
                                labelStyle: _theme.textTheme.bodyMedium,
                                errorText: _locale.idTextErrorText
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              key: const Key(
                                  'loginForm_passwordInput_textField'),
                              onChanged: (password) => context
                                  .read<LoginCardBloc>()
                                  .add(LoginPasswordChanged(password)),
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: _locale.passwordTextflieldText,
                                labelStyle: _theme.textTheme.bodyMedium,
                                errorText: _locale.passwordTextErrorText
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: state.status.isValid
                                  ? MaterialStateProperty.all(Colors.blue)
                                  : MaterialStateProperty.all(
                                      _theme.primaryColor),
                            ),
                            key: const Key('loginForm_continue_raisedButton'),
                            child: Text(
                              _locale.login,
                              style: _theme.textTheme.bodyMedium,
                            ),
                            onPressed: state.status.isValid
                                ? () {
                                    login(
                                      context,
                                      User(
                                          id: state.studentId.value,
                                          password: state.password.value),
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
      ),
    );
  }
}
