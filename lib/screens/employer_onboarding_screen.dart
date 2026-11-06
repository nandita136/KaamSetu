import 'package:flutter/material.dart';
import 'employer_home_screen.dart'; 

class EmployerOnboardingScreen extends StatefulWidget {
  const EmployerOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<EmployerOnboardingScreen> createState() => _EmployerOnboardingScreenState();
}

class _EmployerOnboardingScreenState extends State<EmployerOnboardingScreen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  
  String _selectedBusinessType = 'Boutique / Tailoring';
  bool _isKycUploaded = false;

  final List<String> _businessTypes = [
    'Boutique / Tailoring',
    'Handicrafts / Embroidery',
    'Food / Pickle / Papad',
    'Manufacturing / Packaging',
    'Individual / Home-based',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Business Details', 
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const LinearProgressIndicator(
              value: 0.33, // Step 1 of 3 for employer
              backgroundColor: Color(0xFFE9D5FF),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B46C1)),
              minHeight: 8,
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Tell us about your business.\nWe will verify your details for safety.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Business Name
                  const Text('Business / Shop Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _businessNameController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Sunita Boutique',
                      prefixIcon: const Icon(Icons.store, color: Color(0xFF6B46C1)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Owner Name
                  const Text('Owner Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _ownerNameController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Sunita Patel',
                      prefixIcon: const Icon(Icons.person, color: Color(0xFF6B46C1)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Business Type Dropdown
                  const Text('Type of Work', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedBusinessType,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6B46C1)),
                        items: _businessTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBusinessType = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // KYC Upload Section
                  const Text('Upload KYC Document', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 4),
                  const Text('Shop License, GST, or Aadhar Card', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 12),
                  
                  GestureDetector(
                    onTap: () {
                      // Mock file picking
                      setState(() {
                        _isKycUploaded = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Document uploaded successfully! (Mock)')),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _isKycUploaded ? const Color(0xFF6B46C1).withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isKycUploaded ? const Color(0xFF6B46C1) : Colors.grey.shade300,
                          width: _isKycUploaded ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isKycUploaded ? Icons.check_circle : Icons.cloud_upload_outlined,
                            color: _isKycUploaded ? const Color(0xFF6B46C1) : Colors.grey,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _isKycUploaded ? 'kyc_document.jpg (Uploaded)' : 'Tap to upload document',
                              style: TextStyle(
                                color: _isKycUploaded ? const Color(0xFF6B46C1) : Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Continue Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Employer Home Screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const EmployerHomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text('Submit for Verification →', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}