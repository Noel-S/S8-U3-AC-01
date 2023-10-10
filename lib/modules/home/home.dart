import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  // final String user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String user = '';
  @override
  void initState() {
    // Get arguments from route
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final args = (ModalRoute.of(context)?.settings.arguments ?? '') as String;
      setState(() {
        user = args;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text('Welcome $user'),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Colors.green, size: 50),
                        const SizedBox(height: 10),
                        const Text('Redirecting to login'),
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
                  Navigator.pushReplacementNamed(context, '/auth');
                });
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
