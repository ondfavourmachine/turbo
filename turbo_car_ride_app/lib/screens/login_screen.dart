import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  // final password = TextEditingController();
  String emailText = '';
  String passwordText = '';
  bool obscureText = true;
  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 35,
            ),
            Center(
              child: Image(
                image: AssetImage('turbo_images/images/logo.png'),
                width: 390,
                height: 250,
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
              height: 25,
            ),
            TextFormField(
              controller: emailController,
              onChanged: (value) => setState(() => emailText = value),
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
                          onPressed: () => emailController.clear(),
                        ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  labelText: 'Email',
                  hintText: 'johndoe@gmail.com',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              // controller: password,
              onChanged: (value) => setState(() => passwordText = value),
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
            )
          ],
        ),
      ),
    );
  }
}
