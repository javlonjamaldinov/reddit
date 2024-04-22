import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/text_field.dart';
import 'package:reddit/page/google_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isLoadingButton = false;
  late bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void signIn() async {
    setState(() {
      isLoadingButton = true;
    });

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (mounted && !_isDisposed) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted && !_isDisposed) {
        Navigator.pop(context);
        displayMessage(e.code);
      }
    } finally {
      if (!_isDisposed) {
        setState(() {
          isLoadingButton = false;
        });
      }
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, top: 20, right: 20),
                  child: Image.asset(
                    'assets/images/reddit.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'L O G I N',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                const GooglePage(),
                const SizedBox(height: 25),
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                isLoadingButton
                    ? const SizedBox.shrink()
                    : MyButtom(
                        onTap: signIn,
                        text: 'Sign In',
                      ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
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
