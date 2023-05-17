import '/Services/auth_service.dart';
import '/Widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email;
  late String _password;
  late String _name;
  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  FocusNode _focusNode3 = new FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required FocusNode focusNode,
    required String labelText,
    required Function(String) onChanged,
    required VoidCallback onTap,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.white : Colors.grey,
          fontSize: 16,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.3),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1.1),
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      obscureText: obscureText,
      textAlign: TextAlign.start,
      onTap: onTap,
      onChanged: onChanged,
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!value.endsWith('.edu')) {
      return 'Please enter a valid .edu email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 53, 29, 94),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/qitLogo.png',
                          width: 300,
                          height: 200,
                        ),
                        Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildTextField(
                          focusNode: _focusNode3,
                          labelText: 'Enter your name',
                          onChanged: (value) {
                            _name = value;
                          },
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(_focusNode3);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildTextField(
                          focusNode: _focusNode,
                          labelText: 'Enter your e-mail',
                          onChanged: (value) {
                            _email = value;
                          },
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(_focusNode);
                            });
                          },
                          validator: _validateEmail,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildTextField(
                          focusNode: _focusNode2,
                          labelText: 'Enter your password',
                          onChanged: (value) {
                            _password = value;
                          },
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(_focusNode2);
                            });
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          btnText: 'Create Account',
                          onBtnPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool isValid = await AuthService.signUp(
                                  _name, _email, _password);
                              if (isValid) {
                                Navigator.pop(context);
                              } else {
                                print('algo deu errado');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
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

  void _requestFocus3() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode3);
    });
  }
}
