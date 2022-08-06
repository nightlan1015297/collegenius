import 'package:collegenius/logic/bloc/login_page_bloc.dart';
import 'package:collegenius/ui/pages/login_page/LoginInprogressView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'LoginResultView.dart';
import 'LoginView.dart';

class LoginPageView extends StatelessWidget {
  LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _loginPageBloc = context.watch<LoginPageBloc>();
    switch (_loginPageBloc.state.status) {
      case FormzStatus.pure:
        return LoginView();
      case FormzStatus.submissionInProgress:
        return LoginInprogressView();
      case FormzStatus.submissionSuccess:
        return LoginResultView();
      case FormzStatus.submissionFailure:
        return Center(child: Text("Failed"));
    }
    return LoginView();
  }
}
