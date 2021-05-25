import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turbo_car_ride_app/constants/routes.dart';
import 'package:turbo_car_ride_app/main.dart';
import 'package:turbo_car_ride_app/reusables/dialog_spinner.dart';
import 'package:turbo_car_ride_app/reusables/toaster.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreen = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password = TextEditingController();
  String emailText = '';
  String passwordText = '';
  bool obscureText = true;
  bool showPassword = false;

  //  get reference to global firebase auth instance
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.removeListener(() => setState(() {}));
    emailController.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: _screenSize.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image(
                      image: AssetImage('turbo_images/images/logo.png'),
                      width: 300,
                      height: _screenSize.height * 0.3,
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    'Login as a rider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      // decoration: BoxDecoration(color: Colors.red),
                      child: Wrap(
                        // spacing: 10,
                        runSpacing: 10,
                        children: [
                          TextFormField(
                            controller: emailController,
                            onChanged: (value) =>
                                setState(() => emailText = value),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                prefixIcon: Icon(Icons.email),
                                suffixIcon: emailController.text.isEmpty
                                    ? Container(
                                        width: 0,
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () =>
                                            emailController.clear(),
                                      ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                labelText: 'Email',
                                hintText: 'johndoe@gmail.com',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          TextFormField(
                            controller: password,
                            onChanged: (value) =>
                                setState(() => passwordText = value),
                            obscureText: obscureText,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                    icon: showPassword
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () => setState(() {
                                          obscureText = !obscureText;
                                          showPassword = !showPassword;
                                        })),
                                prefixIcon: Icon(Icons.lock_rounded)),
                          ),
                          RaisedButton(
                              onPressed: () {
                                submitLoginDetailsToFirebase(context);
                              },
                              color: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      RoutesConstants.registrationScreen,
                                      (route) => false);
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context,
                                  //     RoutesConstants.registrationScreen,
                                  //     (route) => false);
                                },
                                child: Text(
                                    'Don\'t have an account. Register here')),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitLoginDetailsToFirebase(BuildContext context) async {
    if (emailController.text.trim().isEmpty)
      return ToasterMessages.show(context, 'Please enter an email');
    if (password.text.isEmpty)
      return ToasterMessages.show(context, 'Please enter a password!');
    print('${emailController.text.trim()}, ${password.text}');

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return CustomSpinner(msg: 'Please wait...').build(context);
        });

    try {
      UserCredential firebaseLoggedInUser =
          await _fireBaseAuth.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: password.text.trim());
      print('${firebaseLoggedInUser.user.uid}');

      if (firebaseLoggedInUser != null) {
        print('${firebaseLoggedInUser.user}');
        Navigator.of(context).pop();
        userRef
            .child(firebaseLoggedInUser.user.uid)
            .once()
            .onError((error, stackTrace) {
          print('''  
               ${error}
               ${stackTrace}
              ''');
        }).then((DataSnapshot snapshot) {
          print('''${snapshot}
                  ''');
          if (snapshot.value != null) {
            _fireBaseAuth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesConstants.mainScreen, (route) => false);
          } else {
            print('${snapshot.toString()}');
            ToasterMessages.show(context, 'Wrong email or password!');
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        ToasterMessages.show(context,
            'The email you entered doesn\'t exist or is mispelled. Please try again with a valid email.');
        Navigator.of(context).pop();
      } else if (e.code == 'user-not-found') {
        print('${e.code}');
        ToasterMessages.show(context, 'No user was found with this email.');
        Navigator.of(context).pop();
      } else if (e.code == 'wrong-password') {
        print('${e.code}');
        ToasterMessages.show(context,
            'Wrong password. Please enter the correct password for this email');
        Navigator.of(context).pop();
      }
    }
  }
}
