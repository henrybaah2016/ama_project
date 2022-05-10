
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bilbo/home/home.dart';
import 'package:bilbo/login/login.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);


  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;
  bool _showPassword = false;


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xffff4A4A);
      }
      return Color(0xffff4A4A);
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: <Widget>[
              Center(
                  child: Container(
                margin: const EdgeInsets.only(top: 80, left: 5, bottom: 5),
                height: 70,
                width: 70,
                child: Image.asset('assets/images/amalog.png'),
              )),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 5, bottom: 40),

                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text(
                    'Accra Metropolitan Assembly',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff056839),
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB3B3B3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB3B3B3)),
                        ),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB3B3B3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB3B3B3)),
                        ),
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB3B3B3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB3B3B3)),
                        ),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB3B3B3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff000000)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB3B3B3)),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._showPassword
                              ? Color(0xffff4A4A)
                              : Color(0xffC6C6C6),
                          size: 20.0,
                        ),
                        onPressed: () {
                          setState(
                              () => this._showPassword = !this._showPassword);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Checkbox(
                        activeColor: Color(0xff056839),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      new Text(
                        "I have read the user",
                        style: new TextStyle(
                            color: Color(0xffB3B3B3),
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                      new Text(
                        " agreement ",
                        style: new TextStyle(
                            color: Color(0xff056839),
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                      new Text(
                        "and i accept it",
                        style: new TextStyle(
                            color: Color(0xffB3B3B3),
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 5, right: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff056839),
                    minimumSize: Size(double.infinity, 52),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      side: BorderSide(color: Color(0xff056839)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Sign up',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account, ",
                      style: TextStyle(
                          color: Color(0xffB3B3B3),
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          " Log in",
                          style: TextStyle(
                              color: Color(0xff056839),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
