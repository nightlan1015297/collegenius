import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:collegenius/constants/Constants.dart';

import 'package:collegenius/models/error_model/ErrorModel.dart';
import 'package:collegenius/routes/route_arguments.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PortalLoginWebView.dart';

class LoginResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('COLLEGENIUS', style: _theme.textTheme.displaySmall),
              Text(
                'The application for students in NCU',
                style: _theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Builder(
                      builder: (context) {
                        if (state.courseSelectAuthStatus.isAuthed) {
                          return Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 113, 225, 116),
                          );
                        } else if (state.courseSelectAuthStatus.isLoading) {
                          return Loading(size: 20);
                        } else {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/login/manual/courseSelect');
                                },
                                child: Icon(
                                  Icons.manage_accounts,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/login/failedMessage/courseSelect',
                                      arguments: LoginFailedArguments(
                                          err: state.courseSelectError!));
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 200,
                      child: Text('Course planning',
                          style: _theme.textTheme.headline6)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Builder(
                      builder: (context) {
                        if (state.eeclassAuthStatus.isAuthed) {
                          return Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 113, 225, 116),
                          );
                        } else if (state.eeclassAuthStatus.isLoading) {
                          return Loading(size: 20);
                        } else {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/login/manual/eeclass');
                                },
                                child: Icon(
                                  Icons.manage_accounts,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/login/failedMessage/eeclass',
                                      arguments: LoginFailedArguments(
                                          err: state.courseSelectError!));
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'EEclass',
                      style: _theme.textTheme.headline6,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Builder(
                      builder: (context) {
                        if (state.portalAuthStatus.isAuthed) {
                          return Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 113, 225, 116),
                          );
                        } else if (state.portalAuthStatus.isLoading) {
                          return Loading(size: 20);
                        } else if (state.portalAuthStatus.isNeedCaptcha) {
                          return Row(
                            children: [
                              PortalLoginWebView(),
                              Icon(
                                Icons.warning,
                                color: Colors.orange,
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/login/manual/portal');
                                },
                                child: Icon(
                                  Icons.manage_accounts,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/login/failedMessage/portal',
                                      arguments: LoginFailedArguments(
                                          err: state.courseSelectError!));
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Portal',
                      style: _theme.textTheme.headline6,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequest());
                    context.read<LoginPageBloc>().add(LogoutRequst());
                  },
                  child: Text("Log out"))
            ],
          ),
        );
      },
    );
  }
}

class CourseSchedualLoginFailedMessage extends LoginFailedMessage {
  CourseSchedualLoginFailedMessage({required ErrorModel err}) : super(err: err);
  @override
  void retry(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class EeclassLoginFailedMessage extends LoginFailedMessage {
  EeclassLoginFailedMessage({required ErrorModel err}) : super(err: err);
  @override
  void retry(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class PortalLoginFailedMessage extends LoginFailedMessage {
  PortalLoginFailedMessage({required ErrorModel err}) : super(err: err);
  @override
  void retry(BuildContext context) {
    Navigator.of(context).pop();
  }
}

abstract class LoginFailedMessage extends StatelessWidget {
  final ErrorModel err;
  const LoginFailedMessage({
    Key? key,
    required this.err,
  }) : super(key: key);

  void retry(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500),
          child: Card(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '登入發生錯誤',
                      style: _theme.textTheme.headline6,
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: '例外描述 :',
                            information: err.exception,
                            labelTexttheme: _theme.textTheme.headline6,
                            informationTextOverFlow: TextOverflow.visible,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextInformationProvider(
                            label: '錯誤堆疊追蹤 :',
                            information: err.stackTrace,
                            informationTextOverFlow: TextOverflow.visible,
                            labelTexttheme: _theme.textTheme.headline6,
                            informationTexttheme: _theme.textTheme.bodyLarge,
                            informationPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    retry(context);
                  },
                  child: Text('關閉'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
