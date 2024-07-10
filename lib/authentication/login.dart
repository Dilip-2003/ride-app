import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/authentication/singup.dart';
import 'package:ride_app/global/global_variables.dart';
import 'package:ride_app/methods/common_methods.dart';
import 'package:ride_app/pages/home_page.dart';
import 'package:ride_app/widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  late CommonMethods cmethods;
  @override
  void initState() {
    super.initState();
    cmethods = CommonMethods(); // Initialize in initState
    cmethods.checkConnectivity(context);
  }

  signInFormValidation() {
    if (!userEmailController.text.contains('@')) {
      cmethods.displaySnackbar(context, 'please enter a valid email');
    }
    if (userPasswordController.text.trim().length < 6) {
      cmethods.displaySnackbar(
          context, 'password length should be at least 6 words');
    } else {
      loginUser();
    }
  }

  loginUser() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      // ignore: non_constant_identifier_names
      builder: (BuildContextcontext) =>
          const LoadingDialog(messageText: 'Login to your account.....'),
    );

    final User? userFirebase = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
      email: userEmailController.text.trim(),
      password: userPasswordController.text.trim(),
    )
            .catchError((errormsg) {
      Navigator.pop(context);
      cmethods.displaySnackbar(context, errormsg.toString());
    }))
        .user;
    if (!context.mounted) return;
    Navigator.pop(context);

    if (userFirebase != null) {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userFirebase!.uid);
      userRef.once().then((snap) {
        if (snap.snapshot.value != null) {
          if ((snap.snapshot.value as Map)['blockStatus'] == 'no') {
            userName = (snap.snapshot.value as Map)['name'];
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          } else {
            cmethods.displaySnackbar(
                context, 'you are blocked. please contact to the Admin....');
            FirebaseAuth.instance.signOut();
          }
        } else {
          FirebaseAuth.instance.signOut();
          cmethods.displaySnackbar(
              context, 'your record not match as user.....');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              const Text(
                " Login to your account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: userEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: 'user email'),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      controller: userPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: 'user password'),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 75,
                                vertical: 15,
                              ),
                            ),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.purple)),
                        onPressed: () {
                          loginUser();
                          print('signIn button');
                        },
                        child: const Text('Login')),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                },
                child: const Text("Don't Have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
