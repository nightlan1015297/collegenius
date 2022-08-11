import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:collegenius/ui/common_widgets/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [
                    state.courseSelectAuthenticated.isAuthed
                        ? Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 113, 225, 116),
                          )
                        : state.courseSelectAuthenticated.isLoading
                            ? Loading(size: 20)
                            : Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text('Course planning',
                          style: _theme.textTheme.headline6),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [
                    state.eeclassAuthenticated.isAuthed
                        ? Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 113, 225, 116),
                          )
                        : state.eeclassAuthenticated.isLoading
                            ? Loading(size: 20)
                            : Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      'EEclass',
                      style: _theme.textTheme.headline6,
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
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
