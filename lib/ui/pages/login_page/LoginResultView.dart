import 'package:collegenius/logic/bloc/authentication_bloc.dart';
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _authState = context.watch<AuthenticationBloc>().state;
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
                _authState.courseSelectAuthenticated
                    ? Icon(
                        Icons.check_circle,
                        color: Color.fromARGB(255, 113, 225, 116),
                      )
                    : Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text('Course planning',
                      style: _theme.textTheme.headlineSmall),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Row(
              children: [
                _authState.eeclassAuthenticated
                    ? Icon(
                        Icons.check_circle,
                        color: Color.fromARGB(255, 113, 225, 116),
                      )
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
                  style: _theme.textTheme.headlineSmall,
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
  }
}
