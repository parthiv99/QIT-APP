import '/Constants/constants.dart';
import '/Screens/feed_screen.dart';
import '/Services/auth_service.dart';
import '/Widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late String _email;
  late String _password;
  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode2 = FocusNode();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTextField(
      {required String labelText,
      required FocusNode focusNode,
      required Function onTap,
      required Function onChanged,
      bool obscureText = false}) {
    return TextFormField(
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: focusNode.hasFocus ? Color(0xff00acee) : Colors.grey,
            fontSize: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff00acee), width: 1.3),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.1),
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      textAlign: TextAlign.start,
      onTap: () => onTap(),
      onChanged: (value) => onChanged(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 53, 29, 94),
        body: FadeTransition(
          opacity: _animation,
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/qitLogo.png',
                    width: 350,
                    height: 350,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTextField(
                    labelText: "Enter your e-mail",
                    focusNode: _focusNode,
                    onTap: _requestFocus,
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTextField(
                    labelText: "Enter your password",
                    focusNode: _focusNode2,
                    onTap: _requestFocus2,
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    btnText: 'Login',
                    onBtnPressed: () async {
                      bool isValid = await AuthService.login(_email, _password);
                      if (isValid) {
                        Navigator.pop(context);
                        //    Navigator.of(context).push(MaterialPageRoute(
                        //                    builder: (context) => FeedScreen()));
                      } else {
                        print('Wrong Credentials');
                      }
                    },
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void _requestFocus2() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode2);
    });
  }
}
