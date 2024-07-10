import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/authentication/login.dart';
import 'package:ride_app/methods/common_methods.dart';
import 'package:ride_app/pages/home_page.dart';
import 'package:ride_app/widgets/loading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  late CommonMethods cmethods;

  @override
  void initState() {
    super.initState();
    cmethods = CommonMethods(); // Initialize in initState
    cmethods.checkConnectivity(context);
  }

  // checkInternetAvailability() {
  //   cmethods.checkConnectivity(context); // Ensure context is valid when calling
  // }

  signupFormValidation() {
    if (userNameController.text.trim().length < 3 ||
        userNameController.text.trim().isEmpty) {
      cmethods.displaySnackbar(
          context, 'your name must be of more than 4 characters');
    } else if (!userEmailController.text.contains('@')) {
      cmethods.displaySnackbar(context, 'please enter a valid email');
    } else if (userPhoneController.text.trim().length < 10) {
      cmethods.displaySnackbar(
          context, 'phone number must be of 10 characters in india');
    } else if (userPasswordController.text.trim().length < 6) {
      cmethods.displaySnackbar(
          context, 'password length should be at least 6 words');
    } else {
      registerNewUser();
    }
  }

  registerNewUser() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      // ignore: non_constant_identifier_names
      builder: (BuildContextcontext) =>
          const LoadingDialog(messageText: 'Registering your account.....'),
    );
    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
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

    // initialize the database with respect to every users unique id
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users').child(userFirebase!.uid);
    // storing the data whatever we want to push in the data base by using map
    Map userDataMap = {
      "name": userNameController.text.trim(),
      "email": userEmailController.text.trim(),
      "phone": userPhoneController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    // save the map data to the firebase storage

    userRef.set(userDataMap);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
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
                " Create a User's account",
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
                      controller: userNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'user name'),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      controller: userPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(labelText: 'user phone'),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
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
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                            horizontal: 75,
                            vertical: 15,
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.purple,
                        ),
                      ),
                      onPressed: () {
                        // checkInternetAvailability();
                        signupFormValidation();
                        print('signup button');
                      },
                      child: const Text('Signup'),
                    ),
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
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Already Have an account? login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
