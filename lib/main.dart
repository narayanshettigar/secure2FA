import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordScreen(),
    );
  }
}

class PasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Authentication')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_passwordController.text == 'password123') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BiometricScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Wrong Password'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: const Text('Verify Password'),
          ),
        ],
      ),
    );
  }
}

class BiometricScreen extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticateWithBiometrics(BuildContext context) async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print("error: ${e}");
    }
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Authentication')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _authenticateWithBiometrics(context),
          child: const Text('Authenticate with Fingerprint'),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: const Center(
        child: Text('Welcome 🫶'),
      ),
    );
  }
}