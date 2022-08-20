import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_card_bloc.dart';
import 'package:collegenius/models/user_model/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSelectManualLoginCard extends ManualLoginCard {
  CourseSelectManualLoginCard({required String systemname})
      : super(systemname: systemname);

  @override
  void login(BuildContext context, User user) {
    context.read<AuthenticationBloc>().add(
          CourseSelectAuthenticateRequest(user: user),
        );
  }
}

class EeclassManualLoginCard extends ManualLoginCard {
  EeclassManualLoginCard({required String systemname})
      : super(systemname: systemname);

  @override
  void login(BuildContext context, User user) {
    context.read<AuthenticationBloc>().add(
          EeclassAuthenticateRequest(user: user),
        );
  }
}

class PortalManualLoginCard extends ManualLoginCard {
  PortalManualLoginCard({required String systemname})
      : super(systemname: systemname);

  @override
  void login(BuildContext context, User user) {
    context.read<AuthenticationBloc>().add(
          PortalAuthenticateRequest(user: user),
        );
  }
}

abstract class ManualLoginCard extends StatelessWidget {
  ManualLoginCard({required this.systemname});
  final String systemname;
  void login(BuildContext context, User user);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = AppLocalizations.of(context)!;
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
                            child: Text("${_locale.manualLogin} ($systemname)",
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
                              labelText: _locale.idTextflieldText,
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.studentId.invalid
                                  ? _locale.idTextErrorText
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
                              labelText: _locale.passwordTextflieldText,
                              labelStyle: _theme.textTheme.bodyMedium,
                              errorText: state.password.invalid
                                  ? _locale.passwordTextErrorText
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
                            _locale.login,
                            style: _theme.textTheme.bodyMedium,
                          ),
                          onPressed: state.status.isValidated
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
    );
  }
}
