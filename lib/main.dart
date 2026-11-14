import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const RepairFabricatorApp());
}

class RepairFabricatorApp extends StatelessWidget {
  const RepairFabricatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Repair Fabricator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  bool _otpScreen = false;
  bool _isLoading = false;
  int _timerSeconds = 10;
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _timerSeconds = 10;
      _isLoading = true;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isLoading = false;
          _otpScreen = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP Sent! (Use 123456 to verify)')),
        );
      }
    });
  }

  void _handleNext() {
    if (!_otpScreen && !_isLoading) {
      if (_nameController.text.isEmpty ||
          _phoneController.text.length != 10 ||
          !_emailController.text.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid Name, 10-digit Phone & Email')),
        );
        return;
      }
      _startTimer();
    } else if (_otpScreen) {
      if (_otpController.text.trim() == '123456') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileHomeScreen(
              name: _nameController.text,
              phone: _phoneController.text,
              email: _emailController.text,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong OTP! Enter 6-digit OTP (123456)')),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repair Fabricator'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_otpScreen && !_isLoading) ...[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'Enter Phone Number',
                  prefixText: '+91 ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Enter Email ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ] else if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                'Generating OTP in $_timerSeconds seconds...',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ] else ...[
              Text(
                'OTP sent to ${_phoneController.text}\nEnter 6-digit OTP',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'Enter 6-Digit OTP (123456)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            if (!_isLoading)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    _otpScreen ? 'Verify & Open Profile' : 'Next',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class ProfileHomeScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String email;

  const ProfileHomeScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repair Fabricator Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Profile!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text('Name: $name', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Phone: +91 $phone', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
