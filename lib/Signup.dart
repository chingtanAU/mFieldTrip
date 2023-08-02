import 'package:mfieldtrip/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        await _auth.currentUser?.updateProfile(displayName: _name);
      } catch (e) {
        // showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35.0),
                const SizedBox(
                  height: 70,
                  child: Image(
                    image: AssetImage("images/logouni.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 250,
                  child: Image(
                    image: AssetImage("images/logo.png"),
                    fit: BoxFit.contain,
                    width: 200,
                    height:200,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                                validator: (input) {
                                  if (input!.isEmpty) return 'Enter Name';
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                onSaved: (input) => _name = input!),
                          ),
                          Container(
                            child: TextFormField(
                                validator: (input) {
                                  if (input!.isEmpty) return 'Enter Email';
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email)),
                                onSaved: (input) => _email = input!),
                          ),
                          Container(
                            child: TextFormField(
                                validator: (input) {
                                  if (input!.length < 6) {
                                    return 'Provide Minimum 6 Character';
                                  return null;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                                onSaved: (input) => _password = input!),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(shape:MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                    ), 
                    // color: Colors.lightGreen,
                    ),
                            // padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                            onPressed: signUp,
                            child: const Text('SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            // color: Colors.lightGreen,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(20.0),
                            // ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: navigateToLogin,
                            child: const Text('Click here to login!',style: TextStyle(fontSize: 15),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
