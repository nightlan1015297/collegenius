import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Text('COLLEGENIUS',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 40,
                        letterSpacing: .5,
                        color: _theme.textTheme.bodyText1?.color),
                  )),
              Text('The best application for college students in NCU',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: .5,
                        color: _theme.textTheme.bodyText1?.color),
                  )),
              SizedBox(
                  width: _boxWidth,
                  child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'account',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: (BorderSide(
                                  color: _theme.textTheme.bodyText1?.color ??
                                      Colors.black)))))),
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
                          style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 25, letterSpacing: .5),
                          )),
                      style: ButtonStyle(),
                      onPressed: () => {})),
              Spacer(),
            ])),
      );
    });
  }
}
