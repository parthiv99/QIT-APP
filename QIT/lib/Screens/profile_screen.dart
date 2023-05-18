import 'package:testing/Constants/constants.dart';
import 'package:testing/Models/user_model.dart';
import 'package:testing/Screens/welcome_screen.dart';
import 'package:testing/Services/auth_service.dart';
import '/Services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfileScreen({
    Key? key,
    required this.currentUserId,
    required this.visitedUserId,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int _profileSegmentValue = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: usersRef.doc(widget.visitedUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xff00acee)),
              ),
            );
          }
          UserModel userModel = UserModel.fromDoc(snapshot.data);
          return FadeTransition(
            opacity: _animation,
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                        padding: EdgeInsets.only(top: 50),
                        height: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox.shrink(),
                            widget.currentUserId == widget.visitedUserId
                                ? PopupMenuButton(
                                    elevation: 3.2,

                                    // padding: EdgeInsets.symmetric(vertical: 20),
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Color.fromARGB(255, 17, 196, 220),
                                      size: 30,
                                    ),
                                    itemBuilder: (_) {
                                      return <PopupMenuItem<String>>[
                                        new PopupMenuItem(
                                          child: Text('Logout'),
                                          value: 'logout',
                                        ),
                                      ];
                                    },
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -82.0, 0.0),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              userModel.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
