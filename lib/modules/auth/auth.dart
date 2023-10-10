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
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 100),
            Icon(Icons.lock, size: 100, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
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
              decoration: const InputDecoration(
                hintText: 'User',
                label: Text('User'),
              ),
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
                  decoration: InputDecoration(
                    hintText: 'Password',
                    label: const Text('Password'),
                    suffix: IconButton(
                      onPressed: () {
                        _showPasswordNotifier.value = !_showPasswordNotifier.value;
                      },
                      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                // validate user
                final isValid = _formKey.currentState!.validate();
                if (!isValid) {
                  showDialog(context: context, builder: (context) => const AlertDialog(content: Text('Invalid user or password')));
                  return;
                }
                Navigator.pushReplacementNamed(context, '/home');
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
