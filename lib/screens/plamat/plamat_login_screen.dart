import 'package:flutter/material.dart';

class PLAMATLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(210, 180, 17, 17),
            height: 400,
            child: Center(
              child: Icon(
                Icons.lock,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: MediaQuery.of(context).size.height - 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Application Form Log-in',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 236, 183, 23)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Use the account credentials that are sent to your email',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                print('Email: ${_emailController.text}');
                print('Password: ${_passwordController.text}');
              }
            },
            child: Text('View Application Form'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(210, 180, 17, 17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 14, color: const Color.fromARGB(210, 180, 17, 17)),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Change background to white
              side: BorderSide(
                  color:
                  const Color.fromARGB(210, 180, 17, 17)), // Add red border
            ),
          ),
        ],
      ),
    );
  }
}
