// =====================================================================
// REPAIR FABRICATOR: ALL-INDIA MUTUAL ENTERPRISE PRO APPLICATION
// DIRECTOR & FOUNDER: Saifuddin Sekh
// PACKAGE NAME: com.repair.fabricator
// =====================================================================
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RepairFabricatorEnterpriseApp());
}

class RepairFabricatorEnterpriseApp extends StatelessWidget {
  const RepairFabricatorEnterpriseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repair Fabricator Enterprise',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00E5FF),
        scaffoldBackgroundColor: const Color(0xFF0A0F1D),
      ),
      home: const AllIndiaLanguageSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------------------------------------------------------------
// 1. ALL-INDIA MULTI-LANGUAGE SELECTION SCREEN
// ---------------------------------------------------------------------
class AllIndiaLanguageSelectionScreen extends StatelessWidget {
  const AllIndiaLanguageSelectionScreen({Key? key}) : super(key: key);

  final List> officialLanguages = const [
    {'name': 'English', 'native': 'English (Global)'},
    {'name': 'Hindi', 'native': 'हिन्दी (Hindi - National)'},
    {'name': 'Bengali', 'native': 'বাংলা (Bengali - West Bengal / Nadia)'},
    {'name': 'Tamil', 'native': 'தமிழ் (Tamil)'},
    {'name': 'Telugu', 'native': 'తెలుగు (Telugu)'},
    {'name': 'Malayalam', 'native': 'മലയാളം (Malayalam)'},
    {'name': 'Marathi', 'native': 'मराठी (Marathi)'},
    {'name': 'Gujarati', 'native': 'ગુજરાતી (Gujarati)'},
    {'name': 'Punjabi', 'native': 'ਪੰਜਾਬੀ (Punjabi)'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Fabricator - Select Language', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16)),
        backgroundColor: const Color(0xFF131B2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your preferred language across India:',
              style: TextStyle(fontSize: 15, color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: officialLanguages.length,
                itemBuilder: (context, index) {
                  final lang = officialLanguages[index];
                  return Card(
                    color: const Color(0xFF131B2E),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Color(0xFF00E5FF), width: 0.5),
                    ),
                    child: ListTile(
                      title: Text(lang['native']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Select ${lang['name']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00E5FF)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MandatoryLegalAgreementScreen()),
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
    );
  }
}

// ---------------------------------------------------------------------
// 2. MANDATORY LEGAL ONBOARDING AGREEMENT SCREEN
// ---------------------------------------------------------------------
class MandatoryLegalAgreementScreen extends StatefulWidget {
  const MandatoryLegalAgreementScreen({Key? key}) : super(key: key);

  @override
  _MandatoryLegalAgreementScreenState createState() => _MandatoryLegalAgreementScreenState();
}

class _MandatoryLegalAgreementScreenState extends State<MandatoryLegalAgreementScreen> {
  bool _agreedToTerms = false;

  void _proceedToRegistration(BuildContext context) {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the platform commission and legal terms to proceed!')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecureOnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandatory Legal Agreement', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16)),
        backgroundColor: const Color(0xFF131B2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Binding Terms & Commission Consent',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amberAccent),
            ),
            const SizedBox(height: 15),
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
                      style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  activeColor: const Color(0xFF00E5FF),
                  checkColor: Colors.black,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
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
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _proceedToRegistration(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('ACCEPT & CONTINUE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 3. SECURE ONBOARDING SCREEN
// ---------------------------------------------------------------------
class SecureOnboardingScreen extends StatefulWidget {
  const SecureOnboardingScreen({Key? key}) : super(key: key);

  @override
  _SecureOnboardingScreenState createState() => _SecureOnboardingScreenState();
}

class _SecureOnboardingScreenState extends State<SecureOnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _proceed(BuildContext context) {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your full name and mobile number!')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EcosystemRoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Secure Profile', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16)), backgroundColor: const Color(0xFF131B2E)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'REPAIR FABRICATOR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF), letterSpacing: 1.5),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Full Name',
                filled: true,
                fillColor: const Color(0xFF131B2E),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefixText: '+91 ',
                filled: true,
                fillColor: const Color(0xFF131B2E),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _proceed(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('PROCEED TO ECOSYSTEM ➔', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 4. ROLE SELECTION & MAIN DASHBOARD
// ---------------------------------------------------------------------
class EcosystemRoleSelectionScreen extends StatelessWidget {
  const EcosystemRoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Dashboard', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16)), backgroundColor: const Color(0xFF131B2E)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'DECLARE YOUR PURPOSE',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StructuralProjectInputScreen())),
              icon: const Icon(Icons.apartment, color: Color(0xFF00E5FF)),
              label: const Text('HAVE PROJECTS? ➔ Be a Customer\n(Large Structure, Camera Upload & Weight Calculator)', style: TextStyle(fontSize: 12, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF131B2E),
                padding: const EdgeInsets.all(18),
                side: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 5. LARGE STRUCTURAL PROJECT INPUT & CAMERA UPLOAD SCREEN
// ---------------------------------------------------------------------
class StructuralProjectInputScreen extends StatefulWidget {
  const StructuralProjectInputScreen({Key? key}) : super(key: key);

  @override
  _StructuralProjectInputScreenState createState() => _StructuralProjectInputScreenState();
}

class _StructuralProjectInputScreenState extends State<StructuralProjectInputScreen> {
  final TextEditingController _lengthController = TextEditingController(text: '100');
  final TextEditingController _heightController = TextEditingController(text: '16');
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  bool _imageUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project & Camera Verification', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 16)), backgroundColor: const Color(0xFF131B2E)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber, width: 1),
              ),
              child: const Text(
                '📌 Small repairs start at ₹300. Upload live photo of broken gate/grill or structure for accurate contractor bidding.',
                style: TextStyle(fontSize: 12, color: Colors.amberAccent),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _imageUploaded = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📸 Live Photo Captured & Attached Successfully!')));
              },
              icon: Icon(Icons.camera_alt, color: _imageUploaded ? Colors.greenAccent : Colors.white),
              label: Text(_imageUploaded ? 'Photo Attached (1 File)' : 'Capture Live Photo / Damage Proof', style: const TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _imageUploaded ? Colors.green.shade900 : const Color(0xFF131B2E),
                padding: const EdgeInsets.all(16),
                side: BorderSide(color: _imageUploaded ? Colors.greenAccent : const Color(0xFF00E5FF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
