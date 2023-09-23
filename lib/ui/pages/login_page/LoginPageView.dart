import 'package:collegenius/constants/Constants.dart';
import 'package:collegenius/logic/bloc/login_page_bloc.dart';
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
    switch (_loginPageBloc.state.progress) {
      case SubmissionProgress.initial:
        return LoginView();
      case SubmissionProgress.success:
        return LoginResultView();
      case SubmissionProgress.failed:
        return Center(child: Text("Failed"));
    }
  }
}
