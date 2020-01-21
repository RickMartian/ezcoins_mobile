import 'package:ezcoins_mobile/ui/components/header.title.dart';
import 'package:ezcoins_mobile/ui/tab.routes.dart';
import 'package:flutter/material.dart';

class LoginBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = Color.fromRGBO(113, 121, 177, 0.59);
    paint.style = PaintingStyle.fill;
    int bgTotalHeight = 795;
    int bgTotalWidth = 380;

    // path.moveTo(0, size.height * 120 / 795);
    // path.quadraticBezierTo(
    //     size.width * 27 / bgTotalWidth,
    //     size.height * 112 / bgTotalHeight,
    //     size.width * 47 / bgTotalWidth,
    //     size.height * 114 / bgTotalHeight);
    // path.quadraticBezierTo(
    //     size.width * 69 / bgTotalWidth,
    //     size.height * 114 / bgTotalHeight,
    //     size.width * 95 / bgTotalWidth,
    //     size.height * 97 / bgTotalHeight);
    // path.quadraticBezierTo(
    //     size.width * 107 / bgTotalWidth,
    //     size.height * 65 / bgTotalHeight,
    //     size.width * 127 / bgTotalWidth,
    //     size.height * 57 / bgTotalHeight);
    // path.lineTo(size.width, 0);
    // path.lineTo(0, 0);

    // path.close();

    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _emailValidator(value) {
    print(value);
    if (value.isEmpty) {
      return 'Preencha com algum email :)';
    }
    return null;
  }

  void _validateLogin() {
    if (_formKey.currentState.validate()) {
      print('Logando...');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TabRoutes(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: LoginBackgroundPainter(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: headerTitle("Bem vindo ao", "ez.coins"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.05),
                      child: TextFormField(
                        validator: _emailValidator,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: deviceHeight * 0.05),
                child: Column(
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: deviceWidth * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 4,
                                // spreadRadius: 2,
                                offset: Offset(0, 4),
                                color: Color.fromRGBO(0, 0, 0, 0.25))
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: FlatButton(
                          child: Text(
                            "ENTRAR",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          color: Color(0xFF454C7D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          onPressed: _validateLogin,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.05),
                      child: InkWell(
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
