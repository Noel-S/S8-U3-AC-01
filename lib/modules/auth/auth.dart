import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  // final _user = 'moviles';
  // final _password = 'moviles';
  final _showPasswordNotifier = ValueNotifier<bool>(false);
  final _userFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      final user = prefs.getString('user') ?? '';
      final password = prefs.getString('password') ?? '';
      _userController.text = user;
      _passwordController.text = password;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 100),
            Icon(Icons.lock, size: 100, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 80),
            TextFormField(
              focusNode: _userFocusNode,
              controller: _userController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user';
                }
                // if (value != _user) {
                //   return 'Enter a valid user';
                // }
                return null;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                hintText: 'Enter your user',
                label: Text('User'),
              ),
            ),
            const SizedBox(height: 35),
            ValueListenableBuilder<bool>(
              valueListenable: _showPasswordNotifier,
              builder: (context, showPassword, _) {
                return TextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // if (value != _password) {
                    //   return 'Enter a valid password';
                    // }
                    return null;
                  },
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    label: const Text('Password'),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    suffixIcon: IconButton(
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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 50),
                          const SizedBox(height: 10),
                          const Text('Invalid user'),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ).then((_) {
                    _userFocusNode.requestFocus();
                    // if (_userController.text != _user) {
                    // } else if (_passwordController.text != _password) {
                    //   _passwordFocusNode.requestFocus();
                    // }
                  });
                  return;
                }
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('user', _userController.text);
                  prefs.setString('password', _passwordController.text);
                });
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Colors.green, size: 50),
                        const SizedBox(height: 10),
                        const Text('Valid user, redirecting to home'),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ).then((_) {
                  Navigator.pushReplacementNamed(context, '/home', arguments: _userController.text);
                });
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
