// =====================================================================
// REPAIR FABRICATOR: LOCKED OTP, PASSCODE & SMART ECOSYSTEM
// DIRECTOR & FOUNDER: Saifuddin Sekh
// PACKAGE NAME: com.repair.fabricator
// PART 1 OF 7
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
// PART 2 OF 7: ALL-INDIA LANGUAGE SELECTION SCREEN
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
// PART 3 OF 7: MANDATORY LEGAL ONBOARDING AGREEMENT SCREEN
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

  @override
  Widget build(BuildContext context) {
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
// PART 4 OF 7: STRICT NAME + MOBILE + FIREBASE OTP GATE
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
  }

  @override
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
// PART 5 OF 7: 4-DIGIT PASSCODE SETUP & LOCK SCREEN
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
  String? _savedPasscode;
  bool _isLockMode = false;

  void _showMsg(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _handlePasscodeAction() {
    final pin = _pinController.text.trim();
    if (pin.length < 4) {
      _showMsg('Enter a 4-digit passcode.');
      return;
    }

    if (!_isLockMode) {
      setState(() {
        _savedPasscode = pin;
        _isLockMode = true;
        _pinController.clear();
      });
      _showMsg('4-digit passcode set! Enter it to open the workspace.');
    } else {
      if (pin == _savedPasscode) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FourRoleDashboardScreen(
              userName: widget.userName,
              userPhone: widget.userPhone,
              selectedLanguage: widget.selectedLanguage,
              savedPasscode: _savedPasscode!,
            ),
          ),
        );
      } else {
        _showMsg('Wrong passcode! Try again.');
      }
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLockMode ? 'ENTER PASSCODE' : 'SET APP PASSCODE',
          style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
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
              const Icon(Icons.password, size: 52, color: Colors.amberAccent),
              const SizedBox(height: 12),
              Text(
                _isLockMode ? 'PASSCODE LOCK ACTIVE' : 'CREATE 4-DIGIT PASSCODE',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00E5FF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isLockMode
                    ? 'Enter your passcode to unlock for ${widget.userName}'
                    : 'Set a 4-digit PIN to protect your account and workspace',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, letterSpacing: 10, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: '4-Digit Passcode',
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handlePasscodeAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _isLockMode ? 'UNLOCK WORKSPACE ➔' : 'SAVE PASSCODE ➔',
                  style: const TextStyle(
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
// PART 6 OF 7: 4-ROLE DASHBOARD & QUICK PASSCODE UNLOCK
// ---------------------------------------------------------------------
class FourRoleDashboardScreen extends StatelessWidget {
  final String userName;
  final String userPhone;
  final String selectedLanguage;
  final String savedPasscode;

  const FourRoleDashboardScreen({
    Key? key,
    required this.userName,
    required this.userPhone,
    required this.selectedLanguage,
    required this.savedPasscode,
  }) : super(key: key);

  final List<_RoleProfileItem> _roles = const [
    _RoleProfileItem(
      title: 'Welder',
      subtitle: 'Welding & Repair',
      icon: Icons.bolt,
      accent: Colors.amberAccent,
      emotionNote:
          'Every spark and every drop of sweat carries real skill and pride. Connect directly with genuine repair and fabrication work.',
      highlights: ['Live Job Requests', 'Earnings & Status', 'Repair & Grill Work'],
    ),
    _RoleProfileItem(
      title: 'Contractor',
      subtitle: 'Site & Structure',
      icon: Icons.engineering,
      accent: Color(0xFF00E5FF),
      emotionNote:
          'Big projects mean strong teams, clear planning, and commitment on site. Manage structural work and estimates with confidence.',
      highlights: ['Project Overview', 'Team & Site Tracking', 'Structural Estimation'],
    ),
    _RoleProfileItem(
      title: 'Shop Owner',
      subtitle: 'Workshop & Store',
      icon: Icons.storefront,
      accent: Colors.greenAccent,
      emotionNote:
          'Keep your inventory and materials moving to the right hands every day. Grow your workshop and supply reach smoothly.',
      highlights: ['Gates & Grilles', 'Raw Materials Supply', 'Instant Order Flow'],
    ),
    _RoleProfileItem(
      title: 'All Service',
      subtitle: 'Full Fabrication',
      icon: Icons.miscellaneous_services,
      accent: Colors.orangeAccent,
      emotionNote:
          'From quick home repairs to large structural builds, get transparent weight estimates, photo proof, and fast confirmation.',
      highlights: ['Small Repair (INR 300+)', 'Large Structure Weight', 'Photo & Deal Confirm'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final int crossAxisCount = width >= 650 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SELECT CATEGORY',
          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
        actions: [
          IconButton(
            tooltip: 'Lock Passcode',
            icon: const Icon(Icons.lock, color: Colors.amberAccent),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => _QuickPasscodeUnlockScreen(
                    userName: userName,
                    userPhone: userPhone,
                    selectedLanguage: selectedLanguage,
                    expectedPasscode: savedPasscode,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FullScreenFrame(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00E5FF), width: 0.7),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, color: Colors.greenAccent, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '$userName  •  $userPhone',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _roles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.02,
                ),
                itemBuilder: (context, index) {
                  final item = _roles[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RoleProfileWorkScreen(
                            roleItem: item,
                            userName: userName,
                            userPhone: userPhone,
                            selectedLanguage: selectedLanguage,
                            savedPasscode: savedPasscode,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B2E),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: item.accent.withOpacity(0.8), width: 1.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: item.accent.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(item.icon, size: 28, color: item.accent),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 11, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickPasscodeUnlockScreen extends StatefulWidget {
  final String userName;
  final String userPhone;
  final String selectedLanguage;
  final String expectedPasscode;

  const _QuickPasscodeUnlockScreen({
    Key? key,
    required this.userName,
    required this.userPhone,
    required this.selectedLanguage,
    required this.expectedPasscode,
  }) : super(key: key);

  @override
  State<_QuickPasscodeUnlockScreen> createState() => _QuickPasscodeUnlockScreenState();
}

class _QuickPasscodeUnlockScreenState extends State<_QuickPasscodeUnlockScreen> {
  final TextEditingController _unlockController = TextEditingController();

  void _unlock() {
    if (_unlockController.text.trim() == widget.expectedPasscode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FourRoleDashboardScreen(
            userName: widget.userName,
            userPhone: widget.userPhone,
            selectedLanguage: widget.selectedLanguage,
            savedPasscode: widget.expectedPasscode,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect passcode!')),
      );
    }
  }

  @override
  void dispose() {
    _unlockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCKED', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16)),
        backgroundColor: const Color(0xFF131B2E),
      ),
      body: FullScreenFrame(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Icon(Icons.lock, size: 54, color: Colors.amberAccent),
              const SizedBox(height: 14),
              const Text(
                'ENTER PASSCODE TO CONTINUE',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _unlockController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: '4-Digit Passcode',
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _unlock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'UNLOCK ➔',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleProfileItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String emotionNote;
  final List<String> highlights;

  const _RoleProfileItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.emotionNote,
    required this.highlights,
  });
}
// ---------------------------------------------------------------------
// PART 7 OF 7: ROLE PROFILE, INTELLIGENT ESTIMATOR & CONFIRMATION
// ---------------------------------------------------------------------
class RoleProfileWorkScreen extends StatefulWidget {
  final _RoleProfileItem roleItem;
  final String userName;
  final String userPhone;
  final String selectedLanguage;
  final String savedPasscode;

  const RoleProfileWorkScreen({
    Key? key,
    required this.roleItem,
    required this.userName,
    required this.userPhone,
    required this.selectedLanguage,
    required this.savedPasscode,
  }) : super(key: key);

  @override
  State<RoleProfileWorkScreen> createState() => _RoleProfileWorkScreenState();
}

class _RoleProfileWorkScreenState extends State<RoleProfileWorkScreen> {
  final TextEditingController _lengthController = TextEditingController(text: '10');
  final TextEditingController _heightController = TextEditingController(text: '8');
  final TextEditingController _budgetController = TextEditingController(text: '600');
  final TextEditingController _detailsController = TextEditingController();

  bool _photoAttached = false;
  double _areaSqFt = 0;
  double _estWeight = 0;
  double _ratePerKg = 0;
  String _smartAdvice = '';

  void _recalculateSmart() {
    final l = double.tryParse(_lengthController.text.trim()) ?? 0;
    final h = double.tryParse(_heightController.text.trim()) ?? 0;
    final budget = double.tryParse(_budgetController.text.trim()) ?? 0;

    final area = l * h;
    final weight = area * 0.45;
    final rate = weight > 0 ? (budget / weight) : 0;

    String advice;
    if (weight <= 35 || budget <= 1000) {
      advice = 'Smart Tip: Fits quick repair/small grill scope; clear photo speeds up offers.';
    } else if (weight <= 250) {
      advice = 'Smart Tip: Medium fabrication batch; confirm material gauge & welding rod spec.';
    } else {
      advice = 'Smart Tip: Heavy structural scale; split milestones & verify site access early.';
    }

    setState(() {
      _areaSqFt = area;
      _estWeight = weight;
      _ratePerKg = rate.toDouble();
      _smartAdvice = advice;
    });
  }

  @override
  void initState() {
    super.initState();
    _recalculateSmart();
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _heightController.dispose();
    _budgetController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.roleItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${role.title.toUpperCase()} PROFILE',
          style: TextStyle(color: role.accent, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF131B2E),
      ),
      body: FullScreenFrame(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: role.accent.withOpacity(0.8), width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: role.accent.withOpacity(0.18),
                          child: Icon(role.icon, color: role.accent),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userName,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${role.title} • ${widget.userPhone}',
                                style: TextStyle(fontSize: 12, color: role.accent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      role.emotionNote,
                      style: const TextStyle(fontSize: 13, color: Colors.white70, height: 1.45),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: role.highlights
                          .map(
                            (tag) => Chip(
                              label: Text(tag, style: const TextStyle(fontSize: 11)),
                              backgroundColor: const Color(0xFF0A0F1D),
                              side: BorderSide(color: role.accent.withOpacity(0.5)),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _lengthController,
                keyboardType: TextInputType.number,
                onChanged: (_) => _recalculateSmart(),
                decoration: InputDecoration(
                  labelText: 'Length (ft)',
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                onChanged: (_) => _recalculateSmart(),
                decoration: InputDecoration(
                  labelText: 'Height (ft)',
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                onChanged: (_) => _recalculateSmart(),
                decoration: InputDecoration(
                  labelText: 'Budget / Rate (INR)',
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _detailsController,
                decoration: InputDecoration(
                  labelText: 'Project / Work Details',
                  filled: true,
                  fillColor: const Color(0xFF131B2E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00E5FF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated Weight: ${_estWeight.toStringAsFixed(1)} kg  •  Area: ${_areaSqFt.toStringAsFixed(0)} sq.ft',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00E5FF),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Implied Budget Rate: INR ${_ratePerKg.toStringAsFixed(1)} / kg',
                      style: const TextStyle(fontSize: 12, color: Colors.amberAccent),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _smartAdvice,
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _photoAttached = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Photo attached successfully!')),
                  );
                },
                icon: Icon(
                  _photoAttached ? Icons.check_circle : Icons.camera_alt,
                  color: _photoAttached ? Colors.greenAccent : Colors.white,
                ),
                label: Text(_photoAttached ? 'Photo Attached (1)' : 'Attach Work / Damage Photo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _photoAttached ? Colors.green.shade900 : const Color(0xFF131B2E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color: _photoAttached ? Colors.greenAccent : const Color(0xFF00E5FF),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  final budget = _budgetController.text.trim();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${role.title} confirmed for ${widget.userName} • ${_estWeight.toStringAsFixed(1)} kg • INR $budget',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'CONFIRM & SUBMIT',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
