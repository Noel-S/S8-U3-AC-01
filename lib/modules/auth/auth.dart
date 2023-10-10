import 'dart:io';

import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  final _user = 'moviles';
  final _password = 'moveiles';
  final _showPasswordNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: const Text('Login'),
      // ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user';
                }
                if (value != _user) {
                  return 'Enter a valid user';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<bool>(
              valueListenable: _showPasswordNotifier,
              builder: (context, showPassword, _) {
                return TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value != _password) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                  obscureText: showPassword,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                // validate user
              },
              child: const Text('SIGN IN'),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                exit(0);
              },
              child: const Text('EXIT'),
            ),
          ],
        ),
      ),
    );
  }
}
