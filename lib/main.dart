// =====================================================================
// REPAIR FABRICATOR: LOCKED OTP, PASSCODE & SMART ECOSYSTEM
// DIRECTOR & FOUNDER: Saifuddin Sekh
// PACKAGE NAME: com.repair.fabricator
// =====================================================================
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  runApp(const RepairFabricatorFinalApp());
}

class RepairFabricatorFinalApp extends StatelessWidget {
  const RepairFabricatorFinalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repair Fabricator Enterprise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00E5FF),
        scaffoldBackgroundColor: const Color(0xFF0A0F1D),
      ),
      home: const AllIndiaLanguageScreen(),
    );
  }
}

/// Responsive frame for mobile, tablet, and large/TV screens
class FullScreenFrame extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const FullScreenFrame({
    Key? key,
    required this.child,
    this.maxWidth = 900,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isWide = size.width >= 720;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF0A0F1D),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isWide ? maxWidth : double.infinity,
            minHeight: size.height,
          ),
          child: child,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 1. ALL-INDIA LANGUAGE SELECTION SCREEN
// ---------------------------------------------------------------------
class AllIndiaLanguageScreen extends StatelessWidget {
  const AllIndiaLanguageScreen({Key? key}) : super(key: key);

  final List<String> languages = const [
    'English (Global)',
    'Hindi (National)',
    'Bengali (West Bengal / Nadia)',
    'Tamil',
    'Telugu',
    'Malayalam',
    'Marathi',
    'Gujarati',
    'Punjabi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Repair Fabricator - Select Language',
          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
      ),
      body: FullScreenFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Choose your preferred language across India:',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF00E5FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color(0xFF131B2E),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFF00E5FF), width: 0.6),
                      ),
                      child: ListTile(
                        title: Text(
                          languages[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Color(0xFF00E5FF),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MandatoryLegalAgreementScreen(
                                selectedLanguage: languages[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 2. MANDATORY LEGAL ONBOARDING AGREEMENT SCREEN
// ---------------------------------------------------------------------
class MandatoryLegalAgreementScreen extends StatefulWidget {
  final String selectedLanguage;

  const MandatoryLegalAgreementScreen({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  State<MandatoryLegalAgreementScreen> createState() =>
      _MandatoryLegalAgreementScreenState();
}

class _MandatoryLegalAgreementScreenState extends State<MandatoryLegalAgreementScreen> {
  bool _agreedToTerms = false;

  void _proceedToLogin() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must agree to the platform commission and legal terms to proceed!'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StrictOtpGateScreen(selectedLanguage: widget.selectedLanguage),
      ),
    );
  }

  @overrideWidget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mandatory Legal Agreement',
          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
      ),
      body: FullScreenFrame(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Binding Terms & Commission Consent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B2E),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amberAccent, width: 1),
                  ),
                  child: ListView(
                    children: const [
                      Text(
                        'By registering on the Repair Fabricator platform, you explicitly agree under the Indian Contract Act, 1872 to the following binding conditions:\n\n'
                        '1. Platform Commission Management: You authorize the platform to auto-split standard management commissions on billing amounts for enterprise administration and secure routing.\n\n'
                        '2. Prohibition of Cash Bypassing: Bypassing official digital or escrow payment channels to execute secret cash transactions is strictly prohibited and leads to immediate account termination.\n\n'
                        '3. 1-Month Complaint Window & Site Returns: All post-payment complaints must be raised strictly within 1 month. Failure to comply with mandatory site return orders for incomplete work will result in penalties.',
                        style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.45),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    activeColor: const Color(0xFF00E5FF),
                    checkColor: Colors.black,
                    onChanged: (bool? value) {
                      setState(() => _agreedToTerms = value ?? false);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the Enterprise Commission & Legal Terms',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _proceedToLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'ACCEPT & CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 3. STRICT NAME + MOBILE + FIREBASE OTP GATE (NO BYPASS ALLOWED)
// ---------------------------------------------------------------------
class StrictOtpGateScreen extends StatefulWidget {
  final String selectedLanguage;

  const StrictOtpGateScreen({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  State<StrictOtpGateScreen> createState() => _StrictOtpGateScreenState();
}

class _StrictOtpGateScreenState extends State<StrictOtpGateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _verificationId;
  bool _otpSent = false;
  bool _isLoading = false;

  void _showMsg(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _sendOtp() async {
    final name = _nameController.text.trim();
    final digitsOnlyPhone = _phoneController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');

    if (name.length < 2) {
      _showMsg('Name is mandatory! Please enter your full name.');
      return;
    }
    if (digitsOnlyPhone.length < 10) {
      _showMsg('Mobile number is mandatory! Enter at least 10 digits.');
      return;
    }

    final String cleanTenDigit = digitsOnlyPhone.length > 10
        ? digitsOnlyPhone.substring(digitsOnlyPhone.length - 10)
        : digitsOnlyPhone;
    final String formattedPhone = '+91$cleanTenDigit';

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
            if (userCred.user != null && mounted) {
              setState(() => _isLoading = false);
              _goToPasscodeSetup(name, formattedPhone);
            }
          } catch (e) {
            if (!mounted) return;
            setState(() => _isLoading = false);
            _showMsg('Auto-verification failed: $e');
            }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!mounted) return;
          setState(() => _isLoading = false);
          _showMsg('OTP Send Failed: ${e.message ?? "Check Firebase Phone Auth & SHA"}');
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!mounted) return;
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
            _isLoading = false;
          });
          _showMsg('6-digit OTP sent to $formattedPhone');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMsg('Firebase Auth Error: $e');
    }
  }

  Future<void> _verifyOtpStrictly() async {
    final name = _nameController.text.trim();
    final digitsOnlyPhone = _phoneController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    final String cleanTenDigit = digitsOnlyPhone.length > 10
        ? digitsOnlyPhone.substring(digitsOnlyPhone.length - 10)
        : digitsOnlyPhone;
    final String formattedPhone = '+91$cleanTenDigit';
    final String code = _otpController.text.trim();

    if (name.length < 2 || cleanTenDigit.length < 10) {
      _showMsg('Name and valid mobile number are required.');
      return;
    }

    if (_verificationId == null || code.length < 4) {
      _showMsg('OTP is mandatory! Enter the OTP sent to your mobile number.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );
      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (userCred.user != null) {
        _goToPasscodeSetup(name, formattedPhone);
      } else {
        _showMsg('OTP verification could not be confirmed.');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMsg('Invalid or expired OTP! Access denied.');
    }
  }

  void _goToPasscodeSetup(String userName, String userPhone) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PasscodeSetupAndLockScreen(
          userName: userName,
          userPhone: userPhone,
          selectedLanguage: widget.selectedLanguage,
        ),
      ),
    );
  }override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MANDATORY OTP VERIFICATION',
          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
        centerTitle: true,
      ),
      body: FullScreenFrame(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Icon(Icons.lock_person, size: 54, color: Color(0xFF00E5FF)),
              const SizedBox(height: 12),
              const Text(
                'NAME, MOBILE & OTP REQUIRED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00E5FF),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'App access stays locked until Name, +91 Mobile, and OTP are verified.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.amberAccent),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                enabled: !_otpSent && !_isLoading,
                decoration: InputDecoration(
                  labelText: 'Full Name (Required)',
                  prefixIcon: const Icon(Icons.person, color: Color(0xFF00E5FF)),
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _phoneController,
                enabled: !_otpSent && !_isLoading,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number (Required)',
                  prefixText: '+91 ',
                  prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF00E5FF)),
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              if (_otpSent) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP Code (Required)',
                    prefixIcon: const Icon(Icons.sms, color: Colors.amberAccent),
                    filled: true,
                    fillColor: const Color(0xFF131B2E),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            setState(() {
                              _otpSent = false;
                              _verificationId = null;
                              _otpController.clear();
                            });
                          },
                    child: const Text(
                      'Change Mobile Number',
                      style: TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () => _otpSent ? _verifyOtpStrictly() : _sendOtp(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black),
                      )
                    : Text(
                        _otpSent ? 'VERIFY OTP & UNLOCK ➔' : 'SEND OTP ➔',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 4. PASSCODE SETUP & LOCK SCREEN
// ---------------------------------------------------------------------
class PasscodeSetupAndLockScreen extends StatefulWidget {
  final String userName;
  final String userPhone;
  final String selectedLanguage;

  const PasscodeSetupAndLockScreen({
    Key? key,
    required this.userName,
    required this.userPhone,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  State<PasscodeSetupAndLockScreen> createState() => _PasscodeSetupAndLockScreenState();
}

class _PasscodeSetupAndLockScreenState extends State<PasscodeSetupAndLockScreen> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  void _savePasscodeAndEnter() {
    final pin = _pinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    if (pin.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Set at least a 4-digit passcode.')),
      );
      return;
    }

    if (pin != confirmPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passcodes do not match!')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RepairFabricatorDashboardScreen(
          userName: widget.userName,
          userPhone: widget.userPhone,
          selectedLanguage: widget.selectedLanguage,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SET APP PASSCODE',
          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
        centerTitle: true,
      ),
      body: FullScreenFrame(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Icon(Icons.pin, size: 54, color: Color(0xFF00E5FF)),
              const SizedBox(height: 12),
              Text(
                'Welcome, ${widget.userName}!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                'Verified: ${widget.userPhone} • ${widget.selectedLanguage}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.amberAccent),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Create 4–6 Digit Passcode',
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF00E5FF)),
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _confirmPinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Confirm Passcode',
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF00E5FF)),
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePasscodeAndEnter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'SAVE & ENTER ECOSYSTEM ➔',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ---------------------------------------------------------------------
// 5. REPAIR FABRICATOR DASHBOARD SCREEN
// ---------------------------------------------------------------------
class RepairFabricatorDashboardScreen extends StatelessWidget {
  final String userName;
  final String userPhone;
  final String selectedLanguage;

  const RepairFabricatorDashboardScreen({
    Key? key,
    required this.userName,
    required this.userPhone,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Repair Fabricator Ecosystem',
          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF00E5FF)),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AllIndiaLanguageScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: FullScreenFrame(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: const Color(0xFF131B2E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF00E5FF), width: 0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Director / Member: $userName',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF)),
                      ),
                      const SizedBox(height: 6),
                      Text('Mobile: $userPhone', style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 4),
                      Text('Language: $selectedLanguage', style: const TextStyle(color: Colors.amberAccent)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: Center(
                  child: Text(
                    'Welding, Fabrication & Repair Service Marketplace Ready.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
