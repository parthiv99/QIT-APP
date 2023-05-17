import '/Screens/login_screen.dart';
import '/Screens/registration_screen.dart';
import '/Widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5C3E96), Color(0xFF312861)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: _controller.value * 2 * math.pi,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/qitLogo.png',
                        width: 450,
                        height: 250,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Welcome to Qit',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    RoundedButton(
                      btnText: 'Sign In',
                      onBtnPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundedButton(
                      btnText: 'Create Account',
                      onBtnPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
