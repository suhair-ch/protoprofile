import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protoprofile/controlloer/logincontroller.dart';
import 'package:protoprofile/controlloer/otp.dart';
import 'package:protoprofile/view/profilepage.dart';
import 'package:protoprofile/view/signuppage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthProvider _authProvider = AuthProvider();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoggingIn = false;

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoggingIn = true;
    });

    await _authProvider.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    if (_authProvider.currentUser != null) {
      // Navigate to home page.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ));
    } else {
      // Handle error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("please fill it ")));
    }

    setState(() {
      _isLoggingIn = false;
    });
  }

  Future<void> _signUpWithEmailAndPassword() async {
    setState(() {
      _isLoggingIn = true;
    });

    await _authProvider.signUpWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    if (_authProvider.currentUser != null) {
      
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ));
    } else {
      // Handle error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("please fill it ")));
    }

    setState(() {
      _isLoggingIn = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoggingIn = true;
    });

    await _authProvider.signInWithGoogle();

    if (_authProvider.currentUser != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("please fill it ")));
    }

    setState(() {
      _isLoggingIn = false;
    });
  }

  Future<void> _signInWithOtp() async {
    // TODO: Implement OTP sign-in.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark)),
        body: Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  Align(
                    alignment: const AlignmentDirectional(3, -0.3),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -0.3),
                    child: Container(
                      height: 500,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 8, 113, 211)),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 400,
                      width: 600,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("WELCOME",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 30)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("BACK",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30))
                          ],
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                ),
                              ),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _signInWithEmailAndPassword,
                                child: Text('SIGN-IN',
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)),
                              ),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 90,
                                        child: ElevatedButton(
                                          onPressed: _signInWithGoogle,
                                          style: ButtonStyle(),
                                          child: Image.asset(
                                            'assets/google.png',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                LoginWithPhonrNumberPage(),
                                          ));
                                        },
                                        child: Icon(Icons.mobile_friendly,
                                            size: 35),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Dont Have An Account?',
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15)),
                                  ]),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => SignUpPage(),
                                        ));
                                      },
                                      child: Text('sign up',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20))),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(height: 20),
                        )
                      ])
                ]))));
  }
}
