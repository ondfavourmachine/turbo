import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:turbo_car_ride_app/constants/routes.dart';
import 'package:turbo_car_ride_app/main.dart';
import 'package:turbo_car_ride_app/reusables/toaster.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String passwordText = '';
  bool obscureText = true;
  bool showPassword = false;

  final emailController = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

// get reference to global firebase auth instance
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fireBaseAuth.initi
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    phone.dispose();
    name.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
                    'Signup as a rider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: Container(
                        width: double.infinity,
                        // decoration: BoxDecoration(color: Colors.red),
                        child: Wrap(
                          // spacing: 10,
                          runSpacing: 10,
                          children: [
                            TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'This field is required';
                                  return null;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                    // errorText: validateAField(password),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    labelText: 'Name',
                                    prefixIcon: Icon(Icons.people))),
                            TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {},
                                obscureText: false,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'This field is required';
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    labelText: 'Phone',
                                    prefixIcon: Icon(Icons.phone))),
                            TextFormField(
                              controller: emailController,
                              // onChanged: (value) =>
                              //     setState(() => emailText = value),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(fontSize: 14),
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'This field is required';
                                if (!value.contains('@'))
                                  return 'This is not valid email';
                                return null;
                              },
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
                              // onChanged: (value) =>
                              //     setState(() => passwordText = value),
                              obscureText: obscureText,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'This field is required';
                                if (value.length < 6)
                                  return 'This field is required';
                                return null;
                              },
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
                                  createUserUsingFireBase(context);
                                },
                                color: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Center(
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                  onPressed: () {
                                    // Navigator.of(context).pushNamedAndRemoveUntil(
                                    //     RoutesConstants.loginScreen,
                                    //     (route) => false);
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesConstants.loginScreen,
                                        (route) => false);
                                  },
                                  child: Text('Have an Account?. Login here')),
                            )
                          ],
                        ),
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

  createUserUsingFireBase(BuildContext context) {
    // Scaffold.of(context).showSnackBar(SnackBar( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), content: Text('Please fill in all required fields')))
    if (_formKey.currentState.validate()) {
      print(emailController.text);
      print(phone.text);
      print(passwordText);
      submitUserToFirebase(context);
    } else {
      print('form not valid !');

      ToasterMessages.show(context, 'Please fill in all required fields');
    }
  }

  submitUserToFirebase(BuildContext context) async {
    UserCredential firebaseUser = await _fireBaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: password.text)
        .catchError(
            (err) => {print('${err}'), ToasterMessages.show(context, '$err')});
    if (firebaseUser != null) {
      Map user = {
        'name': name.text.trim(),
        'email': emailController.text.trim(),
        'phone': phone.text.trim()
      };
      // firebaseUser.user.uid;
      userRef.child(firebaseUser.user.uid).set(user);
      ToasterMessages.show(context, 'Account Created Successfully');
      Navigator.of(context).pushNamedAndRemoveUntil(
          RoutesConstants.loginScreen, (route) => false);
    } else {
      ToasterMessages.show(context, 'An error occured!');
    }
  }

  validateAField(TextEditingController value) {
    print('${value.text}');
    if (value.text.length < 2) return 'This field is required';
    return null;
  }
}
