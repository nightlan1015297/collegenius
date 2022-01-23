import 'package:flutter/material.dart';

class LoginPageBody extends StatelessWidget {
  LoginPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constrains) {
      final _vpwidth = constrains.maxWidth;
      // final _vpheight = constrains.maxHeight;
      var _boxWidth;
      if (_vpwidth > 600) {
        _boxWidth = 550;
      } else {
        _boxWidth = _vpwidth * 0.8;
      }
      return Center(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: <Widget>[
              Spacer(),
              Text('COLLEGENIUS', style: Theme.of(context).textTheme.headline3),
              Text('The application for college students in NCU',
                  style: Theme.of(context).textTheme.caption),
              SizedBox(
                  width: _boxWidth,
                  child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: _theme.textTheme.bodyText1!.color!,
                          ),
                          labelText: 'account',
                          labelStyle: _theme.textTheme.caption,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: (BorderSide(
                                  color:
                                      _theme.textTheme.bodyText1!.color!)))))),
              SizedBox(
                  width: _boxWidth,
                  child: TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'password',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: (BorderSide(
                                color: _theme.textTheme.bodyText1?.color ??
                                    Colors.black)))),
                    obscureText: true,
                  )),
              SizedBox(height: 10),
              SizedBox(
                  height: 50,
                  width: _boxWidth,
                  child: ElevatedButton(
                      child: Text('Login',
                          style: Theme.of(context).textTheme.headline5),
                      style: ButtonStyle(),
                      onPressed: () => {})),
              Spacer(),
            ])),
      );
    });
  }
}
